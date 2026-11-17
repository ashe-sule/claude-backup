---
name: todo-daily-pickup-report
description: "PARKED to-do (2026-11-17) — daily emailed pickup report at 5 PM; email method + recipients undecided; don't build until user says go"
metadata:
  node_type: memory
  type: project
  originSessionId: 610a01c2-2500-4004-9e2e-4fd480c31f38
  modified: 2026-11-17T15:59:33.530Z
---

User (2026-11-17) wants a daily email from AV-WALDO to some people: pickups arranged for the day and whether each was picked up. User said "not ready for it now", so don't build until they give the go-ahead.

Decided:
- Send at **5 PM end of day**.
- **Pickups only**: request #, location, items, requester, status (✅ picked up + time + photo link / ⏳ not yet / ❌ failed + reason), with totals at the top.

Still open ("work on it later"):
- Email method. I recommended Microsoft Graph sendMail from a shared M365 mailbox (needs an Entra app registration). Resend is the alternative but needs DNS (SPF/DKIM). Ties into the email choice in [[waiting-on-user]].
- How recipients are managed (admin settings page recommended, or a fixed list).

Build notes: the app has no email sender yet. The scheduler could be Vercel Cron → secured /api/cron route (needs a deploy) or pg_cron + pg_net (pg_cron is already used in migration 0006). Work out the 5 PM time in America/Chicago, including daylight saving. See [[project-status]].
