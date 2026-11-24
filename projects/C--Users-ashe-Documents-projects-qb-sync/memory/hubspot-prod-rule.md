---
name: hubspot-prod-rule
description: "Never change anything in production (HubSpot prod, avwforms, live QB/Vercel/DBs) without Ashe's explicit OK first"
metadata:
  node_type: memory
  type: feedback
  originSessionId: cf4f708c-908e-426d-abd6-1e3d8117f34e
  modified: 2026-11-10T22:13:01.649Z
---

Never make a change on production without Ashe's explicit OK, every time (said 2026-11-10). This covers HubSpot production (Hub 21617654), the avwforms site/repo, the real QuickBooks company file, and any live database or deployment config. Sandbox (HubSpot 50557468, ICA QB test file) changes are fine when they're part of an approved task.

**Why:** a prod change can cascade into live tickets, the live form and QuickBooks; Ashe wants to be the gate for it.
**How to apply:** before any write that touches prod, stop and ask with a clear description of the change; approval for one change doesn't cover the next. Reading prod is also a prod call under the qb-sync repo rule, so ask before that too. Related: [[cep-requirements]], [[project-status]].
