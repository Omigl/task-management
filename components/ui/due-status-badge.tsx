import {
  CalendarCheck2,
  CalendarClock,
  CalendarDays,
  CalendarX2,
  type LucideIcon,
} from "lucide-react";
import { dueStatus, type DueStatus, type DueStatusKind } from "@/lib/tasks/due-status";

/**
 * Due-date status pill — "Due in 3 days" / "Due today" / "Overdue by 2 days" /
 * "Completed on 15 JUN 2026". Presentational: the tone + phrasing come from
 * lib/tasks/due-status.ts, so every surface reads the same.
 *
 * Pass a task and it derives its own state, or pass a pre-computed `status`
 * when the caller already has one.
 */

const ICON: Record<DueStatusKind, LucideIcon> = {
  completed: CalendarCheck2,
  overdue: CalendarX2,
  today: CalendarClock,
  soon: CalendarClock,
  scheduled: CalendarDays,
  none: CalendarDays,
};

export function DueStatusBadge({
  task,
  status,
  className = "",
}: {
  task?: Parameters<typeof dueStatus>[0];
  status?: DueStatus;
  className?: string;
}) {
  const s = status ?? (task ? dueStatus(task) : null);
  if (!s) return null;

  const Icon = ICON[s.kind];
  // Toned kinds get a tinted pill; neutral ones reuse the card's plain date-pill
  // treatment so the footer stays quiet when nothing is urgent.
  const tone = s.tone
    ? {
        color: `var(--color-${s.tone}-deep)`,
        background: `color-mix(in srgb, var(--color-${s.tone}) 12%, white)`,
        border: `1px solid color-mix(in srgb, var(--color-${s.tone}) 30%, transparent)`,
      }
    : {
        background: "var(--color-surface-soft)",
        border: "1px solid var(--color-hairline)",
      };

  return (
    <span
      className={`inline-flex min-w-0 items-center gap-1 rounded-pill px-2 py-0.5 text-[12px] font-bold tabular-nums whitespace-nowrap ${
        s.tone ? "" : "text-ink-subtle"
      } ${className}`}
      style={{ ...tone, lineHeight: 1.35 }}
      title={s.hint}
    >
      <Icon size={11} strokeWidth={2.4} className="shrink-0" aria-hidden />
      <span className="truncate">{s.label}</span>
    </span>
  );
}
