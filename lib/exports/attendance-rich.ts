import type {
  DashboardRow,
  EmployeeMonthStatus,
  MonthSummary,
} from "@/lib/queries/attendance-status";
import { ATTENDANCE_CODE_VALUES, type AttendanceCode } from "@/db/enums";

/**
 * Attendance report mappers (Task A7). Pure (no DB / no server-only) so the
 * xlsx + pdf routes — and any future test — share one humanized projection of
 * the month dashboard.
 */

const MONTH_LABELS = [
  "January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December",
] as const;

/** "June 2026" for a 1-12 month. */
export function monthTitle(year: number, month: number): string {
  return `${MONTH_LABELS[month - 1] ?? ""} ${year}`.trim();
}

/** Filename stem like "attendance-2026-06". */
export function attendanceExportFilename(
  year: number,
  month: number,
  ext: "xlsx" | "pdf",
): string {
  const mm = String(month).padStart(2, "0");
  return `Attendance-${year}-${mm}.${ext}`;
}

// ── Summary sheet ────────────────────────────────────────────────────────────

export const SUMMARY_HEADERS = [
  "Employee",
  "Present",
  "Absent",
  "Half-Day",
  "Late",
  "Left-Early",
  "Late-Waived",
  "Weekly-Off",
  "Holiday",
  "Holiday-Present",
  "Paid-Leave",
  "Unpaid-Leave",
  "Comp-Off",
  "Payable-Days",
] as const;

/** One dashboard row → the summary AOA row (strings/numbers). */
export function toSummaryRow(r: DashboardRow): (string | number)[] {
  const s = r.summary;
  return [
    r.name,
    s.present,
    s.absent,
    s.halfDay,
    s.late,
    s.leftEarly,
    s.lateWaived,
    s.weeklyOff,
    s.holiday,
    s.holidayPresent,
    s.paidLeave,
    s.unpaidLeave,
    s.compOff,
    s.payableDays,
  ];
}

// ── Matrix sheet (Employee × day-of-month → code) ────────────────────────────

/** Number of days in a 1-12 month. */
export function daysInMonth(year: number, month: number): number {
  return new Date(Date.UTC(year, month, 0)).getUTCDate();
}

/** Header row for the matrix sheet: "Employee", "1", "2", … */
export function matrixHeaders(year: number, month: number): string[] {
  const n = daysInMonth(year, month);
  const out: string[] = ["Employee"];
  for (let d = 1; d <= n; d++) out.push(String(d));
  return out;
}

/** The printable per-day cell for one DayRow. "–" (not joined) → "". */
export function dayCell(code: EmployeeMonthStatus["days"][number]["code"]): string {
  return code === "–" ? "" : code;
}

/**
 * One employee's matrix row: their name followed by one cell per calendar day.
 * `detail.days` is the full month walk (one row per day) from
 * getEmployeeMonthStatus, already in day order.
 */
export function toMatrixRow(
  name: string,
  detail: EmployeeMonthStatus,
  year: number,
  month: number,
): string[] {
  const n = daysInMonth(year, month);
  const byDay = new Map<number, string>();
  for (const d of detail.days) {
    const dd = parseInt(d.logDate.slice(8, 10), 10);
    byDay.set(dd, dayCell(d.code));
  }
  const row: string[] = [name];
  for (let d = 1; d <= n; d++) row.push(byDay.get(d) ?? "");
  return row;
}

// ── Sheet-sourced matrix rows ────────────────────────────────────────────────

/**
 * Canonicalize a RAW HR-sheet day code into the app's `AttendanceCode`
 * alphabet, so the matrix speaks ONE language regardless of which source the
 * row came from.
 *
 * The sheet is a human-maintained spreadsheet: cells arrive verbatim
 * (`lib/attendance-log/attendance-sheet.ts` stores `statusCode: raw`, trimmed
 * only), so casing and spacing vary and the holiday-worked code is written
 * `H-P` where the app enum uses `HP`. Unmapped values are passed through
 * upper-cased rather than dropped — an unrecognised code must stay VISIBLE in
 * the export (and countable as "other" in reconciliation) instead of silently
 * vanishing into a blank cell the way a `?? ""` fallback would.
 *
 * Empty / "-" / "–" mean "no record for this day" → "".
 */
export function normalizeSheetCode(raw: string): string {
  const c = raw.trim().toUpperCase();
  if (c === "" || c === "-" || c === "–" || c === "—") return "";
  switch (c) {
    case "H-P":
    case "POH":
      return "HP";
    case "H-H/D":
    case "H-HD":
      return "H-H/D";
    case "HD":
      return "H/D";
    case "WO":
    case "W-O":
      return "W/O";
    default:
      return c;
  }
}

/**
 * One SHEET-sourced employee's matrix row. `dayCodes` is day-of-month → raw
 * sheet code (from `getSheetDayCodesForMonth`). Codes are canonicalized so the
 * cell text matches an app-sourced row's.
 */
export function toSheetMatrixRow(
  name: string,
  dayCodes: Map<number, string> | undefined,
  year: number,
  month: number,
): string[] {
  const n = daysInMonth(year, month);
  const row: string[] = [name];
  for (let d = 1; d <= n; d++) {
    row.push(normalizeSheetCode(dayCodes?.get(d) ?? ""));
  }
  return row;
}

// ── Reconciliation (matrix ⇄ summary) ────────────────────────────────────────

/** The count fields a Daily-Matrix row can be tallied into. Mirrors the
 *  comparable subset of `MonthSummary` (everything a per-day code can imply). */
export interface MatrixTally {
  present: number;
  absent: number;
  halfDay: number;
  weeklyOff: number;
  holiday: number;
  holidayPresent: number;
  holidayHalfDay: number;
  paidLeave: number;
  unpaidLeave: number;
  compOff: number;
  incomplete: number;
  /** Σ of each code's day value — the payable day-count implied by the row. */
  payableDays: number;
  /** Cells whose code is in neither alphabet (bad sheet data). Non-zero here
   *  means the matrix is showing something the summary can't account for. */
  unknown: number;
}

const CODE_TO_FIELD: Record<AttendanceCode, keyof MatrixTally> = {
  "P": "present",
  "A": "absent",
  "H/D": "halfDay",
  "W/O": "weeklyOff",
  "H": "holiday",
  "HP": "holidayPresent",
  "H-H/D": "holidayHalfDay",
  "PL": "paidLeave",
  "LWP": "unpaidLeave",
  "CO": "compOff",
  "incomplete": "incomplete",
};

function emptyTally(): MatrixTally {
  return {
    present: 0, absent: 0, halfDay: 0, weeklyOff: 0, holiday: 0,
    holidayPresent: 0, holidayHalfDay: 0, paidLeave: 0, unpaidLeave: 0,
    compOff: 0, incomplete: 0, payableDays: 0, unknown: 0,
  };
}

/**
 * Tally the day cells of a matrix row (the row INCLUDING its leading name
 * cell, exactly as written to the sheet). Blank cells — not joined yet, or no
 * sheet record — count toward nothing.
 *
 * This is the reconciliation primitive: a correct export satisfies
 * `tallyMatrixRow(row)` ≡ `summaryTally(summaryRowForSamePerson)`.
 */
export function tallyMatrixRow(row: readonly string[]): MatrixTally {
  const t = emptyTally();
  for (const cell of row.slice(1)) {
    const code = cell.trim();
    if (code === "") continue;
    const field = CODE_TO_FIELD[code as AttendanceCode];
    if (!field) {
      t.unknown += 1;
      continue;
    }
    t[field] += 1;
    t.payableDays += ATTENDANCE_CODE_VALUES[code as AttendanceCode];
  }
  // Float noise: 0.5-valued half-days summed across a month.
  t.payableDays = Math.round(t.payableDays * 100) / 100;
  return t;
}

/** The same shape, projected out of a summary row, for a 1:1 comparison. */
export function summaryTally(s: MonthSummary): MatrixTally {
  return {
    present: s.present,
    absent: s.absent,
    halfDay: s.halfDay,
    weeklyOff: s.weeklyOff,
    holiday: s.holiday,
    holidayPresent: s.holidayPresent,
    holidayHalfDay: s.holidayHalfDay,
    paidLeave: s.paidLeave,
    unpaidLeave: s.unpaidLeave,
    compOff: s.compOff,
    incomplete: s.incomplete,
    payableDays: Math.round(s.payableDays * 100) / 100,
    unknown: 0,
  };
}
