---
name: hubspot-company-hierarchy
description: "Parent/child company demo + \"Company Family\" view in HubSpot SANDBOX (2026-11-17) — what exists, findings, next steps"
metadata:
  node_type: memory
  type: project
  originSessionId: ccea4d1f-d510-4a55-8b67-2ee326d0bd9d
  modified: 2026-11-17T17:30:30.037Z
---

Side project (not kiosk code): Ashe wants a clean way to see parent/child companies in HubSpot. All work so far is SANDBOX only (portal 50557468). Nothing in prod.

**What exists in sandbox (2026-11-17)**
- Test family: TEST – Sparkle Wash HQ 61049530910 (Chicago) → children Maywood 61125963555 (the merged record) + Oak Park 61116814109.
- Company property `company_family` (text, "Company Family", group companyinformation) = top parent's name; backfilled on all 103 companies that are parents/children.
- Saved view Companies → "Parent & Child Companies" (view id 77288756): filter = Number of child companies > 0 OR Parent Company is known; columns Name, Company Family, Parent Company, City, Number of child companies; sort Company Family A→Z.
- Sandbox private app (ID 54935900) has companies read+write scopes and can create properties.

**Findings**
- Assoc typeIds: 13 = Child Company (parent→child), 14 = Parent Company (child→parent), 450 = unlabeled. Link from child side with 14.
- `hs_num_child_companies` rollup lags a few seconds after linking.
- Merging companies creates a NEW record ID; old IDs redirect.
- Sandbox copies of prod companies have stale `hs_parent_company_id` (prod IDs) + only unlabeled links, so only the TEST family is a real family in sandbox.
- HubSpot has no tree/org-chart list view; family field + sort is the workaround.

**Next (waiting on Ashe)**
1. Build workflow to auto-fill Company Family when a company gets a parent (check HubSpot plan supports copying from associated company first; multi-level parents not handled by a simple copy).
2. If Ashe likes it → replicate in PROD only with explicit OK (property + backfill + view).
3. Delete the 3 TEST companies when Ashe says.

Related: [[project-status]]
