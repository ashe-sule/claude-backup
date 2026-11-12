---
name: todo-rotate-passwords
description: OPEN TO-DO — remind user to rotate passwords/secrets when the AVW-ICC build is done (user asked 2026-11-12)
metadata:
  node_type: memory
  type: project
  originSessionId: 388de537-7e8f-4684-b80a-c84facf27166
  modified: 2026-11-12T19:56:21.416Z
---

User asked (2026-11-12): "Make sure I rotate password once this build is done." Remind them at build completion / go-live and whenever they ask "are we ready to launch?".

Rotate:
1. JobBOSS SQL login used during the build (`Ashe_SQL_RO`, also used by SmartCare) — and move ICC to a dedicated ICC read-only login.
2. qb-sync Neon Postgres connection string (was pasted in a chat earlier — per qb-sync CLAUDE.md).
3. QBWC password and ICC agent token (dev token in apps/agent/.env.dev is dev-only; issue fresh prod token).
4. Entra client secret / SESSION_PASSWORD if ever shared during setup.
5. ICC local admin login **ashe@test.com** — its password was shown in chat at the user's request (2026-11-12). Reset it via Users & Roles → "Reset password" before real use. (ashe@avw.local was deleted.)

**Why:** credentials were used/shared during development; launch checklist item 2 ("rotate any key that was ever committed or pasted in chat").
**How to apply:** raise this in the final launch report and pre-launch checklist; don't mark launch-ready until confirmed done.

Related: [[project-status]], [[avw-environment-facts]]
