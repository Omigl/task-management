import type { TaskStatus } from "@/db/enums";

/**
 * Structured due-date state for a task, used by the board card footer (and any
 * other surface that wants the same "Due in 3 days" / "Overdue by 2 days" /
 * "Completed on 15 JUN 2026" phrasing).
 *
 * Day math is done in IST CALENDAR DAYS, never on raw timestamps. Two reasons:
 *
 *  1. A due date is stored as noon IST on the due day (see lib/task-late.ts), so
 *     a `dueAt.getTime() < Date.now()` compare flips a task to "overdue" at
 *     noon on the day it's actually due.
 *  2. The board is a client component that Next also renders on the server
 *     (Vercel runs UTC). Local-time day math would produce a different answer on
 *     each side for the ~5.5h IST offset window and blow up hydration. Pinning
 *     to a fixed zone makes both sides agree.
 *
 * Callers must pass the EFFECTIVE due date (revised ?? original) — see
 * lib/tasks/effective-due.ts. `BoardTask.dueAt` already is one.
 */

const TZ = "Asia/Kolkata";

const MONTHS_UPPER = [
  "JAN", "FEB", "MAR", "APR", "MAY", "JUN",
  "JUL", "AUG", "SEP", "OCT", "NOV", "DEC",
];

/** `d`'s calendar day in IST as [year, month (1-12), day]. */
function istParts(d: Date): [number, number, number] {
  // en-CA formats as YYYY-MM-DD.
  const s = d.toLocaleDateString("en-CA", { timeZone: TZ });
  return [Number(s.slice(0, 4)), Number(s.slice(5, 7)), Number(s.slice(8, 10))];
}

/** Days since the epoch for `d`'s calendar day in IST — subtract two to get a day delta. */
function istDayIndex(d: Date): number {
  const [y, m, day] = istParts(d);
  return Math.floor(Date.UTC(y, m - 1, day) / 86_400_000);
}

/**
 * `d` in the canonical Altus date format (`dd MMM yyyy`, uppercase month — see
 * lib/format.ts) but resolved in IST rather than the runtime's local zone, so
 * the badge text is identical on the UTC server and an IST browser.
 */
function formatIstDate(d: Date): string {
  const [y, m, day] = istParts(d);
  return `${String(day).padStart(2, "0")} ${MONTHS_UPPER[m - 1]} ${y}`;
}

/** Whole IST calendar days from `from` to `to`: <0 past, 0 same day, >0 future. */
export function istCalendarDaysBetween(from: Date, to: Date): number {
  return istDayIndex(to) - istDayIndex(from);
}

/** A task at or under this many days out reads as "due soon" (amber). */
export const DUE_SOON_DAYS = 5;

/** Statuses where the work is finished/closed — these never read as overdue. */
const TERMINAL_STATUSES = new Set<string>([
  "done",
  "approved",
  "not_approved",
  "cancelled",
  "transferred",
]);

/** Statuses that count as genuinely completed (vs. merely closed). */
const COMPLETED_STATUSES = new Set<string>(["done", "approved"]);

export type DueStatusKind =
  | "completed"
  | "overdue"
  | "today"
  | "soon"
  | "scheduled"
  | "none";

/** Design-system colour token for the badge, or null for the neutral pill. */
export type DueStatusTone = "green" | "red" | "orange" | "amber" | null;

export interface DueStatus {
  kind: DueStatusKind;
  /** IST calendar days to the due day (<0 past, 0 today, >0 future); null with no due date. */
  days: number | null;
  /** Badge text, already pluralised. */
  label: string;
  tone: DueStatusTone;
  /** Longer phrasing for the badge's `title` tooltip. */
  hint: string;
}

function plural(n: number, unit: string): string {
  return `${n} ${unit}${n === 1 ? "" : "s"}`;
}

export function dueStatus(
  t: {
    status: TaskStatus | string;
    /** Effective due date (revised ?? original). */
    dueAt: Date | null;
    completedAt: Date | null;
    archived?: boolean;
  },
  now: Date = new Date(),
): DueStatus {
  // Finished work leads with when it landed, not with how late it is. (A task
  // completed after its due date still gets the separate amber "Late" chip.)
  if (t.completedAt && COMPLETED_STATUSES.has(t.status)) {
    return {
      kind: "completed",
      days: t.dueAt ? istCalendarDaysBetween(now, t.dueAt) : null,
      label: `Completed on ${formatIstDate(t.completedAt)}`,
      tone: "green",
      hint: `Completed on ${formatIstDate(t.completedAt)}`,
    };
  }

  if (!t.dueAt || Number.isNaN(t.dueAt.getTime())) {
    return { kind: "none", days: null, label: "No due date", tone: null, hint: "No due date set" };
  }

  const due = formatIstDate(t.dueAt);
  const days = istCalendarDaysBetween(now, t.dueAt);

  // Archived or otherwise closed tasks are off the clock — show the plain date.
  if (t.archived || TERMINAL_STATUSES.has(t.status)) {
    return { kind: "scheduled", days, label: `Due ${due}`, tone: null, hint: `Due ${due}` };
  }

  if (days < 0) {
    const late = Math.abs(days);
    return {
      kind: "overdue",
      days,
      label: `Overdue by ${plural(late, "day")}`,
      tone: "red",
      hint: `Was due ${due} — ${plural(late, "day")} ago`,
    };
  }
  if (days === 0) {
    return { kind: "today", days, label: "Due today", tone: "orange", hint: `Due today, ${due}` };
  }
  if (days <= DUE_SOON_DAYS) {
    return {
      kind: "soon",
      days,
      label: `Due in ${plural(days, "day")}`,
      tone: "amber",
      hint: `Due ${due}`,
    };
  }
  return { kind: "scheduled", days, label: `Due ${due}`, tone: null, hint: `Due ${due}` };
}
