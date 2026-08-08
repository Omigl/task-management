import { getCurrentEmployee } from "@/lib/auth/current";
import { getNavCounts } from "@/lib/queries/nav-counts";
import { UserMenu } from "./user-menu";

export async function UserMenuServer({ variant }: { variant?: "rail" } = {}) {
  try {
    const me = await getCurrentEmployee();
    if (!me) return null;
    const { inboxUnread, archivedTasks } = await getNavCounts({
      userId: me.id,
      isAdmin: me.isAdmin,
      inboxSince: me.lastInboxVisitAt,
    }).catch(() => ({ activeTasks: 0, archivedTasks: 0, inboxUnread: 0 }));
    return (
      <UserMenu
        name={me.name}
        email={me.email}
        isAdmin={me.isAdmin}
        avatarUrl={me.avatarUrl}
        inboxUnread={inboxUnread}
        archivedTasks={archivedTasks}
        variant={variant}
      />
    );
  } catch (err) {
    console.error("UserMenuServer render error:", err);
    return null;
  }
}
