---
name: prod-access-key
description: "Where prod HubSpot access lives (.env.prod-readonly) — check memory before saying \"no prod access\""
metadata:
  node_type: memory
  type: feedback
  originSessionId: 7694b395-d7ff-4a6b-a60f-932523ddb477
  modified: 2026-11-20T16:36:27.048Z
---

Prod HubSpot key (portal 21617654) is in git-ignored `.env.prod-readonly` in the kiosk repo; `.env.local` is sandbox only. Despite the name, that key can write (see [[project-status]] 2026-11-19).

**Why:** On 2026-11-20 I told Ashe "no prod access" after checking only `.env.local`, and Ashe had to correct me. In the same session the auto-mode classifier blocked a read-only curl using the prod key, so Ashe may need to approve prod calls or add a permission rule.

**How to apply:** Read project-status memory before answering any access question. Prod reads are allowed. Prod writes only with Ashe's explicit OK.
