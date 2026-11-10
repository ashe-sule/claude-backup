---
name: koinorix-project-status
description: Current KOINORIX build status — last milestone done, how tested, what's next (updated 2026-11-10, M12 committed)
metadata:
  type: project
---

- Last done: **Milestone 11 — launch readiness (code side)**, commit 51a4b66, tested 2026-11-06 (unit 112/112, integration 140/140 on Neon dev, E2E 41/41). Never deployed yet.
- **M12 — Tickets v1 DONE: committed 588bf47 on main 2026-11-10; pushed to GitHub origin/main 2026-11-10 (M10–M12 all pushed); not deployed.** Results: unit 124/124, integration 157/157, E2E 43/43, npm run check ✅. Migration 20261110000000_tickets applied to Neon dev only. ADR-047. Owner decisions 2026-11-10: internal helpdesk only — list, new form, ticket page, per-org number, status New/Open/Waiting/Solved/Closed, priority, assignee, link to contact/company/deal, internal notes, tickets on contact/company pages. No email in/out or customer portal until email provider exists. Free plan: 100 open tickets (solved/closed don't count); paid plans unlimited.
- Next after M12: owner to choose M13 — workflow automation v1 or deploy readiness.
- Owner-account steps still open (docs/RUNBOOK_LAUNCH.md): prod Neon branch + PITR + restore drill, Vercel deploy, Resend account + SPF/DKIM/DMARC, Sentry DSN, CI test secrets, legal text placeholders. Stripe deferred by owner (M8b).

**Why:** user asks "where did we stop?" at session start.
**How to apply:** read this + docs/IMPLEMENTATION_STATUS.md; update after every milestone/commit/deploy. See [[koinorix-founder-context]].

**Showcase screenshots (2026-11-10):** owner wants only screenshots for their website ("I can build any CRM"); NOT deploying now, no domain purchase now. `scripts/seed-showcase.ts --reset` builds fake org "Harbor Ridge Solutions" (slug harbor-ridge-solutions-913768, owner jordan.rivera@showcase.test, set to PRO on Neon dev) with 5-month backdated history, custom fields, stage histories. `SHOWCASE_SLUG=<slug> npx playwright test -c tests/showcase/playwright.config.ts` → `showcase/raw/` (18 screens) + `showcase/website/` (8 framed images with headlines). Owner decision ADR-048: "Soon" removed everywhere; unreleased modules (Leads, Automation, connectors, online checkout) hidden until they work. Checks passed (npm run check, unit 124/124, affected E2E 10/10). All uncommitted until owner asks. Owner asked why automation isn't built: it was offered for M13, not yet chosen — next candidate. Still open: charts (option C).

**Owner decisions 2026-11-10 (after screenshots):** committed 251a2a4 (showcase tooling + ADR-048). Build ALL of roadmap sections 1 (core CRM) + 2 (help desk extras), one milestone at a time, fully tested, report after each and keep going unless told stop. Order: M13 charts/dashboards → M14 automations → M15 leads → M16 global search + saved views → M17 bulk edit/merge → M18 reminders + notifications → M19 forecasting + targets → M20 required fields + more imports/exports → M21 attachments → M22 help desk (portal, SLAs, ticket fields, export) → polish (amounts w/o cents, date format, board width). Email-to-ticket waits for email provider. Then: higher deal values in demo data, retake pictures, critique, and post to the owner's projects list on **ashesule.com** (hosting unknown — ask how it's hosted).
