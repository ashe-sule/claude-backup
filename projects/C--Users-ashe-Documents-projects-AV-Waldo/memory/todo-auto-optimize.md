---
name: todo-auto-optimize
description: APPROVED to-do for 2026-11-12 - auto-optimize stop order (user decisions recorded)
metadata:
  type: project
---
User (2026-11-11) said the system, not dispatchers, must arrange Kenny's stop order. Approved design; **build on 2026-11-12, not before** ("Build it but not now... you will build it tomorrow. I have other things to add").

Decisions:
- Before driver starts (route draft/published, no stop arrived): auto re-optimize + save on every assign/unassign/cancel; debounce bulk assigns into one Google matrix call; respect 🔒 locked stops; re-plan with live traffic at publish and at Start shift. Manual ↑↓ stays as override only.
- Once driver is on the road: system computes best new order, dispatch gets one-tap "Approve new order" card (miles/time saved), then driver alerted. User's reason: Kenny may need **trunk space** for a new pickup or an urgent drop-off → consider vehicle capacity (vehicles.capacity_lbs, item weights) in the approval card / solver.
- Urgent priority: keep as **tie-breaker only** (no forced urgent-first, no auto 2-hour deadline).
- Test on demo route 4e83e598-6c41-44ae-97fd-0b2e0a894ea0 (2026-11-12, 5 DEMO drop-offs). See [[project-status]].
