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
2026-11-17: Ashe added companies read+write scopes to sandbox private app (app ID 54935900 — not named "kiosk"). Ran demo (scratchpad script, sandbox-guarded): created 3 TEST companies (HQ 61049530910, Maywood 61121304868, near-dupe 61065820213), detected dupe by normalised name + phone digits, merged, linked Maywood→HQ with typeId 14. Findings: assoc typeId 13 = "Child Company" (parent→child), 14 = "Parent Company" (child→parent), 450 = unlabeled. MERGE CREATES A NEW ID (61125963555); both old IDs redirect — any saved IDs must be re-read after merges. Test records left in sandbox for Ashe to view; delete when Ashe says.
2026-11-17 (later): Ashe saw the TEST companies as separate rows and asked to see the hierarchy. Verified via API + Chrome (sandbox, Ashe already signed in): HQ 61049530910 has 1 child = Maywood 61125963555 (the merged record), labelled "Child Company" in the HQ record's right-sidebar Companies card. Only 1 child exists because the near-dupe was merged into Maywood. Separate rows in the Companies list is normal HubSpot behaviour; hierarchy shows on the record (or add a "Parent Company" column to the list view). Test records still in sandbox; delete when Ashe says.
2026-11-17 (later 2): Ashe said "you handle that, give me a finished view". Done in SANDBOX only: added 2nd child TEST – Sparkle Wash Oak Park (61116814109) linked to HQ (typeId 14 from child side) → HQ now has 2 children. Built saved Companies view "Parent & Child Companies" (view id 77288756): filter = Number of child companies > 0 OR Parent Company is known (103 companies); columns added: Number of child companies, Parent Company. Note: hs_num_child_companies rollup lags a few seconds after linking. Sandbox already had ~57 real parent companies (copied from prod). Test records (HQ, Maywood, Oak Park) still in sandbox; delete when Ashe says. Not done in prod.
2026-11-17 (later 3): Ashe OK'd my advice #1 + #3 in SANDBOX. Done: created company property `company_family` (text, group companyinformation) = top parent's name; backfilled 103 family companies via API (scratchpad fam2.mjs). Slimmed view "Parent & Child Companies" (77288756) to: Company name, Company Family, Parent Company, City, Number of child companies; sorted Company Family A→Z; saved. Done in Chrome with Ashe watching. Finding: sandbox copies of prod companies have STALE hs_parent_company_id pointing to prod IDs + only unlabeled (450) links, so real-data families don't show; only the TEST Sparkle Wash family is a true family. NOT done yet: workflow to auto-fill company_family on new links (needs plan check + may not handle multi-level). Nothing in prod.

2026-11-17 END OF SESSION: Kiosk code unchanged today (working tree clean, last commit ff893df). Session was HubSpot sandbox company-hierarchy work — full details + next steps in [[hubspot-company-hierarchy]]. Kiosk open items unchanged: Ashe to click Download on live Export; dependent-property rules need HubSpot UI screenshots.

2026-11-17 (new session): Ashe asked if any PROD automations use RGA Pipeline (tickets, id 668428939) stage "Accepted By AVW" (id 980913723). Found pipeline + stage read-only via .env.prod-readonly, but that key LACKS `automation` scope → /automation/v4/flows = 403. Answer still open: need automation read scope on the prod-readonly app, or a view-only Chrome look at HubSpot Workflows (filter by ticket pipeline stage).
