---
name: decisions-2026-11-24
description: "Ashe's 2026-11-24 decisions — membership recalibration parked, LPR parked pending licensing, live ban detection approved but must be free/near-free"
metadata:
  node_type: memory
  type: project
  originSessionId: cd546917-c0c5-4bbf-9ed8-310e7ebb9492
  modified: 2026-11-25T02:00:22.950Z
---

- **Membership recalibration: parked** ("we can do it later").
- **LPR (license plate recognition): removed for now.** Ashe is checking licensing and how to scope it for customers (the tool only gives location ideas). Ashe wants per-state LPR legal requirements so customers know if they can add it. A first research pass was done 2026-11-24 (NCSL, MultiState, legislativeanalysis.org). A full 50-state + Canada table has not been built yet.
- **Live ban/moratorium detection: GO**, but Ashe said ~$0.01–0.03/city of per-analysis search is "a bit too high". Wants it free, or charged to users. Proposed: a free daily national sweep (GDELT + Legistar), with results stored as JSON and read for free at analysis time, plus a curated seed list. Charging users not recommended (no accounts/payments; hurts the lead funnel). Waiting on Ashe to confirm the design.

**Why:** scope and cost constraints for the next build. **How to apply:** don't build membership or LPR features until Ashe reopens them; keep ban detection free. See [[gap-research-2026-11]], [[project-status]].
