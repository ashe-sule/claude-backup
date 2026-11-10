---
name: project-status
description: PNR Kiosk current status — what's live, how it was tested, what's next (updated 2026-11-10 end of session)
metadata:
  type: project
---

As of 2026-11-10 (end of session), everything is committed and pushed; working tree clean; last commit 5592149 (brief update).

Live at pnr-import-kiosk.vercel.app ("PNR Kiosk – Import/Export Tool", AVW logo):
- Import (NPR/CEP Excel → HubSpot tickets), Export (JB/QB Excel, NPR-only, read-only), History (Neon), greeting with emoji + Maywood weather.
- Personal codes: Ashe / Aleks / Goran (Vercel, Sensitive). Neon DATABASE_URL in Vercel + .env.local.
- Prod HubSpot: 5 new fields created (4 UofM + purchase_description); Ashe built a workflow defaulting UofM = ea.
- Testing: all sandbox-first; prod only read-only (key in git-ignored .env.prod-readonly) except the approved field creation.

Next / open:
- Ashe sends Aleks + Goran their codes privately; Ashe to sign in and check History on live.
- Ideas (not approved): AVW badge as browser tab icon; hard login rate limit; Aleks's ticket-assigned email question; prod Category dropdown (check avwforms first).

Details: [[jb-qb-export-email]], [[kiosk-users-history]]
