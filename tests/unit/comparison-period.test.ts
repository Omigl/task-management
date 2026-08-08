import { describe, it, expect } from "vitest";
import {
  comparisonForRange,
  comparisonPeriodForSpan,
  comparisonSpanDays,
} from "@/lib/dashboard/comparison-period";

const d = (iso: string) => new Date(`${iso}T00:00:00.000Z`);

describe("comparisonSpanDays", () => {
  it("counts the range inclusively (matches the dashboard's end+1day bound)", () => {
    expect(comparisonSpanDays(d("2026-08-08"), d("2026-08-08"))).toBe(1);
    expect(comparisonSpanDays(d("2026-08-02"), d("2026-08-08"))).toBe(7);
    expect(comparisonSpanDays(d("2026-07-10"), d("2026-08-08"))).toBe(30);
  });

  it("never returns a non-positive span for an inverted range", () => {
    expect(comparisonSpanDays(d("2026-08-08"), d("2026-08-01"))).toBe(1);
  });
});

describe("comparisonPeriodForSpan", () => {
  it("maps the canonical lengths to their own period", () => {
    expect(comparisonPeriodForSpan(7)).toBe("week");
    expect(comparisonPeriodForSpan(30)).toBe("month");
    expect(comparisonPeriodForSpan(91)).toBe("quarter");
    expect(comparisonPeriodForSpan(365)).toBe("year");
  });

  it("snaps a custom range to the nearest named period", () => {
    expect(comparisonPeriodForSpan(1)).toBe("week");
    expect(comparisonPeriodForSpan(14)).toBe("week");
    expect(comparisonPeriodForSpan(15)).toBe("month");
    expect(comparisonPeriodForSpan(52)).toBe("month");
    expect(comparisonPeriodForSpan(53)).toBe("quarter");
    expect(comparisonPeriodForSpan(182)).toBe("quarter");
    expect(comparisonPeriodForSpan(183)).toBe("year");
    expect(comparisonPeriodForSpan(900)).toBe("year");
  });
});

describe("comparisonForRange", () => {
  it("captions each period", () => {
    expect(comparisonForRange(d("2026-08-02"), d("2026-08-08")).label).toBe("vs last week");
    expect(comparisonForRange(d("2026-07-10"), d("2026-08-08")).label).toBe("vs last month");
    expect(comparisonForRange(d("2026-05-10"), d("2026-08-08")).label).toBe("vs last quarter");
    expect(comparisonForRange(d("2025-08-09"), d("2026-08-08")).label).toBe("vs last year");
  });

  it("falls back to the dashboard's 30-day default when no range is set", () => {
    expect(comparisonForRange(null, null)).toEqual({
      period: "month",
      label: "vs last month",
      days: 30,
    });
  });

  it("reports the span so the card can explain the exact baseline", () => {
    expect(comparisonForRange(d("2026-08-02"), d("2026-08-08")).days).toBe(7);
  });
});
