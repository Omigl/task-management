import { describe, it, expect } from "vitest";
import {
  SUMMARY_HEADERS,
  toSummaryRow,
  toMatrixRow,
  toSheetMatrixRow,
  matrixHeaders,
  normalizeSheetCode,
  tallyMatrixRow,
  summaryTally,
  daysInMonth,
} from "@/lib/exports/attendance-rich";
import { isSheetEraMonth, SHEET_ERA_LAST_MONTH } from "@/lib/attendance/report-era";
import type {
  DashboardRow,
  DayRow,
  EmployeeMonthStatus,
  MonthSummary,
} from "@/lib/queries/attendance-status";
import { ATTENDANCE_CODE_VALUES, type AttendanceCode } from "@/db/enums";

/**
 * Attendance export reconciliation.
 *
 * The bug this pins down: the dashboard page resolved sheet-era months through
 * `getMonthDashboardMerged` (frozen HR-sheet counts) while the xlsx/pdf routes
 * called `getMonthDashboard` (live punch grading) unconditionally. July 2026 —
 * the last sheet-era month — diverged hardest: 26 P / 0 H-D on screen vs
 * 12 P / 12 H/D in the export for the same person.
 *
 * These tests assert the two invariants that make that impossible to
 * reintroduce:
 *   1. the era rule is one shared function, and July 2026 resolves to "sheet";
 *   2. every exported Daily-Matrix row tallies EXACTLY to its Summary row —
 *      for app-sourced AND sheet-sourced people, over a 31-day month.
 */

const JULY = { year: 2026, month: 7 } as const;

// ── fixtures ────────────────────────────────────────────────────────────────

function summaryFrom(partial: Partial<MonthSummary>): MonthSummary {
  return {
    payableDays: 0, present: 0, absent: 0, halfDay: 0, weeklyOff: 0,
    incomplete: 0, late: 0, lateRaw: 0, leftEarly: 0, lateWaived: 0,
    holiday: 0, holidayPresent: 0, holidayHalfDay: 0, paidLeave: 0,
    unpaidLeave: 0, compOff: 0, totalWorkedMinutes: 0,
    ...partial,
  };
}

/** Build an EmployeeMonthStatus from a day-1..N list of codes, tallying the
 *  summary the same way the query layer does (code → field, Σ day values). */
function appStatusFromCodes(
  year: number,
  month: number,
  codes: readonly AttendanceCode[],
): EmployeeMonthStatus {
  const days: DayRow[] = codes.map((code, i) => ({
    logDate: `${year}-${String(month).padStart(2, "0")}-${String(i + 1).padStart(2, "0")}`,
    weekday: new Date(Date.UTC(year, month - 1, i + 1)).getUTCDay(),
    inAt: null,
    outAt: null,
    isWeeklyOff: code === "W/O",
    code,
    dayValue: ATTENDANCE_CODE_VALUES[code],
    late: false,
    leftEarly: false,
    lateWaived: false,
    workedMinutes: 0,
  }));

  const s = summaryFrom({});
  const field: Record<AttendanceCode, keyof MonthSummary> = {
    "P": "present", "A": "absent", "H/D": "halfDay", "W/O": "weeklyOff",
    "H": "holiday", "HP": "holidayPresent", "H-H/D": "holidayHalfDay",
    "PL": "paidLeave", "LWP": "unpaidLeave", "CO": "compOff",
    "incomplete": "incomplete",
  };
  for (const d of days) {
    const k = field[d.code as AttendanceCode];
    (s[k] as number) += 1;
    s.payableDays += d.dayValue;
  }
  s.payableDays = Math.round(s.payableDays * 100) / 100;
  return { employeeId: "emp-1", days, summary: s };
}

// ── 1. the era rule is shared and correct ───────────────────────────────────

describe("sheet-era resolution", () => {
  it("treats July 2026 — the reported divergence month — as sheet-era", () => {
    expect(isSheetEraMonth(2026, 7)).toBe(true);
    expect(SHEET_ERA_LAST_MONTH).toBe("2026-07");
  });

  it("switches to app-native from August 2026", () => {
    expect(isSheetEraMonth(2026, 8)).toBe(false);
    expect(isSheetEraMonth(2026, 12)).toBe(false);
    expect(isSheetEraMonth(2027, 1)).toBe(false);
  });

  it("keeps every earlier month on the frozen sheet", () => {
    expect(isSheetEraMonth(2026, 1)).toBe(true);
    expect(isSheetEraMonth(2025, 12)).toBe(true);
    // Zero-padding: month 7 must not compare as "2026-7" > "2026-12".
    expect(isSheetEraMonth(2026, 6)).toBe(true);
  });
});

// ── 2. July has 31 columns ──────────────────────────────────────────────────

describe("month-boundary handling", () => {
  it("gives July 2026 all 31 day columns", () => {
    expect(daysInMonth(2026, 7)).toBe(31);
    const headers = matrixHeaders(JULY.year, JULY.month);
    expect(headers).toHaveLength(32); // "Employee" + 31 days
    expect(headers[1]).toBe("1");
    expect(headers[31]).toBe("31");
  });

  it("gets February and 30-day months right too", () => {
    expect(daysInMonth(2026, 2)).toBe(28);
    expect(daysInMonth(2028, 2)).toBe(29); // leap
    expect(daysInMonth(2026, 6)).toBe(30);
  });
});

// ── 3. sheet code canonicalization ──────────────────────────────────────────

describe("normalizeSheetCode", () => {
  it("maps the sheet's holiday-worked spellings onto the app's HP", () => {
    expect(normalizeSheetCode("H-P")).toBe("HP");
    expect(normalizeSheetCode("h-p")).toBe("HP");
    expect(normalizeSheetCode(" H-P ")).toBe("HP");
  });

  it("canonicalizes the punctuated codes", () => {
    expect(normalizeSheetCode("H-H/D")).toBe("H-H/D");
    expect(normalizeSheetCode("hd")).toBe("H/D");
    expect(normalizeSheetCode("wo")).toBe("W/O");
    expect(normalizeSheetCode("W/O")).toBe("W/O");
  });

  it("treats empty and dash cells as no-record", () => {
    for (const raw of ["", " ", "-", "–", "—"]) {
      expect(normalizeSheetCode(raw)).toBe("");
    }
  });

  it("passes an unrecognised code through instead of dropping it", () => {
    // Must stay visible in the export and countable as `unknown`, not blanked.
    expect(normalizeSheetCode("XYZ")).toBe("XYZ");
    expect(tallyMatrixRow(["n", "XYZ"]).unknown).toBe(1);
  });
});

// ── 4. THE reconciliation test — matrix Σ == summary, 1:1 ───────────────────

describe("Daily Matrix reconciles with the Summary sheet (July 2026, 31 days)", () => {
  it("app-sourced row: every day code tallies into its summary counts", () => {
    // A full 31-day July: 26 working days present, 4 weekly-offs, 1 holiday.
    const codes: AttendanceCode[] = [
      ...Array<AttendanceCode>(26).fill("P"),
      ...Array<AttendanceCode>(4).fill("W/O"),
      "H",
    ];
    const detail = appStatusFromCodes(JULY.year, JULY.month, codes);
    const row: DashboardRow = {
      employeeId: "emp-1",
      name: "Atul Asthana",
      designation: null,
      department: null,
      managerId: null,
      summary: detail.summary,
      source: "app",
    };

    const matrixRow = toMatrixRow(row.name, detail, JULY.year, JULY.month);
    expect(matrixRow).toHaveLength(32);
    expect(tallyMatrixRow(matrixRow)).toEqual(summaryTally(row.summary));
  });

  it("app-sourced row with half-days, leave and comp-off still reconciles", () => {
    const codes: AttendanceCode[] = [
      ...Array<AttendanceCode>(12).fill("P"),
      ...Array<AttendanceCode>(8).fill("H/D"),
      ...Array<AttendanceCode>(4).fill("W/O"),
      "A", "PL", "LWP", "CO", "HP", "H-H/D", "incomplete",
    ];
    expect(codes).toHaveLength(31);
    const detail = appStatusFromCodes(JULY.year, JULY.month, codes);
    const matrixRow = toMatrixRow("Mixed Person", detail, JULY.year, JULY.month);

    const tally = tallyMatrixRow(matrixRow);
    expect(tally).toEqual(summaryTally(detail.summary));
    // Half-days count as 0.5 — payable must not round to a whole day.
    expect(tally.halfDay).toBe(8);
    expect(tally.payableDays).toBe(detail.summary.payableDays);
    expect(tally.unknown).toBe(0);
  });

  it("sheet-sourced row: the sheet's own day codes tally to the sheet's own summary", () => {
    // The reported case. The HR sheet says 26 present, 0 half-days — the punch
    // grader said 12 P / 12 H/D. The export must follow the sheet, like the UI.
    const dayCodes = new Map<number, string>();
    for (let d = 1; d <= 26; d++) dayCodes.set(d, "P");
    for (let d = 27; d <= 30; d++) dayCodes.set(d, "W/O");
    dayCodes.set(31, "H-P"); // sheet spelling of HP

    const sheetSummary = summaryFrom({
      present: 26,
      weeklyOff: 4,
      holidayPresent: 1,
      halfDay: 0,
      absent: 0,
      payableDays: 26 * 1 + 4 * 1 + 1 * 2, // P=1, W/O=1, HP=2
    });

    const matrixRow = toSheetMatrixRow(
      "Atul Asthana",
      dayCodes,
      JULY.year,
      JULY.month,
    );
    expect(matrixRow).toHaveLength(32);
    expect(tallyMatrixRow(matrixRow)).toEqual(summaryTally(sheetSummary));

    // And the summary sheet itself carries the UI's numbers, not the grader's.
    const summaryRow = toSummaryRow({
      employeeId: "emp-1",
      name: "Atul Asthana",
      designation: null,
      department: null,
      managerId: null,
      summary: sheetSummary,
      source: "sheet",
    });
    expect(summaryRow[SUMMARY_HEADERS.indexOf("Present")]).toBe(26);
    expect(summaryRow[SUMMARY_HEADERS.indexOf("Half-Day")]).toBe(0);
  });

  it("sheet row with missing day cells renders blanks, not dropped columns", () => {
    // A mid-month joiner's sheet row has no cells before their DOJ.
    const dayCodes = new Map<number, string>();
    for (let d = 15; d <= 31; d++) dayCodes.set(d, "P");

    const matrixRow = toSheetMatrixRow("Late Joiner", dayCodes, JULY.year, JULY.month);
    expect(matrixRow).toHaveLength(32);
    expect(matrixRow.slice(1, 15).every((c) => c === "")).toBe(true);
    expect(tallyMatrixRow(matrixRow).present).toBe(17);
  });

  it("a sheet row with NO day data at all yields a blank row, not a crash", () => {
    const matrixRow = toSheetMatrixRow("Unmatched Name", undefined, JULY.year, JULY.month);
    expect(matrixRow).toHaveLength(32);
    expect(matrixRow.slice(1).every((c) => c === "")).toBe(true);
    expect(tallyMatrixRow(matrixRow)).toEqual(summaryTally(summaryFrom({})));
  });

  it("summary headers stay aligned with the row mapper", () => {
    const row = toSummaryRow({
      employeeId: "e",
      name: "N",
      designation: null,
      department: null,
      managerId: null,
      summary: summaryFrom({ present: 1, payableDays: 1 }),
    });
    expect(row).toHaveLength(SUMMARY_HEADERS.length);
  });
});
