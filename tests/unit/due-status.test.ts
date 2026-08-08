import { describe, it, expect } from "vitest";
import { dueStatus, istCalendarDaysBetween, DUE_SOON_DAYS } from "@/lib/tasks/due-status";

// Due dates are stored as noon IST on the due day; 06:30Z == 12:00 IST.
const noonIst = (ymd: string) => new Date(`${ymd}T06:30:00.000Z`);

// "Now" = 09:30 IST on 2026-08-08.
const NOW = new Date("2026-08-08T04:00:00.000Z");

const task = (over: Partial<Parameters<typeof dueStatus>[0]> = {}) => ({
  status: "not_started" as const,
  dueAt: noonIst("2026-08-08"),
  completedAt: null,
  archived: false,
  ...over,
});

describe("dueStatus — upcoming work", () => {
  it("due 3 days out → amber 'Due in 3 days'", () => {
    const s = dueStatus(task({ dueAt: noonIst("2026-08-11") }), NOW);
    expect(s).toMatchObject({ kind: "soon", days: 3, label: "Due in 3 days", tone: "amber" });
  });

  it("due tomorrow → singular 'Due in 1 day'", () => {
    const s = dueStatus(task({ dueAt: noonIst("2026-08-09") }), NOW);
    expect(s.label).toBe("Due in 1 day");
  });

  it("due today → orange 'Due today'", () => {
    const s = dueStatus(task(), NOW);
    expect(s).toMatchObject({ kind: "today", days: 0, label: "Due today", tone: "orange" });
  });

  it(`due beyond ${DUE_SOON_DAYS} days → neutral date pill, no urgency tone`, () => {
    const s = dueStatus(task({ dueAt: noonIst("2026-09-15") }), NOW);
    expect(s).toMatchObject({ kind: "scheduled", label: "Due 15 SEP 2026", tone: null });
  });

  it(`the ${DUE_SOON_DAYS}-day boundary is inclusive`, () => {
    expect(dueStatus(task({ dueAt: noonIst("2026-08-13") }), NOW).kind).toBe("soon");
    expect(dueStatus(task({ dueAt: noonIst("2026-08-14") }), NOW).kind).toBe("scheduled");
  });
});

describe("dueStatus — overdue", () => {
  it("due yesterday → red, singular", () => {
    const s = dueStatus(task({ dueAt: noonIst("2026-08-07") }), NOW);
    expect(s).toMatchObject({ kind: "overdue", days: -1, label: "Overdue by 1 day", tone: "red" });
  });

  it("due 4 days ago → 'Overdue by 4 days'", () => {
    const s = dueStatus(task({ dueAt: noonIst("2026-08-04") }), NOW);
    expect(s.label).toBe("Overdue by 4 days");
  });

  it("does NOT flip to overdue after noon on the day it is due", () => {
    // 18:00 IST on the due day. A raw `dueAt.getTime() < Date.now()` compare
    // would read this as overdue because the due date is stored at noon IST.
    const evening = new Date("2026-08-08T12:30:00.000Z");
    expect(dueStatus(task(), evening).kind).toBe("today");
  });

  it("archived and terminal tasks are off the clock", () => {
    const past = { dueAt: noonIst("2026-07-01") };
    expect(dueStatus(task({ ...past, archived: true }), NOW).kind).toBe("scheduled");
    expect(dueStatus(task({ ...past, status: "cancelled" }), NOW).kind).toBe("scheduled");
    expect(dueStatus(task({ ...past, status: "transferred" }), NOW).kind).toBe("scheduled");
  });
});

describe("dueStatus — completed", () => {
  it("done with a completion stamp → green 'Completed on …'", () => {
    const s = dueStatus(
      task({ status: "done", completedAt: noonIst("2026-06-15"), dueAt: noonIst("2026-06-20") }),
      NOW,
    );
    expect(s).toMatchObject({ kind: "completed", label: "Completed on 15 JUN 2026", tone: "green" });
  });

  it("completion wins over overdue, even when finished late", () => {
    const s = dueStatus(
      task({ status: "approved", completedAt: noonIst("2026-07-02"), dueAt: noonIst("2026-06-20") }),
      NOW,
    );
    expect(s.kind).toBe("completed");
  });

  it("done without a completion stamp falls back to the neutral date pill", () => {
    const s = dueStatus(task({ status: "done", dueAt: noonIst("2026-06-20") }), NOW);
    expect(s).toMatchObject({ kind: "scheduled", tone: null });
  });

  it("no due date → 'No due date'", () => {
    const s = dueStatus(task({ dueAt: null }), NOW);
    expect(s).toMatchObject({ kind: "none", days: null, label: "No due date", tone: null });
  });
});

describe("istCalendarDaysBetween", () => {
  it("uses IST calendar days, not the runtime's local day", () => {
    // 19:00Z on Aug 8 is already 00:30 IST on Aug 9 — so a task due noon IST on
    // Aug 9 is due TODAY, not tomorrow. Server (UTC) and browser (IST) agree.
    const lateUtcEvening = new Date("2026-08-08T19:00:00.000Z");
    expect(istCalendarDaysBetween(lateUtcEvening, noonIst("2026-08-09"))).toBe(0);
    expect(dueStatus(task({ dueAt: noonIst("2026-08-09") }), lateUtcEvening).label).toBe("Due today");
  });

  it("counts whole days across a month boundary", () => {
    expect(istCalendarDaysBetween(noonIst("2026-08-30"), noonIst("2026-09-02"))).toBe(3);
  });
});
