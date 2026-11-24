---
name: avw-marketing-workspace
description: "AVW Marketing Workspace — rebuild of marketing team's ChatGPT tracker; Studio redesign approved + built on git branch studio-redesign (2026-11-17); local only, not deployed"
metadata:
  node_type: memory
  type: project
  originSessionId: 0abeee43-d1f4-4532-8a17-0334ca8dfd59
  modified: 2026-11-17T21:02:40.914Z
---

## WHERE WE STOPPED (2026-11-17, end of day — Ashe: "save all, continue tomorrow")
- Folder `C:\Users\ashe\Documents\projects\avw-marketing-workspace`. Read **STATUS.md** there first (handoff + open decisions).
- Local git only (no GitHub remote). `main` = Phase 1 baseline 55cbf17 + tag `pre-studio-redesign`. Branch `studio-redesign` (checked out) = Studio UI da3f2ae + handoff 34658d2. Working tree clean. Commit email = yahoo (OK for private; never AVW email — [[git-identity-leak]]).
- Local server was STOPPED. Run: `npm run build` then `npx next start -p 3100`; dev logins admin@example.com / jordan@example.com / sam@example.com (fake). DB = PGlite `./.local-db` (gitignored) with demo data. Background servers get killed when the PC is low on memory — just restart when asked.
- Before/after screenshots: `docs/redesign-screenshots/` in the repo.
- **Open decisions for Ashe:** (1) review → "merge it" (studio-redesign → main); (2) members can now see Team page (emails + workload) — OK?; (3) board lets a card jump to Launch without approval (old behaviour) — lock it?; (4) has marketing team agreed to replace their ChatGPT version?
- **Before go-live (each needs OK):** real Android phone check (phone layout only simulated); private GitHub repo → Vercel + Neon → Entra app registration (tenant GUID, secret expiry reminder) → env → migrate → deploy; pre-launch checklist gaps (Sentry #9, backup/restore #10, analytics #16, rollback plan #20).

## Project facts
- Track: AVW ([[two-tracks-ashe-avw]]). Marketing team only; host on Vercel. App name stays "AVW Marketing Workspace".
- Stack: Next.js 16.4 + Neon Postgres (same pattern as [[avw-invoice-generator]]), Microsoft Entra ID OIDC+PKCE; only users on Team page (or BOOTSTRAP_ADMIN_EMAILS) can enter. `DEV_LOGIN=1` local only.
- Studio UI: TopNav.tsx (top nav + phone tab bar), studio.tsx (Cover/StageBar/Runway/ProjectCard), DecideButtons.tsx; routes /, /projects (gallery|list|board, ?channel=), /projects/[id], /projects/[id]/edit, /projects/new, /launches, /approvals, /templates, /team, /account (= "More" on phones); /backlog, /week, /w/[slug] redirect. Fonts self-hosted (Bricolage Grotesque + Inter). Colours: ink #0B1630, AVW blue #1F4E9D, amber = decision, coral = late, green = live.
- DB additive only: projects.cover_url, project_links.kind.
- Phase 2 ideas: AI drafting, Teams/Outlook reminders, recurring tasks, reports, SharePoint files.

## History of the design rounds (why it looks like this)
- Ashe rejected reskins twice ("DO NOT RESKIN, REIMAGINE"); wants designs shown first and approval before coding. Lesson: show mockups, stop, wait for pick ([[brand-voice-professional]]).
- Mockup links: concepts A/B/C https://claude.ai/artifact/RjFbNVW8pCaBntceVSsdfw; overhaul directions Editorial https://claude.ai/artifact/Xrniq2bVgLDAMc55wMrcpp, Mission Control https://claude.ai/artifact/WD9URqohUPtCMKynHsGCny, Creative Studio https://claude.ai/artifact/WwZUf4ioWU2o1LeojiHLTh; **approved Studio proposal** https://claude.ai/artifact/GRBFni4nBPShF7wg3uF41b.
- Source: 15 photos (Downloads) of the marketing team's `*.chatgpt.site` tracker; they had Basecamp open in another tab.
