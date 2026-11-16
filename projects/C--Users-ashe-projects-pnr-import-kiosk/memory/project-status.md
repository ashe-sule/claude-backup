---
name: project-status
description: PNR Kiosk current status — what is live, how it was tested, what is next (updated 2026-11-16 end of session)
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

2026-11-16: Ashe asked if Claude can see how dependent properties work in the prod PNR pipeline. Read-only check (.env.prod-readonly): HubSpot's public API exposes stages (15, ids/labels) but NOT conditional/dependent property rules; property definitions have no dependency fields; stage audit raw objects only show `scpEnabled: true` on every stage (likely just the feature switch). Rules must come from HubSpot UI (Settings → Objects → Tickets → Pipelines → PNR → stage "Conditional stage properties", and property "Conditional property logic") — screenshots/export from Ashe needed.

2026-11-16: Ashe asked to remove the "Entered stage since" date from Export. Done in commit 7b22e21 (UI field + route `?since` param removed; export = every NPR ticket in Accounting Approved stage). Tested: tsc + next build pass; pushed to main → Vercel auto-deploy. Not yet clicked on live by Ashe. Old History rows still show their "entered since" date (harmless).

2026-11-16 end of session: all committed + pushed (7b22e21 export date removed, then brief update). Working tree clean.
Next: Ashe clicks Download on live Export to confirm; dependent-property rules for the PNR pipeline still need screenshots from HubSpot UI (or a view-only Chrome session) if Ashe wants them mapped.

2026-11-16: Ashe asked to test parent/child COMPANY setup with 3 sandbox records to see what duplicate clean-up looks like. Blocked: sandbox private app (.env.local key) lacks company scopes (MISSING_SCOPES); company->company custom labels = none. Waiting on Ashe to add crm.objects.companies.read + .write to the sandbox private app. Plan: 3 TEST- companies (HQ + 2 sites, one a near-duplicate), link parent/child, show before/after, delete test records after.
