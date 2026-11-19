---
name: project-status
description: "Where the AVW electrical schedule work stands (last updated 2026-11-09); read first when Ashe asks \"where did we stop?\""
metadata:
  node_type: memory
  type: project
  originSessionId: a3e2afcd-3079-4507-a047-3137d7945d77
  modified: 2026-11-19T22:42:22.517Z
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

**2026-11-19 — Excel export totals blank: FIXED, committed fe1743a, deployed to prod**
- Deployed with `vercel deploy --prod` (deployment avw-electrical-schedule-v2-mwznhlg4z): status Ready, site + /api/health return 200. Vercel CLI IS installed (npm global).
- The commit is NOT pushed to GitHub yet (ask first). A live export test from the app UI is still to do: Ashe to export a real project and check the totals.
- Problem: the TOTALS row and VOLTAGE DISTRIBUTION "TOTAL AMPS" were blank in the export. openpyxl saved the formulas with no stored result, so Protected View, previews and phones showed blanks.
- Fix in processor.py:
  - Keep the formulas, so totals stay live when editing, AND store each result in the xlsx (`_store_formula_results`).
  - Write number-looking text in HP/Volts/Amps/Gal Min as real numbers.
  - The voltage SUMIF now adds up every way a voltage is written (460, "460V").
  - build_summary now falls back from Ext. Amps to Amps.
- Tested:
  - test_engine_regression.py passes, including a new mixed-format check.
  - Opened in real Excel: the stored totals match Excel's own recalculation.
  - 3 pytest failures already existed: the sample PDF ../upload/EQ-1-1142.pdf is missing.
- Test env: temp venv at %TEMP%/claude/avw-venv. There's no project venv.
- Next: push the branch, if Ashe approves.
