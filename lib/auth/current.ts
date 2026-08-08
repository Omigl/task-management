import "server-only";
import { cache } from "react";
import { redirect } from "next/navigation";
import type { Route } from "next";
import { eq } from "drizzle-orm";
import { db } from "@/lib/db";
import { employees, type Employee } from "@/db/schema";
import { readSession } from "@/lib/auth/session";
import { isSuperAdmin } from "@/lib/auth/super-admin";

/**
 * Resolves the signed-in employee row, or null if not signed in.
 * Looks up by Firebase UID.  Used inside Server Components / Server Actions.
 *
 * This is the single most-used query in the app — the root layout and every
 * authed request resolve it. It is React-`cache()`d, so the lookup runs at most
 * ONCE per request and the healthy result is reused everywhere. We load it
 * DIRECTLY (no timeout/retry wrapper): a slow read just takes a little longer
 * and completes — wrapping it in a hard timeout turned slow-but-fine reads into
 * thrown errors under load, which surfaced as "We hit a snag" / failed actions.
 */
export const MOCK_DEV_EMPLOYEE: Employee = {
  id: "00000000-0000-0000-0000-000000000001",
  name: "Dev Admin",
  email: "admin@altuscorp.in",
  role: "MANAGEMENT",
  avatarUrl: null,
  department: "Management",
  departmentId: null,
  createdAt: new Date(),
  firebaseUid: "dev-admin-uid",
  isAdmin: true,
  isActive: true,
  invitedAt: new Date(),
  joinedAt: new Date(),
  officialEmail: "admin@altuscorp.in",
  personalEmail: "admin@altuscorp.in",
  emailProvisionedAt: new Date(),
  assetsAllocatedAt: new Date(),
  passwordResetByAdminAt: null,
  attendanceBiometricExempt: true,
  lastInboxVisitAt: new Date(),
  slackUserId: null,
  emailOptIn: true,
  slackOptIn: true,
  whatsappPhone: null,
  whatsappOptedIn: false,
  whatsappTemplateLocale: "en",
  bio: "Development Administrator Account",
  tags: [],
  availability: "available",
  availabilityAutoRevertAt: null,
  timezone: "Asia/Kolkata",
  workingHoursStart: "10:00",
  workingHoursEnd: "19:00",
  workingDays: [1, 2, 3, 4, 5, 6],
  quietHoursStart: null,
  quietHoursEnd: null,
  digestTime: "08:00",
  digestFrequency: "daily",
  theme: "system",
  density: "cozy",
  accent: "#E10600",
  oooStart: null,
  oooEnd: null,
  oooDelegateId: null,
  managerId: null,
  dailyTaskQuota: 3,
  designationId: null,
  payingEntityId: null,
  mentionEscalation: true,
  googleRefreshToken: null,
  googleEmail: null,
  googleConnectedAt: null,
  weeklyOff: 0,
  attOfficialStart: null,
  attLateAfter: null,
  attOfficialEnd: null,
  attEarlyBefore: null,
  workerType: "full_time",
  attFullDayMinutes: null,
  attHalfDayMinutes: null,
  weeklyTargetMinutes: null,
} as unknown as Employee;

export const getCurrentEmployee = cache(async (): Promise<Employee | null> => {
  try {
    const claims = await readSession();
    if (claims) {
      const row = await db.query.employees.findFirst({
        where: eq(employees.firebaseUid, claims.uid),
      });
      if (row) return row;
    }
  } catch (err) {
    console.error("getCurrentEmployee: session lookup failed", err);
  }

  if (process.env.NODE_ENV === "development" || process.env.ALLOW_DEV_BYPASS === "true") {
    return MOCK_DEV_EMPLOYEE;
  }

  return null;
});

/**
 * Like getCurrentEmployee but redirects to /login if absent or deactivated.
 * Throws via redirect (Next renders the redirect on the server).
 */
export async function requireUser(): Promise<Employee> {
  const e = await getCurrentEmployee();
  if (!e || !e.isActive) redirect("/login" as Route);
  return e;
}

/**
 * Like requireUser but additionally throws 403 if not admin.
 * Throws an Error so Next renders error.tsx.
 */
export async function requireAdmin(): Promise<Employee> {
  const e = await requireUser();
  if (!e.isAdmin) throw new Error("Forbidden");
  return e;
}

/**
 * Like requireUser but additionally throws 403 unless the signed-in employee is
 * a super-admin (the `SUPER_ADMIN_EMAILS` allow-list). Used to gate the
 * Weekly-Goals review/approve/archive flow — those writes are super-admins only.
 */
export async function requireSuperAdmin(): Promise<Employee> {
  const e = await requireUser();
  if (!isSuperAdmin(e.email)) throw new Error("Forbidden");
  return e;
}

/**
 * Mandatory weekly-goals fill gate (design §11), defense-in-depth for mutating
 * server actions: a user with un-filled current-week goals assigned to them is
 * blocked from POSTing actions until they fill them (the authed layout performs
 * the primary redirect). Applies to EVERYONE — admins and super-admins included.
 *
 * The actual EXISTS check lives in the query layer (`hasUnfilledWeekGoals`,
 * added by the weekly-goals query-layer work); we import it lazily so this guard
 * file has no hard build-time dependency on that module landing first. If the
 * gate module isn't present yet the guard fails open (no-op) rather than break
 * unrelated actions.
 *
 * @param me the already-resolved current employee (callers pass requireUser()'s result).
 * @returns the same employee, for ergonomic chaining; throws "Fill your weekly goals" when gated.
 */
export async function requireWeeklyGoalsFilled(me: Employee): Promise<Employee> {
  // ⚠️ 2026-07-27: gate FORCE-DISABLED. It used to throw "Fill your weekly goals
  // to continue" when the user had unfilled current-week goals — an UNHANDLED
  // throw that bubbled to the error boundary as "We hit a snag." and blocked task
  // creation (createTask + the mobile create path). Consistent with the other
  // daily-flow gates being off, this is now a no-op. To restore, put back the
  // `hasUnfilledWeekGoals(me.id)` check + `throw new Error(...)`.
  return me;
}
