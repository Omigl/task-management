import { describe, it, expect } from "vitest";
import {
  dayShort,
  periodOptionLabel,
  periodOptionsOf,
} from "@/components/goals/review/period-options";

/**
 * The per-card period dropdowns on Goals → Review & Scores. "Today" is always
 * injected (the server resolves it in IST), so these are fully deterministic.
 */

const TODAY = "2026-07-29"; // a Wednesday; FY 2026-27, Q2, W18 of the FY

describe("dayShort", () => {
  it("drops the leading zero and the year", () => {
    expect(dayShort("2026-07-29")).toBe("29 Jul");
    expect(dayShort("2027-01-05")).toBe("5 Jan");
  });
});

describe("periodOptionLabel", () => {
  it("names the day relative to today, else dates it", () => {
    expect(periodOptionLabel("daily", TODAY, TODAY)).toBe("Today · 29 Jul");
    expect(periodOptionLabel("daily", "2026-07-28", TODAY)).toBe("Yesterday · 28 Jul");
    expect(periodOptionLabel("daily", "2026-07-20", TODAY)).toBe("20 Jul 2026");
  });

  it("marks the current FY week and numbers the rest", () => {
    // The Monday of 29 Jul 2026 is 27 Jul.
    expect(periodOptionLabel("weekly", "2026-07-27", TODAY)).toMatch(/^This week · W\d+$/);
    expect(periodOptionLabel("weekly", "2026-07-20", TODAY)).toMatch(/^W\d+ · 20 Jul$/);
  });

  it("spells the month out in full", () => {
    expect(periodOptionLabel("monthly", "2026-07", TODAY)).toBe("July 2026");
    expect(periodOptionLabel("monthly", "2027-03", TODAY)).toBe("March 2027");
  });

  it("labels a quarter with its FY month span", () => {
    expect(periodOptionLabel("quarterly", "2026-Q1", TODAY)).toBe("Q1 · Apr–Jun");
    expect(periodOptionLabel("quarterly", "2026-Q2", TODAY)).toBe("Q2 · Jul–Sep");
    expect(periodOptionLabel("quarterly", "2026-Q4", TODAY)).toBe("Q4 · Jan–Mar");
  });

  it("labels a year as the financial year", () => {
    expect(periodOptionLabel("yearly", "2026", TODAY)).toBe("FY 2026–27");
  });
});

describe("periodOptionsOf", () => {
  it("leads with an 'all' option carrying the row count", () => {
    const rows = [{ periodKey: "2026-07" }, { periodKey: "2026-07" }, { periodKey: "2026-08" }];
    const opts = periodOptionsOf("monthly", rows, TODAY);
    expect(opts[0]).toEqual({ value: "", label: "All months (3)" });
  });

  it("de-duplicates periods and orders rolling levels newest-first", () => {
    const rows = [{ periodKey: "2026-07" }, { periodKey: "2026-09" }, { periodKey: "2026-07" }];
    expect(periodOptionsOf("monthly", rows, TODAY).map((o) => o.value)).toEqual([
      "",
      "2026-09",
      "2026-07",
    ]);
  });

  it("orders quarters and years in FY order", () => {
    const quarters = [{ periodKey: "2026-Q3" }, { periodKey: "2026-Q1" }, { periodKey: "2026-Q2" }];
    expect(periodOptionsOf("quarterly", quarters, TODAY).map((o) => o.value)).toEqual([
      "",
      "2026-Q1",
      "2026-Q2",
      "2026-Q3",
    ]);
    const years = [{ periodKey: "2027" }, { periodKey: "2026" }];
    expect(periodOptionsOf("yearly", years, TODAY).map((o) => o.value)).toEqual([
      "",
      "2026",
      "2027",
    ]);
  });

  it("still offers the 'all' option when the level is empty", () => {
    expect(periodOptionsOf("daily", [], TODAY)).toEqual([{ value: "", label: "All days (0)" }]);
  });

  it("only ever offers periods that rows actually sit in", () => {
    const rows = [{ periodKey: "2026-07-29" }, { periodKey: "2026-07-28" }];
    const opts = periodOptionsOf("daily", rows, TODAY);
    expect(opts.map((o) => o.label)).toEqual([
      "All days (2)",
      "Today · 29 Jul",
      "Yesterday · 28 Jul",
    ]);
  });
});
