---
name: cloudspend-iq-project
description: "CloudSpend IQ multi-cloud FinOps app — separate repo, 5-phase plan, Phase 1 done 2026-10-24, user checks in between phases"
metadata:
  node_type: memory
  type: project
  originSessionId: b6dc9bdb-3b61-413b-bdc9-ccd1cd93f824
  modified: 2026-10-28T21:35:29.348Z
---

CloudSpend IQ (AWS+Azure FinOps portfolio app) lives in C:\Users\ashe\Documents\projects\cloudspend-iq (separate from ashe-portfolio, which is static HTML). Stack: Next.js 16 (Cache Components), Drizzle (user chose over Prisma), PGlite locally/tests, Neon planned for prod, Vercel. Spec = user's long "MASTER DEVELOPMENT PROMPT" (25 sections, phases 1–5).

UPDATE 2026-10-28: all 5 phases are committed in the repo (Phase 5 = 903ed45: accounts, roles, demo sandbox) and the portfolio has a CloudSpend IQ page (e9de557). The phase notes below are history.

Phase 1 completed 2026-10-24, then a QA pass the same day (independent review + axe + low-end Android perf) fixed 13 issues; now 70 unit/integration + 25 e2e passing. Still uncommitted pending user OK. QA findings log: docs/TEST-RESULTS.md. Phase 2 (FOCUS 1.2 / CUR 2.0 / Azure import + Cost Explorer) is next and requires researching real column names from official docs.

**Why:** user's CLAUDE.md requires approval before taking on tasks; they approved Phase 1 then expect a check-in.
**How to apply:** confirm before starting each new phase; PGlite is single-process (stop dev server before db scripts); case study goes at ashesule.com/projects/cloudspend-iq only after deployment. Status docs: docs/ROADMAP.md, docs/TEST-RESULTS.md. Related: [[buildup-roadmap-location]]
