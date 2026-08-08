/**
 * Which record is authoritative for a given attendance month. PURE policy —
 * no DB, no `server-only` — so the page, the export routes and the tests all
 * read the rule from one place (see lib/attendance/month-report.ts for the
 * loader that acts on it).
 */

/**
 * Last month sourced from the HR "Attendance log" sheet. From the month AFTER
 * this one, the app's own punches are the sole source of truth.
 *
 * Kept as a `YYYY-MM` string so it sorts lexicographically and reads the same
 * way as the salary module's era checks (`month >= "2026-08"` in
 * lib/salary/generate.ts), which must stay in lockstep with this value.
 */
export const SHEET_ERA_LAST_MONTH = "2026-07" as const;

/** `YYYY-MM` for a 1-12 month. Zero-padded so string comparison orders months
 *  correctly ("2026-06" < "2026-07" < "2026-12"). */
export function monthKey(year: number, month: number): string {
  return `${year}-${String(month).padStart(2, "0")}`;
}

/** Is this month sourced from the frozen HR sheet (locked counts) rather than
 *  the live punch grader? */
export function isSheetEraMonth(year: number, month: number): boolean {
  return monthKey(year, month) <= SHEET_ERA_LAST_MONTH;
}
