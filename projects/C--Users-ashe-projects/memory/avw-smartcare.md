---
name: avw-smartcare
description: "AVW SmartCare — installed-base / preventive maintenance / aftermarket platform; strategy drafted 2026-10-30, no code yet"
metadata:
  node_type: memory
  type: project
  originSessionId: a08b5dc4-81c9-4da9-a0e5-543a853492e2
  modified: 2026-11-01T22:40:28.246Z
---

AVW SmartCare = customer↔site↔equipment registry + approved maintenance rules + equipment pages (QR), built thin and reusing HubSpot (email/consent/tasks), avw-internal-request-hub (tickets), Webstore (checkout), SharePoint (doc approval). Docs in projects/avw-smartcare/docs (v0.1, 2026-10-30). Ashe's master prompt said: no coding until strategy/architecture approved.

**Why:** grow AVW aftermarket revenue + retention from historical equipment sales (JobBOSS SQL on V-JOBBOSS, QuickBooks Desktop, Webstore, HubSpot).

**Data facts (2026-10-31):** QB sandbox = Desktop\ICA-QB (Enterprise 24, backup dated Apr 2025, same filename as live — always confirm sandbox). Export script scripts/qb-export (read-only, resumable by year). JobBOSS started 2020 (confirmed by Ashe 2026-11-01); QB in use long before. Only invoices from Apr 2024 carry the JobBOSS PL# (custom field "Job/Packing Slip No."); 2020–Apr 2024 must be matched on customer+date+part. Memo "E nnnnn, Q nnnn" meaning still unknown (Ashe checking). Draft installed base built 2026-11-01 (scripts/analysis/build_installed_base.py); QB jobs ≈ wash sites; "Job/Packing Slip No." holds JOB#/J#/plain #/PL# refs back to 2015 (plain # 2021–24 likely JobBOSS job — unconfirmed). Item equipment/parts split comes from QB Income Account (scripts/analysis/rank_items.py, 2026-11-01). QB crashes under long SDK reads in multi-user mode — use single-user, fresh QB start; user wants to approve every run step.

**Phase 1 (approved 2026-11-01):** app in avw-smartcare/web (Next 16, Better Auth + Entra, pg, PGlite dev DB on :54329, app on :3100 because :3000 is used by another local app). Task 4 done 2026-11-01 (review queue /review, npm run match:find; 370 suggestions; merges never delete, record moved IDs). Tasks 1–3 done (setup + central DB + QB installed-base import: 1,175 orgs, 2,148 sites, 66,852 units in local dev DB). Ashe chose email+password login for now (admin-created accounts via npm run user:create; Microsoft optional later). Stopping background npm tasks leaves orphan node processes on :3100/:54329: kill by port. Ashe said stay strictly within the original master prompt; no extra sales analysis; QR parked; JobBOSS parked until access. Pause for approval after each task.

**How to apply:** start with Phase 0 (read-only data discovery). Open decisions: HubSpot tiers, distributor channel policy, Engineering approver, webstore platform, legal review. Never invent maintenance intervals or part compatibility. Tag as AVW track per [[two-tracks-ashe-avw]].
