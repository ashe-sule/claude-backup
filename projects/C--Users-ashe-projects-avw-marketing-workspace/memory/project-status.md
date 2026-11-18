---
name: project-status
description: "Current status of AVW Marketing Workspace (branches, access-control work, how to run/test, open decisions)"
metadata:
  node_type: memory
  type: project
  originSessionId: 620eeb7a-9b97-43ab-a55c-3eb81ebc8fb4
  modified: 2026-11-18T19:57:52.681Z
---

- 2026-11-18: Calendar-first home + multi-owner/contributor access control COMMITTED on branch `access-control` (9687483 + 2d444d5). MERGED into main 2026-11-18 (fast-forward, includes the Studio redesign). Not pushed (no git remote yet), not deployed. Old version: tag `pre-studio-redesign`. Details: repo `STATUS.md` + `docs/ACCESS-CONTROL.md`.
- Tested: `npm run build && npm run test:access` → 76/76 against the real server and a throwaway DB. Migration checked on a copy of .local-db (9/9 owners kept).
- 2026-11-18 Ashe decided: admins CAN approve any project (oversight); others only if they're the designated approver. Other decisions: only admins delete; the primary owner or an admin archives; contributors only tick their own steps; the approver must be on the project.
- Done 2026-11-18 (LOCAL .local-db only): jennie@example.com = Member (id 4), danka@example.com = Admin (id 5), with no projects assigned. The local DB is now migrated; a pre-change backup is at C:\Users\ashe\projects\avw-local-db-backup-2026-11-18. Production will need the same done on the Team page after deploy.
- Phone layout fixed 2026-11-18 (runway rows stack below 640px) and checked at 390px in headless Chrome. A real Android device is still worth a check. Next: private GitHub repo → Vercel + Neon → Entra app registration → deploy (needs Ashe's OK and accounts), then the pre-launch checklist.
- Local run: `npm run build` then `npx next start -p 3100` → http://localhost:3100. Sign in as admin@example.com, jordan@, sam@, jennie@ or danka@ (test data, no password).
