import "server-only";
import { getMonthDashboard, type DashboardRow } from "@/lib/queries/attendance-status";
import { getMonthDashboardMerged } from "@/lib/queries/attendance-sheet-report";
import { isSheetEraMonth } from "@/lib/attendance/report-era";

/**
 * THE single resolver for "what the monthly attendance report says".
 *
 * Why this exists: the report has TWO possible sources for a month — the frozen
 * HR-sheet mirror (`attendance_sheet_month`) and the app's own punch grading
 * (`attendance_logs` → `getMonthDashboard`). Until now the era rule lived
 * INLINE in the dashboard page while the xlsx/pdf export routes called
 * `getMonthDashboard` unconditionally, so every sheet-era month exported
 * different numbers than it displayed. July 2026 — the last sheet-era month,
 * and the one with the most real punches to disagree about — diverged hardest
 * (e.g. 26 P / 0 H-D on screen vs 12 P / 12 H/D in the export).
 *
 * Every surface that renders or exports the monthly report MUST go through
 * `getMonthReportRows`. Do not call `getMonthDashboard` / `getMonthDashboardMerged`
 * directly from a page or route — that is exactly how the two drifted apart.
 */

export { SHEET_ERA_LAST_MONTH, isSheetEraMonth, monthKey } from "@/lib/attendance/report-era";

/**
 * The report rows for a month, from whichever source is authoritative for it.
 * Identical output for the dashboard table, the XLSX summary and the PDF —
 * that identity is the whole point.
 */
export async function getMonthReportRows(
  year: number,
  month: number,
  refTodayISO: string,
): Promise<DashboardRow[]> {
  return isSheetEraMonth(year, month)
    ? getMonthDashboardMerged(year, month, refTodayISO)
    : getMonthDashboard(year, month, refTodayISO);
}
