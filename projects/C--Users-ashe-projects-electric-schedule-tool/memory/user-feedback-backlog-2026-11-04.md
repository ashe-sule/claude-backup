---
name: user-feedback-backlog-2026-11-04
description: AVW Electrical Schedule v1.3.0 (Approvals, site voltage) runs on its own V2 Vercel link and Neon database; engineers stay on the old v1.1.6 link. Status and open items as of 2026-11-05
metadata:
  node_type: memory
  type: project
  originSessionId: 61b056e4-0589-4925-9847-17cde7891388
  modified: 2026-11-05T22:33:33.485Z
---

**Current setup (2026-11-05):**
- ENGINEERS' link: https://avw-electrical-schedule.vercel.app. Vercel project `avw-electrical-schedule`, team-ashe, v1.1.6, Supabase DB, has 5 real projects. Deployed 2026-08-29 via CLI by account `bengilashe-9203`. The source is NOT on GitHub: it stores files in a different format (master_file is text, not bytes). Ashe said to LEAVE IT ALONE until v2 is proven.
- V2 link: https://avw-electrical-schedule-v2.vercel.app. Vercel project `avw-electrical-schedule-v2`, **v1.3.0 live since 2026-11-05**. Neon DB `avw-electrical-schedule-db` (free plan, env prefix SCHEDULE → `SCHEDULE_DATABASE_URL`). It holds 1 project made by Ashe; the suggestions table was empty at launch.
- Code: repo `ashe-sule/avw-electrical-schedule`, branch `vercel-and-engineer-fixes` (pushed; main is still v1.1.6). Local copy: `C:\Users\ashe\projects\avw-electrical-schedule`, linked to the v2 project. Deploy with `vercel deploy [--prod] --scope team-ashe --yes`. GitHub is not connected to Vercel (no auto-deploys).
- v1.2.0: Azure removed, no logins, UPPERCASE/60-char descriptions, CPU3 always a parent (keeps 2× M-7.5), master fixes (GA1, WS1, PO1-EL, OT2-PO1-EL, SOB, solenoids at 0.25A).
- v1.3.0 (South Morang EQ-1-1145 review; V2 now matches the engineer: 34 motors / 289 HP, 0 review items):
  - PS3H25 → PS3H25-1111 with 3× M-15. Ashe confirmed 15 HP; don't change it to 1.5 again.
  - Quote fixes: FW3D10 → FW3D10-AIR; `-CONVEYOR` typo → base code.
  - Master List: WC3CB0405-EL has 7× M-1.5; new OT2-WC3-EL has 3× M-1.5; BB1 → PSD10; J3179 keeps only its arch-only top-level definition; FILTERIT-RC-SF-480 is a 3-ph 20 GPM reclaim unit; TPA112i is 3-ph.
  - Engine: MCC lines merge into 1 row; the non-schedule list is now 30 parts.
  - Site voltage comes from the quote ("415V / 50Hz") or the country. Motor amps come from `motor_amps.csv` (engineer 400 V values: 1.5 HP = 2 A, 7.5 HP = 9 A, 15 HP = 19 A, 20 HP = 25 A); the rest use the Master formula.
  - Approvals page plus Suggest fix and Report a problem.
- Roles plan (Ashe, 2026-11-05): when sign-in arrives, **admins** approve and **users** only report errors and suggest. Until then everyone is admin (`User.role` in backend/main.py).
- Approved suggestions apply only to NEW projects (frozen into meta). The Master xlsx itself is not rewritten; "Download approved changes" gives a workbook for updating it in Excel.

**Still open:**
- Waiting on the engineer: GCBTL details (not in any list) and which "vacuums" get VA3246S/GCBTL as children (producers VAC-xxHP or arches VA5129A...).
- Engineer's drawing for South Morang used a Sobrite 100 GPM reclaim unit, but the quote has FilterIt 20 GPM. Flag it to the engineer.
- `motor_amps.csv` has 400 V values from one drawing only; the engineer should confirm and extend it.
- Later: switch the engineers over to v2. The 5 old projects can't be imported without bengilashe's code; export them to Excel first.
- Later: sign-in with admin/user roles (Ashe will ask).

**Gotchas:**
- Edit the master only through Excel COM (openpyxl loses formula values).
- Column AF is a separate list (rows 7–482). Before deleting rows above 482, copy AF to a temp sheet, then copy it back.
- The PartList table covers column D.
- In PowerShell 7 COM, write numbers via `.Formula` strings.
- `vercel curl` on Windows breaks URLs containing `&`.
- The auto-mode classifier blocks direct production DB reads.
- Long inline bash heredocs containing JSX or backticks fail; write the script to a file first.
