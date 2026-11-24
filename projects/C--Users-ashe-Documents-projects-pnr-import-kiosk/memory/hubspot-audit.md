---
name: hubspot-audit
description: "Full HubSpot PROD read-only audit Part 1 (2026-11-20) — key findings, gaps, first-5 proposals awaiting Ashe's OK"
metadata:
  node_type: memory
  type: project
  originSessionId: 7694b395-d7ff-4a6b-a60f-932523ddb477
  modified: 2026-11-20T18:14:17.511Z
---

2026-11-20: Ashe pasted a "master prompt" for a full HubSpot audit, with the instruction "DO NOT MAKE ANY CHANGES TO PRODUCTION, JUST REVIEW". Done read-only (GET/search only).

Report: C:\Users\ashe\Documents\AVW HubSpot Audit - Part 1 - 2026-11-20.md. Raw data: session scratchpad audit/prod/*.json (temp).

**Key findings**
- 16 ticket pipelines, 24,620 tickets, 68 active users, 6 Super Admins, 33 users with no role, 94 forms.
- 216 of 705 custom ticket fields are never used.
- PNR: median close 7 days; 15 stages; "In Marketing Review" never used; JB/QB stage has an outlier at 107 days; ticket_submitter filled on only 12% of tickets; `cost` is a TEXT field.
- RGA: median 49 days; "Rejected By Vendor" is flagged OPEN; one owner holds 46 of 110 open.
- MIR: median 37 days; QC has a single-person bottleneck.
- Website Customer Tickets: 194 open tickets idle more than 90 days (oldest 1,630 days).
- avwforms has unauthenticated API routes using the HubSpot key (/api/attach-files verified by me).
- Attachments are stored PUBLIC_NOT_INDEXABLE (W-9s).
- 49 kiosk tickets were deleted (see [[project-status]]).

**Gaps (Part 2)**
- Workflows, notifications, owners/teams/roles, deals, reports, subscription.
- Needs read scopes on the audit app (automation, owners, teams, deals, lists), a Chrome view-only walkthrough, or screenshots.

**First 5 proposed (NOT approved yet)**
1. Lock down the avwforms API routes (needs a one-time avwforms OK).
2. Find out who deleted the kiosk tickets.
3. Add read scopes to the audit app.
4. Make attachments private.
5. Close the 194 stale website tickets after a CSV backup.

2026-11-20 (later): added Appendix A–D to the report.
- A: never-used fields (216 ticket / 6 company / 101 contact).
- B: avwforms API routes table. NEW: /api/change-request/search exposes part cost+price+GL with no login; /api/customers exposes the full customer list. The CSVs sit in the repo under src/data.
- C: public-file fix plan (PUBLIC_NOT_INDEXABLE → PRIVATE, then re-secure existing W-9s).
- D: Petar Peric = owner 84337733 → 46 open RGA + 26 open MIR (72 total). Owner names come from Users object hubspot_owner_id.
Recommended avwforms fix: put the whole site behind a login (M365/Entra, Vercel protection, or a staff code). Not approved yet.

2026-11-20: Ashe found the .md report hard to open, so I built an Excel version instead: C:\Users\ashe\Documents\AVW HubSpot Audit - Part 1 - 2026-11-20.xlsx (16 tabs). Built from scratchpad audit/build-xlsx.mjs (temp) and verified by reading it back. Prefer Excel/Office formats over .md for Ashe's reports.

Related: [[hubspot-company-hierarchy]], [[prod-access-key]]
