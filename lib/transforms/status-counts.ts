import type { Task } from "@/db/schema";
import type { KpiTotals, StatusDistribution } from "@/lib/types";
import { TASK_STATUSES, type TaskStatus } from "@/db/enums";

/** The KPI tile a task lands in, or null when it belongs to none of them. */
export type KpiBucket = Exclude<keyof KpiTotals, "total">;

/**
 * Single source of truth for KPI bucketing. Shared by the row-walking
 * `computeKpiTotals` (current period) and the grouped-count
 * `computeKpiTotalsFromGroups` (previous period), so the two can never drift.
 */
export function kpiBucketFor(
  status: TaskStatus,
  approvalStatus: string | null | undefined,
): KpiBucket | null {
  // Done bucket: legacy `done`/`approved` lifecycle values OR new
  // approval_status="approved" verdict (any status).
  if (status === "done" || status === "approved" || approvalStatus === "approved") {
    return "done";
  }
  // Not-approved bucket: legacy status value OR new approval_status.
  if (status === "not_approved" || approvalStatus === "not_approved") {
    return "notApproved";
  }
  if (status === "not_started") return "notStarted";
  if (status === "need_info") return "needHelp"; // need_help retired → need_info
  if (
    status === "initiated" ||
    status === "follow_up" ||
    status === "follow_up_1" ||
    status === "follow_up_2" ||
    status === "follow_up_3"
  ) {
    return "pending";
  }
  return null;
}

function emptyTotals(): KpiTotals {
  return { total: 0, pending: 0, notStarted: 0, needHelp: 0, done: 0, notApproved: 0 };
}

export function computeKpiTotals(tasks: Task[]): KpiTotals {
  const totals = emptyTotals();
  totals.total = tasks.length;
  for (const t of tasks) {
    const bucket = kpiBucketFor(t.status, t.approvalStatus);
    if (bucket) totals[bucket]++;
  }
  return totals;
}

/**
 * Same totals, from a `GROUP BY status, approval_status` aggregate instead of
 * full rows. Used for the previous-period comparison, where we only ever need
 * the counts — shipping the rows would double the dashboard's heaviest scan.
 */
export function computeKpiTotalsFromGroups(
  groups: { status: TaskStatus; approvalStatus: string | null; count: number }[],
): KpiTotals {
  const totals = emptyTotals();
  for (const g of groups) {
    const n = Number(g.count) || 0;
    totals.total += n;
    const bucket = kpiBucketFor(g.status, g.approvalStatus);
    if (bucket) totals[bucket] += n;
  }
  return totals;
}

export function computeStatusDistribution(
  tasks: Task[],
): StatusDistribution[] {
  const counts = new Map<TaskStatus, number>(
    TASK_STATUSES.map((s) => [s, 0]),
  );

  for (const t of tasks) {
    counts.set(t.status, (counts.get(t.status) ?? 0) + 1);
  }

  return TASK_STATUSES.map((status) => ({
    status,
    count: counts.get(status) ?? 0,
  })).filter((d) => d.count > 0);
}
