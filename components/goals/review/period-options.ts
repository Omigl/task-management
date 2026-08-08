/**
 * Period options for the Goals → Review & Scores frequency cards.
 *
 * Each card (Daily / Weekly / Monthly / Quarterly / Yearly) carries its own
 * period dropdown. The options are built from the periods the level's rows
 * ACTUALLY sit in — so a pick can never land on an empty bucket — plus a
 * leading "all periods" entry (`value: ""`) which is the default and leaves the
 * page scoped to the whole financial year, exactly as before a pick.
 *
 * PURE, client-safe presentation helpers (same contract as cascade/util.ts) —
 * no React, no DB, and no clock of its own: "today" is always passed in, since
 * the server resolves it in IST so the client can't hydrate a different day.
 */

import type { ReviewLevel } from "@/app/(app)/goals/review/review-data";
import { fyLabel, periodKeyLabel } from "@/components/goals/cascade/util";
import { weekNoOf } from "@/lib/goals/fy-calendar";
import { addDays, mondayOf } from "@/lib/weekly-goals/week";

/** Structurally compatible with the `Select` component's option shape. */
export interface PeriodOption {
  value: string;
  label: string;
}

const MON_SHORT = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
const MON_FULL = [
  "January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December",
];

/** Plural noun for a level's "whole FY" option — "All days", "All weeks"… */
export const PERIOD_NOUN: Record<ReviewLevel, string> = {
  daily: "days",
  weekly: "weeks",
  monthly: "months",
  quarterly: "quarters",
  yearly: "years",
};

/** "29 Jul" from a `yyyy-mm-dd`. */
export function dayShort(ymd: string): string {
  return `${Number(ymd.slice(8, 10))} ${MON_SHORT[Number(ymd.slice(5, 7)) - 1] ?? ""}`.trim();
}

/**
 * The dropdown label for one period of a level:
 *   daily → "Today · 29 Jul" · weekly → "This week · W31" · monthly → "July 2026"
 *   quarterly → "Q2 · Jul–Sep" · yearly → "FY 2026–27"
 */
export function periodOptionLabel(level: ReviewLevel, key: string, today: string): string {
  switch (level) {
    case "daily":
      if (key === today) return `Today · ${dayShort(key)}`;
      if (key === addDays(today, -1)) return `Yesterday · ${dayShort(key)}`;
      return `${dayShort(key)} ${key.slice(0, 4)}`;
    case "weekly": {
      const wk = `W${weekNoOf(key)}`;
      return key === mondayOf(today) ? `This week · ${wk}` : `${wk} · ${dayShort(key)}`;
    }
    case "monthly":
      return `${MON_FULL[Number(key.slice(5, 7)) - 1] ?? key} ${key.slice(0, 4)}`;
    case "quarterly":
      return periodKeyLabel(key);
    case "yearly":
      return fyLabel(Number(key));
  }
}

/**
 * The distinct periods a level's rows fall in, newest-first for the rolling
 * levels (day / week / month) and FY-order for the fixed ones (Q1→Q4, FY
 * ascending), behind the "All …" entry that selects the whole FY.
 */
export function periodOptionsOf(
  level: ReviewLevel,
  rows: ReadonlyArray<{ periodKey: string }>,
  today: string,
): PeriodOption[] {
  const keys = [...new Set(rows.map((r) => r.periodKey))].sort((a, b) =>
    level === "quarterly" || level === "yearly" ? a.localeCompare(b) : b.localeCompare(a),
  );
  return [
    { value: "", label: `All ${PERIOD_NOUN[level]} (${rows.length})` },
    ...keys.map((k) => ({ value: k, label: periodOptionLabel(level, k, today) })),
  ];
}
