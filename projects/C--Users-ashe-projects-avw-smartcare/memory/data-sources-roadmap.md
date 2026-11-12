---
name: data-sources-roadmap
description: QB data is a 2025 snapshot for now; end goal is live real-time JobBOSS + QB once everything is perfected
metadata:
  node_type: memory
  type: project
  originSessionId: 7d6b9238-7def-46c5-b65b-40a4ff0865ff
  modified: 2026-11-12T14:29:56.357Z
---

Ashe (2026-11-12): "On QB we only have 2025 for now. When we perfect all, we will be live with JB and QB in real time."
- Current QB data = backup copy that stops at 2025-04-17 (history back to 2008, 136,674 sales lines). Nothing after Apr 2025 from QB.
- JobBOSS: read-only access since 2026-11-12 (Ashe_SQL_RO).
- Go-live target: real-time (read-only) sync from BOTH JobBOSS and QuickBooks, only after the data/matching is perfected and Ashe approves.

**Why:** numbers in SmartCare (and the online preview) are a 2025 snapshot, not current.
**How to apply:** Label QB-based numbers as "as of Apr 2025" when showing them; don't treat missing post-Apr-2025 QB sales as lost customers; build importers so they can later run as a live sync (idempotent, read-only). Related: [[project-status]]

**Rule (Ashe, 2026-11-12): JobBOSS data must stop at the same date as the QuickBooks copy** (now Apr 17, 2025), so QB and JB cover exactly the same period. Only when we go live with the latest QB do we also go live with the latest JB. "It's only right and the smart data thing to do."
**How to apply:** JobBOSS import caps at the last QB invoice date automatically; never show JB-only numbers after that date until go-live.
