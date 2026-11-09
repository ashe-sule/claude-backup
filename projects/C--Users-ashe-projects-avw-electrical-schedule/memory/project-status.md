---
name: project-status
description: "Where the AVW electrical schedule work stands (last updated 2026-11-09); read first when Ashe asks \"where did we stop?\""
metadata:
  node_type: memory
  type: project
  originSessionId: a3e2afcd-3079-4507-a047-3137d7945d77
  modified: 2026-11-09T18:44:50.605Z
---

**Status at 2026-11-09 (end of session)**
- Branch `vercel-and-engineer-fixes` is pushed and holds commit 476855b with the engineering answers ([[engineering-rule-sources]]). It is NOT merged to `main` (main is still "first commit").
- Deployed to production with `vercel deploy --prod` from the local folder. There's no Git integration, so a push does not deploy. Project: avw-electrical-schedule-v2 (team-ashe), live at avw-electrical-schedule-v2.vercel.app.
- Live test passed 2026-11-09:
  - EQ-1-1143: 36 GGBTL under 8 VA5129A-1 + 28 VA5129A-2, and VACUTECH has M-25 only.
  - EQ-1-1145: 400 V amps 15 HP = 20, 7.5 HP = 10, 20 HP = 27.
  - Export works. Both test projects were deleted.
- Version is still 1.3.0 (not bumped).
- Each project freezes its own Master List copy, so old projects keep the old rules.

**Open items / next steps**
- Ask Heri for AVW's standard 400 V motor amps table. Until then the Master formula is used, and `backend/data/motor_amps.csv` is empty.
- `docs/AUDIT-2026-11-05.md` and `docs/COMPARE-EQ-1-1145-vs-V2.md` are still untracked. Ask before committing, because the audit describes security gaps.
- Audit top items:
  - sign-in on every route (the public API allows deletes)
  - EE decision on the amps basis
  - remove the mixed-voltage amps TOTAL and add a disclaimer
  - backup restore test
  - CI
  - move engineers off the unversioned v1.1.6 site
- Possibly merge the branch to `main` and bump to v1.3.1.

**Why:** Ashe works across many chats, and the previous session left no notes.
**How to apply:** start from this list, and confirm with Ashe before acting (their rule: no task without approval).
