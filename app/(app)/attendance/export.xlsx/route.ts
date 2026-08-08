import * as XLSX from "xlsx";
import { requireUser } from "@/lib/auth/current";
import { isFinanceViewer } from "@/lib/auth/finance-access";
import { localDateString } from "@/lib/format";
import { getEmployeeMonthStatus } from "@/lib/queries/attendance-status";
import { getMonthReportRows } from "@/lib/attendance/month-report";
import { getSheetDayCodesForMonth } from "@/lib/queries/attendance-sheet-report";
import {
  SUMMARY_HEADERS,
  toSummaryRow,
  matrixHeaders,
  toMatrixRow,
  toSheetMatrixRow,
  attendanceExportFilename,
  monthTitle,
} from "@/lib/exports/attendance-rich";

/**
 * GET /attendance/export.xlsx?y=&m=
 *
 * Admin-only XLSX of the month attendance dashboard. Two sheets:
 *  - "Summary": one humanized row per active employee (Present/Absent/…/Payable).
 *  - "Daily Matrix": Employee × day-of-month → attendance code (P / H/D / A / W/O / …).
 *
 * Both sheets are built from `getMonthReportRows` — the SAME resolver the
 * dashboard page renders — so the export reconciles 1:1 with the screen. It
 * previously called `getMonthDashboard` directly, which ignored the HR-sheet
 * era and made every sheet-backed month (through July 2026) export numbers the
 * UI never showed.
 */
export const runtime = "nodejs";
export const dynamic = "force-dynamic";

const DEFAULT_TZ = "Asia/Kolkata";

function resolveYM(url: URL): { year: number; month: number } {
  const todayISO = localDateString(DEFAULT_TZ);
  const [cy, cm] = todayISO.split("-").map(Number);
  const rawY = Number(url.searchParams.get("y"));
  const rawM = Number(url.searchParams.get("m"));
  const year =
    Number.isInteger(rawY) && rawY >= 2000 && rawY <= 2100 ? rawY : (cy ?? 2026);
  const month =
    Number.isInteger(rawM) && rawM >= 1 && rawM <= 12 ? rawM : (cm ?? 1);
  return { year, month };
}

export async function GET(request: Request): Promise<Response> {
  let me;
  try {
    me = await requireUser();
  } catch {
    return new Response("Forbidden", { status: 403 });
  }
  if (!(await isFinanceViewer(me))) return new Response("Forbidden", { status: 403 });

  const url = new URL(request.url);
  const { year, month } = resolveYM(url);
  const todayISO = localDateString(DEFAULT_TZ);

  const rows = await getMonthReportRows(year, month, todayISO);

  // Summary sheet.
  const summaryAoa: (string | number)[][] = [
    [monthTitle(year, month)],
    [...SUMMARY_HEADERS],
    ...rows.map(toSummaryRow),
  ];
  const summaryWs = XLSX.utils.aoa_to_sheet(summaryAoa);
  summaryWs["!cols"] = [
    { wch: 26 },
    ...Array(SUMMARY_HEADERS.length - 1).fill({ wch: 12 }),
  ];

  // Daily matrix sheet. Each row's day cells MUST come from the same record
  // that produced its summary row, or the matrix contradicts the totals sitting
  // next to it:
  //   • source "sheet" → the sheet's own day codes (one batched query for the
  //     whole month), canonicalized into the app's code alphabet. This is what
  //     the on-screen drill-down (SheetDailyDialog) shows for these people.
  //     Using the punch grader here also silently blanked sheet rows whose name
  //     never resolved to an employee — their `employeeId` is a sheet row id,
  //     so getEmployeeMonthStatus found no employee and returned zero days.
  //   • source "app"   → the punch grading, as before.
  const sheetDayCodes = rows.some((r) => r.source === "sheet")
    ? await getSheetDayCodesForMonth(year, month)
    : new Map<string, Map<number, string>>();

  // App-sourced rows are loaded SEQUENTIALLY on purpose: each call itself fans
  // out several queries via Promise.all, so a `Promise.all` over the whole
  // roster (~21 people) would burst ~60+ concurrent queries against a pool of
  // 10 and could starve the protected dashboard path during business hours. An
  // admin export is not latency-critical, so we trade a little wall-clock for
  // pool safety.
  const matrixRows: string[][] = [];
  for (const r of rows) {
    if (r.source === "sheet") {
      matrixRows.push(
        toSheetMatrixRow(
          r.name,
          sheetDayCodes.get(r.name.trim().toLowerCase()),
          year,
          month,
        ),
      );
      continue;
    }
    const detail = await getEmployeeMonthStatus(r.employeeId, year, month, todayISO);
    matrixRows.push(toMatrixRow(r.name, detail, year, month));
  }
  const matrixAoa: string[][] = [matrixHeaders(year, month), ...matrixRows];
  const matrixWs = XLSX.utils.aoa_to_sheet(matrixAoa);
  matrixWs["!cols"] = [
    { wch: 26 },
    ...Array(matrixAoa[0]!.length - 1).fill({ wch: 4 }),
  ];

  const wb = XLSX.utils.book_new();
  XLSX.utils.book_append_sheet(wb, summaryWs, "Summary");
  XLSX.utils.book_append_sheet(wb, matrixWs, "Daily Matrix");

  const buffer: Buffer = XLSX.write(wb, { type: "buffer", bookType: "xlsx" });

  return new Response(new Uint8Array(buffer), {
    status: 200,
    headers: {
      "content-type":
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
      "content-disposition": `attachment; filename="${attendanceExportFilename(year, month, "xlsx")}"`,
      "cache-control": "no-store",
    },
  });
}
