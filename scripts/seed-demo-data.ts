import postgres from "postgres";

const url = process.env.DATABASE_URL;
if (!url) throw new Error("DATABASE_URL not set");
const sql = postgres(url, { max: 1, prepare: false });

async function main() {
  console.log("▸ Seeding demo data into database...");

  try {
    const [devAdmin] = await sql`
      insert into employees (id, name, email, role, department, is_admin, is_active, official_email, personal_email)
      values ('00000000-0000-0000-0000-000000000001', 'Dev Admin', 'admin@altuscorp.in', 'MANAGEMENT', 'Executive', true, true, 'admin@altuscorp.in', 'admin@altuscorp.in')
      on conflict (id) do update set name = excluded.name
      returning id;
    `;
    const devAdminId = devAdmin?.id ?? '00000000-0000-0000-0000-000000000001';

    // 2. Insert sample teammates
    const employeesData = [
      { id: '00000000-0000-0000-0000-000000000002', name: 'Manan Vasa', email: 'manan@unleashed.in', role: 'MANAGEMENT', dept: 'Executive' },
      { id: '00000000-0000-0000-0000-000000000003', name: 'Rohan Sharma', email: 'rohan@altuscorp.in', role: 'MANAGER', dept: 'Engineering' },
      { id: '00000000-0000-0000-0000-000000000004', name: 'Priya Patel', email: 'priya@altuscorp.in', role: 'EXECUTIVE', dept: 'Sales' },
      { id: '00000000-0000-0000-0000-000000000005', name: 'Aarav Mehta', email: 'aarav@altuscorp.in', role: 'EXECUTIVE', dept: 'HR' },
    ];

    for (const emp of employeesData) {
      await sql`
        insert into employees (id, name, email, role, department, is_admin, is_active)
        values (${emp.id}, ${emp.name}, ${emp.email}, ${emp.role}, ${emp.dept}, ${emp.role === 'MANAGEMENT'}, true)
        on conflict (id) do nothing;
      `;
    }

    // 3. Insert sample tasks
    const tasksData = [
      { title: "Q3 WMS Performance Review & Optimization", status: "initiated", priority: "high", dept: "Engineering", assignee: devAdminId },
      { title: "Onboard 5 New Sales Representatives", status: "in_progress", priority: "urgent", dept: "Sales", assignee: '00000000-0000-0000-0000-000000000004' },
      { title: "Finalize Monthly Payroll & Incentive Approvals", status: "follow_up", priority: "high", dept: "HR", assignee: '00000000-0000-0000-0000-000000000005' },
      { title: "Update Security Policies & Biometric Punch Settings", status: "completed", priority: "medium", dept: "Executive", assignee: devAdminId },
      { title: "Client Acquisition Campaign - Phase 1", status: "initiated", priority: "urgent", dept: "Sales", assignee: '00000000-0000-0000-0000-000000000002' },
    ];

    for (const t of tasksData) {
      await sql`
        insert into tasks (title, status, priority, department, assignee_id, creator_id, created_at, updated_at)
        values (${t.title}, ${t.status}, ${t.priority}, ${t.dept}, ${t.assignee}, ${devAdminId}, now(), now())
        on conflict do nothing;
      `;
    }

    console.log("  ✓ Demo data seeded successfully!");
  } catch (err) {
    console.error("  ✗ Seeding failed:", err);
  } finally {
    await sql.end();
  }
}

main();
