---
name: project-status
description: "CORYNEXA current status — what's done, what's next, open approvals"
metadata:
  node_type: memory
  type: project
  originSessionId: 794fb6ff-57e3-48fa-83a5-6bc10d3695a1
  modified: 2026-11-19T14:26:52.112Z
---

CORYNEXA = AI-powered multi-tenant SaaS ERP, a NexuCentri product (Ashe's own track, separate from AVW work).

**Blueprint (Phase 0):** Claude Doc "CORYNEXA Product & Engineering Blueprint" https://claude.ai/artifact/8c4cxkc69QDsTpHBMAxwHu

**Decisions (2026-11-18, Ashe approved):**
- Blueprint recommendations APPROVED: MVP scope (finance + O2C + P2P + inventory ledger + Manufacturing Lite + Migration Studio v1 + AI v0 read-only), beachhead, and pricing hypothesis
- Stack OVERRIDE: everything on **Vercel + Supabase only**. The AWS/NestJS/WorkOS/pg-boss/Bedrock plan is dropped.
- Budget: **$0**. It's a "play" project with no hires or agency; Ashe + Claude build it all, and slow is fine. No 7-person or 10-month plan.
- Legal entity: not set up. Add an entity/legal checklist to the plan (no action needed now).

**Implications to flag:** Vercel Hobby is non-commercial only; the Supabase free tier pauses after 7 days idle and caps the DB at 500MB; the Claude API is not free, so AI v0 needs a decision (skip or defer).

**Done 2026-11-18:** blueprint doc updated (rev 19). Decisions table now shows the final calls, the questions list is updated (AI v0 budget question added), "Superseded" notes sit under Sections E and G, and a new "Phase 1 build plan (free tier)" section was added after Decisions. It covers the stack + free limits, 8 M1 steps each with a check, the M1 gate, and Ashe's account setup checklist.

**Phase 1 plan APPROVED 2026-11-18. M1 step 1 built:** Next.js 16.4.6 + TS + Tailwind 4, Vitest 5.1.1 (v3 had critical CVEs), @types/node 24, CI workflow (lint/typecheck/test/build), /api/health, security headers, .gitattributes LF. Local checks + build + prod-server probe all pass. Commit 010342d. Private repo https://github.com/ashe-sule/corynexa created, but the push was REJECTED because the gh token lacks `workflow` scope. Ashe fixed the scope and pushed; **CI run 44393168732 is GREEN** (2026-11-18). M1 STEP 1 DONE. To-do: bump actions/checkout + setup-node to v5 (Node 20 deprecation warning) in the next PR. NEXT = step 2 (Supabase dev project + migrations), waiting on Ashe to create a Supabase account. Future work goes through PRs on branches, not straight to main. Env: no Docker, no Supabase CLI (use npx supabase + hosted dev project). Typecheck = `next typegen && tsc --noEmit`.

**PR #1 (2026-11-18)** https://github.com/ashe-sule/corynexa/pull/1, branch m1/db-tenancy, CI GREEN, NOT merged (waiting on Ashe). Contains: migrations 20261118000001_tenancy.sql (companies, company_members w/ app_role enum, profiles, private.is_member/has_role/shares_company, create_company RPC with 10/user cap, last-owner guard, column grants) and 20261118000002_audit_log.sql (append-only, no FK on company_id); 22 PGlite tests in supabase/tests (harness stubs auth.uid/roles), mutation-checked; Supabase SSR clients in src/lib/supabase, src/proxy.ts protects /app (fails closed without env); config.toml hardened; .env.example; /login placeholder. Pinned: supabase-js 2.119.0, ssr 0.12.7, pglite 0.5.15, supabase CLI 2.122.1 (versions picked to be at least 2 weeks old).
Ashe said "keep building your part, accounts later". Pending Ashe: Supabase account + corynexa-dev project (East US), gh workflow scope (run in a normal PowerShell window), merge PR #1, AI v0 decision.
**PR #2 (2026-11-18)** https://github.com/ashe-sule/corynexa/pull/2, branch m1/auth-shell, stacked on #1 (base m1/db-tenancy), CI GREEN, not merged. Auth screens in src/app/(auth) (server actions + zod, no enumeration, safeNext), /auth/confirm (code + token_hash), POST /auth/signout, app shell src/app/app (layout w/ Suspense + getAppContext in src/lib/app-context.ts, cx_company cookie, create_company RPC), 404/error/global-error. 53 tests. The auto-mode classifier DENIED `gh pr merge`, so Ashe must merge PRs (#1 then #2) or grant permission.
**PR #3 (2026-11-18)** https://github.com/ashe-sule/corynexa/pull/3, branch m2/general-ledger, stacked on #2, CI GREEN. Migration 20261119000001_general_ledger.sql: accounts (33-acct default CoA seeded by trigger on companies insert), fiscal_periods (monthly, open/soft_closed/closed, overlap trigger), journal_entries/lines (immutable, composite FKs, deferred balance constraint trigger), private.post_entry engine + public post_journal / reverse_journal / set_period_status / create_fiscal_year / trial_balance. 33 ledger tests (61 DB total). Finance UI under src/app/app/finance (journals, new journal w/ idempotency key, detail+reverse, accounts, reports TB/P&L/BS, periods). Money helpers in src/lib/money.ts (bigint units), summarize in src/lib/finance-shared.ts. NOT yet verified against a real Supabase (PostgREST embeds etc.).
**Independent security review (subagent, 2026-11-19):** no critical issues; 1 high, 2 medium and 6 low, ALL fixed in **PR #4** https://github.com/ashe-sule/corynexa/pull/4 (branch m2/security-hardening, stacked on #3, CI GREEN). Migration 20261119000002_security_hardening.sql: advisory lock on idempotency, soft-close reopen = owner/admin, last-owner guard locks + allows user deletion, global default-privilege revoke, INVITATIONS replace direct member inserts (invite_member/accept_invitation/delete_invitation/my_invitations). Harness mirrors Supabase default grants; security.test.ts privilege sweep has an allow-list of authenticated RPCs (update it when adding RPCs!). App: site-url.ts (no Host header), reversal date picker, /app/team page, invites on dashboard. 76 DB + 53 unit tests. docs/SETUP.md = go-live checklist.
STOPPED HERE to ask Ashe (2026-11-19): merge PRs #1→#4 (in order, or allow the gh merge permission), then Supabase account + project so everything can be tested end to end before building AR/AP.
**Session closed 2026-11-19 by Ashe ("will continue later").** Checked via gh: PRs #1–#4 are all still OPEN. Ashe has the ask list: (1) merge #1→#4, (2) create Supabase corynexa-dev and share the URL + publishable key, plus optional gh workflow scope refresh and the AI v0 decision. On resume, check the PR state first, then go to docs/SETUP.md step 2 (db push) if Supabase is ready.
Ashe's instruction (2026-11-18): "keep working, do all you don't need me for, only contact me when you need me".
(old) NEXT for Claude: step 4 auth screens (sign-up/in/reset/invite via server actions), step 7 app shell (sidebar, company switcher, create company).

**Old next step (done):** Ashe reviews and approves the Phase 1 plan, then sets up GitHub (private repo `corynexa`), a Vercel Hobby account and a Supabase free account, and installs Node LTS, Git and the Supabase CLI. Then M1 step 1 (repo + tooling). Still open: AI v0 (skip vs small cap), pilots, legal entity (later).

**Hard rules:** no code until Ashe OKs the Phase 1 plan; never push to production without explicit authorization; never invent stats.

**Why:** Ashe wants a running status so any session can answer "where did we stop?".
**How to apply:** Update this file after each decision, deliverable, commit or deploy.
