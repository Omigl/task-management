/**
 * Comparison period for the WMS dashboard KPI cards.
 *
 * The global filter bar exposes a free date RANGE (not a Week/Month/Quarter/Year
 * segmented control), so the period is derived from the span the user picked.
 * The card's delta compares the selected window against the immediately
 * preceding window of the same length — this module names that window so the
 * card can say "vs last month" instead of a bare "vs last".
 */

const MS_PER_DAY = 24 * 60 * 60 * 1000;

export type ComparisonPeriod = "week" | "month" | "quarter" | "year";

export interface ComparisonMeta {
  period: ComparisonPeriod;
  /** Ready-to-render card text, e.g. "vs last month". */
  label: string;
  /** Inclusive length of the selected range, in days. */
  days: number;
}

/**
 * Inclusive day count of the selected range. Matches the dashboard query, which
 * scopes on `createdAt >= start AND createdAt < end + 1 day` — so a start==end
 * range is one day, not zero.
 */
export function comparisonSpanDays(start: Date, end: Date): number {
  const startDay = Date.UTC(start.getUTCFullYear(), start.getUTCMonth(), start.getUTCDate());
  const endDay = Date.UTC(end.getUTCFullYear(), end.getUTCMonth(), end.getUTCDate());
  const days = Math.floor((endDay - startDay) / MS_PER_DAY) + 1;
  return days > 0 ? days : 1;
}

// Cut-points sit at the geometric midpoint between the canonical lengths
// (7 / 30 / 91 / 365 days), so an arbitrary custom range snaps to whichever
// named period it's closest to on a ratio basis rather than an absolute one.
const WEEK_MAX = 15; // √(7·30)  ≈ 14.5
const MONTH_MAX = 53; // √(30·91) ≈ 52.2
const QUARTER_MAX = 183; // √(91·365) ≈ 182.2

export function comparisonPeriodForSpan(days: number): ComparisonPeriod {
  if (days < WEEK_MAX) return "week";
  if (days < MONTH_MAX) return "month";
  if (days < QUARTER_MAX) return "quarter";
  return "year";
}

export function comparisonPeriodLabel(period: ComparisonPeriod): string {
  return `vs last ${period}`;
}

/** Everything a KPI card needs to caption its delta, from the active filters. */
export function comparisonForRange(
  start: Date | null | undefined,
  end: Date | null | undefined,
): ComparisonMeta {
  // No range selected → the dashboard's own 30-day default window.
  if (!start || !end) {
    return { period: "month", label: comparisonPeriodLabel("month"), days: 30 };
  }
  const days = comparisonSpanDays(start, end);
  const period = comparisonPeriodForSpan(days);
  return { period, label: comparisonPeriodLabel(period), days };
}
