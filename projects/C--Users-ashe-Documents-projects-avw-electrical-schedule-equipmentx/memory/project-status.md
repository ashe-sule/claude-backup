---
name: project-status
description: "Where the AVW electrical schedule work stands (last updated 2026-11-09); read first when Ashe asks \"where did we stop?\""
metadata:
  node_type: memory
  type: project
  originSessionId: a3e2afcd-3079-4507-a047-3137d7945d77
  modified: 2026-11-20T15:18:16.337Z
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

**!! 2026-11-20 — WRONG SOURCE DEPLOYED (read first) !!**
- The Vercel project avw-electrical-schedule-v2 is Git-connected to **equipmentx/avw-electrical-schedule** (private org repo, branch main). Pushing there auto-deploys production.
- This local folder's origin is **ashe-sule/avw-electrical-schedule**, a different repo that is behind. It lacks commit fa5b0be "Brand the Excel export with AVW50 header and colours" (logo, Ship To, blue/navy/gold, data from row 12, Pillow).
- My 2026-11-19 `vercel deploy --prod` from this folder replaced that branded build (dpl_5WPaDBgVTU8Y5CeaG3LrPPramYPm / apmwswkxc). Ashe noticed the Excel branding was gone.
- Rule: NEVER `vercel deploy --prod` from this folder. Work from a clone of equipmentx/avw-electrical-schedule and deploy by pushing to main.
- Recovery on 2026-11-20, approved by Ashe:
  - `vercel promote apmwswkxc` restored the branding.
  - Cloned equipmentx into C:\Users\ashe\Documents\projects\avw-electrical-schedule-equipmentx (the NEW WORKING FOLDER).
  - Ported the totals fix there as commit 2754b9a and pushed it to main, which auto-deployed (iqsrp8hsq). That build is LIVE: confirmed 2026-11-20, health 200.
  - Tested in real Excel: logo, colours, totals and voltage distribution all show.
  - Old folder: .vercel renamed to .vercel.disabled-wrong-repo, and DO-NOT-DEPLOY-FROM-HERE.txt added.
  - Memory was copied to the new folder's memory dir.
- equipmentx tests are stale: test_engine_regression expects 637 Master groups (now 642), and test_engineer_rules.py + test_learning.py are missing (the "sync with live" commit dropped tests). Port them over from the old repo commit 476855b. Still to do.
- `vercel` CLI now needs `--scope team-ashe`, because no folder is linked.

**2026-11-19 — Excel export totals blank: fixed in commit fe1743a (wrong repo, see above) and deployed to prod**
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

**2026-11-20 — new requests from Ashe (awaiting go-ahead on the plan)**
1. Remove the C.B. column completely (export + app). The Novi Clean drawings show C.B. as all "-".
2. Canada 575 V, from EQ-1-1160 Novi Clean REV1 (Downloads PDF, sheets E-7..E-10, pp 21-24):
   - 3-ph motors at 575 V use the engineers' amps: 1.5 HP=1.8, 7.5=7.4, 10=9.5, 15=15, 50=49.
   - 1-ph devices stay at 120 V with Master amps.
   - Voltage distribution there reads 120V 22.9 / 575V 335.3. TOTALS HP 336, AMPS 358.2.
   - The app ALREADY has a "575/120" site voltage, but its formula gives 1/7/9/14/46. That doesn't match.
   - Fix: add the 5 values to backend/data/motor_amps.csv (the table wins over the formula).
   - Other HP sizes (2, 3, 5, 20, 25...) need the full 575 V table from the engineers (Heri).
- DONE 2026-11-20: commit f58d790 pushed to equipmentx main.
  - C.B. removed from the export and the app UI. It stays in stored data.
  - The 5 Novi Clean 575 V sizes added to motor_amps.csv.
  - Tested: Novi rebuild at 575 V matches the PDF amps for every size, the export shows no C.B., and the frontend builds.
  - The full Novi totals can't be compared without the real EQ-1-1160 quote PDF.
  - Drafted an email to Heri asking for the full 575 V + 400 V motor amps charts, so Ashe can send it.

**End of session 2026-11-20: state to resume from**
- LIVE: deployment oysxq2zm3, built from equipmentx main @ f58d790.
  - Verified: the live bundle has no C.B., and health returns 200.
  - It includes the AVW50 Excel branding, the totals fix (2754b9a), C.B. removal and the 575 V amps.
- Work in C:\Users\ashe\Documents\projects\avw-electrical-schedule-equipmentx. Deploy = push to main. The old folder is retired (Vercel link disabled).
- Open to-dos:
  1. Ashe is sending Heri the email (drafted in chat). It asks for:
     - full 575 V + 400 V motor amps charts
     - the source of the amps (nameplate vs standard table)
     - whether 600 V = 575 V
     - Canada 1-ph stays at 120 V?
     - whether C.B. is still needed anywhere
     When the charts arrive, add rows to backend/data/motor_amps.csv (hp,volts,amps,source).
  2. Ask Ashe for the EQ-1-1160 Novi Clean QUOTE PDF, then compare the full totals with the drawing (336 HP / 358.2 A, 120V 22.9 / 575V 335.3).
  3. The equipmentx tests are stale: 637→642 Master groups, and test_engineer_rules.py + test_learning.py are missing. Port them from the old repo (476855b).
  4. Push the old repo's commit fe1743a? Not needed: it's superseded by 2754b9a in equipmentx.
  5. Earlier audit items are still open (sign-in on every route, backups, CI, the v1.1.6 site).
- A "5+" HP row (Master data) shows amps "-" at 575 V. It was in the Novi rebuild, so check it with the engineers.
- Test env: temp venv %TEMP%/claude/avw-venv (may be wiped). Recreate with `py -3.13 -m venv`, then pip install -r requirements.txt -r backend/requirements.txt pytest.
