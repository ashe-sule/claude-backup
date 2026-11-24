---
name: projects-overview
description: "Master list of every project in C:\\Users\\ashe\\Documents\\projects — one-line status, where its full memory lives, and the cross-project rules. Read first on \"where did we stop?\""
metadata:
  node_type: memory
  type: project
  originSessionId: ff31189f-6708-454e-a989-0b88c4013ab1
  modified: 2026-11-24T19:56:10.716Z
---

All projects live in **C:\Users\ashe\Documents\projects\<folder>** on the new PC (moved 2026-11-24 from the old PC path C:\Users\ashe\projects). Each project's full memory is in `~\.claude\projects\C--Users-ashe-Documents-projects-<folder>\memory\` (old copies kept under `C--Users-ashe-projects-*`). Status below is as of the last saved session on the old PC — open the project's own `project-status.md` for detail before acting.

**Cross-project rules (always):**
- Never change production without Ashe's OK — HubSpot prod (Hub 21617654), avwforms / `avw-internal-request-hub` (LIVE, read-only), real QB file, live DBs, prod deploys.
- Git identity: never expose the AVW email; commit as the personal address so Vercel deploys aren't blocked ([[git-identity-leak]]).
- Free tools only where possible; ASHE track (NexuCentri products) kept separate from AVW work ([[two-tracks-ashe-avw]], [[nexucentri]]).
- Ports: 3000 = qb-sync dev; 3100 = ICC / marketing workspace; 3123 used by another app — don't kill.
- Ashe is in US Central time (Illinois).

**AVW work track**
- **qb-sync** — Next.js + Neon + QBWC on Vercel (qb-sync-one.vercel.app). Last: 7356a75 pushed/deployed 2026-11-10; addf4e7 docs not pushed; Category export field 2026-11-23. Next: retest sandbox CEP tickets, QB error 3410, clean ICA test data.
- **avw-quoting-tool** — QB "Approve & Send" works on branch `quickbook` (local only, never merge w/o OK); demo 2026-11-19 went OK; PPT parts export 2026-11-23. Open: discount/resend tests, always-on qb-sync (go-live blocker).
- **pnr-import-kiosk** — live at pnr-import-kiosk.vercel.app; HubSpot audit done read-only 2026-11-20, Ashe to pick from "first 5". Prod key in .env.prod-readonly (CAN write — careful).
- **so-label-printer** — Electron JobBOSS SO → Zebra labels; v1.4.1 live 2026-10-29; "publish" = signed push to \\v-server share. Zebra test prints unconfirmed.
- **so-ship-label** — related label app (no git remote; copied from old PC).
- **AV-Waldo** (+ AV-Waldo-work) — dispatch/GPS app for Kenny; Supabase + Vercel; demo feedback built and LIVE 2026-11-20; AV-WALDO 2.0 proposal awaiting approval.
- **avw-electrical-schedule-equipmentx** — work in this folder (not avw-electrical-schedule); deploy = push to equipmentx main. Open: Heri's 400 V amps table, Novi quote.
- **electric-schedule-tool** — v1.3.0 on V2 link; engineers still on old link; waiting on engineer's 4 answers.
- **avw-marketing-workspace** — email+password sign-in commit a0a3b74 LOCAL ONLY (push = auto-deploy to Vercel, ask first); fake events FAKE:EVENT 1-3 in local DB.
- **avw-smartcare** — private preview live at avw-smartcare.vercel.app (2026-11-12); open: signed-in smoke test, spend cap, analytics, JobBOSS data load.
- **Intelligence Command Center** (AVW-ICC) — BI app QB quotes ↔ JobBOSS SOs; 98 tests pass, nothing committed yet; rotate secrets at end.
- **avw-invoice-generator** — live on Vercel, push to main = live; paused 2026-10-19, resume from ROADMAP.md.
- **visitors-tracking-system** — Chicago time fix pushed 2026-11-10; open: /admin/monthly uncommitted, tablet printer check.
- **avw-internal-request-hub** — LIVE PRODUCTION (avwforms). Read-only. Never edit/deploy.
- **avw-site-analysis**, **avw-arch-configurator** — no saved memory yet.

**ASHE / NexuCentri track**
- **ashe-portfolio** (ashesule.com) — live; contact = LinkedIn only, never an email.
- **KOINORIX** — CRM + help desk SaaS; milestones through M14 done, unpushed local commits; showcase on ashesule.com.
- **CORYNEXA** — ERP SaaS; blueprint approved 2026-11-18, Vercel + Supabase only, $0 budget.
- **cloudspend-iq** — FinOps app, 5 phases coded; deploy waits on Ashe's accounts.
- **hebron-consults** — client site on Vercel (team-ashe); waiting on owner's answers (step 3 of 8).
- **github-buildup** — hub for showcase repos (Sealed, Scio, WASH-SI, phishing trainer); all repos PRIVATE.
- **job-finder** — Python; no saved memory.

Related: [[project-pc-migration]]
