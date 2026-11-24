---
name: avw-quoting-tool
description: "AVW Quoting Tool → QuickBooks push (branch `quickbook`); PROJECT STATUS: Phase 1 works end-to-end in ICA, local commits only, nothing pushed/merged"
metadata:
  node_type: memory
  type: project
  originSessionId: 19421e3c-39eb-4cfd-b43b-9a62024636ca
  modified: 2026-11-23T16:40:54.219Z
---

# AVW Quoting Tool → QuickBooks "Approve & Send" — PROJECT STATUS (updated 2026-11-18, end of session)

## Rules (Ashe's)
- Repo `equipmentx/avw-quoting-tool` (private, equipmentx org; Joseph Ilashe commits to `main`). Work ONLY on branch **`quickbook`** (no "s").
- Do NOT merge / PR / cherry-pick `quickbook` into `main` until Ashe says it's done AND approves the merge.
  **Why:** Ashe: "when we are done we can merge but dont merge for now". **How to apply:** push only to `origin quickbook`, and only when Ashe says so.
- Test in the QB **ICA** company file only. Quoting tool's Supabase is the LIVE production DB → use throwaway test quotes only.
- Never drive the quote editor in Chrome and jump away mid-load (see incident). Use Next buttons / Review page only.

## Where the code is (ALL LOCAL COMMITS — NOTHING PUSHED TO GITHUB YET)
- Quoting tool `C:\Users\ashe\Documents\projects\avw-quoting-tool`, branch `quickbook`, 3 commits ahead of origin: f5d17d0 (panel + server actions), 63ca1ca (admins can Approve & Send own drafts), f921da4 (refuse empty quote). Files: components/quotes/QuickBooksPanel.tsx, lib/actions/quickbooks.ts, components/quotes/QuoteReview.tsx, QUICKBOOKS.md. Uncommitted AGENTS.md change is auto-written by `next dev` — ignore.
- [[qb-sync]] `C:\Users\ashe\Documents\projects\qb-sync`, new branch `quoting-tool` (from local main which has unpushed addf4e7): commit 08492fd — /api/quoting-tool/{push,status,customers}, src/lib/quote/{push,discounts,auth}.ts, db/quoting-tool.sql.
- Design: quoting tool server → qb-sync API (Bearer key) → Neon qb_sync_queue → QBWC → QB Desktop. Pre-checks (customer, every part, discount items) are read-only QB queries; held if anything missing/not allowed; never sends twice (external_id quote-<n>). Panel hidden unless QB_SYNC_URL + QB_SYNC_API_KEY set. ZERO Supabase schema changes.

## Setup done
- Neon: tables qt_customer_map + qt_quote_push created (Ashe OK'd 2026-11-18).
- Shared secret: qb-sync .env.local QUOTING_TOOL_API_KEY = quoting tool .env.local QB_SYNC_API_KEY (never shown). Quoting tool .env.local also has QB_SYNC_URL=http://localhost:3000 + Supabase URL + publishable key (Ashe pasted; Vercel env pull returns [SENSITIVE] placeholders — doesn't work). Folder vercel-linked to team-ashe/avw-quoting-tool (.vercel git-ignored).
- To run: qb-sync `npm run dev -- -p 3000` (QBWC points at localhost:3000), quoting tool `npm run dev -- -p 3001`. Servers get killed by Claude Code memory reaper → start Claude Code with CLAUDE_CODE_DISABLE_BG_SHELL_PRESSURE_REAP=1.

## Tested
- ✅ 2026-11-18: "TEST QB - Kaady" #26917 (Generic 60ft template, $451,977.36, no discount) → QB customer `KAA01:Kaady Equipment CO._2545 SW Spring Garden` → ICA **Estimate #36516**, total matches, Ashe confirmed in QB. 33 parts all found. Customer search works (~1 min); timeout message works when QB was closed.
- Checks: tsc + eslint both repos, quoting tool `next build`, discount rules parity with scripts/lib/discounts.mjs.

## Incident (2026-11-18)
- Ashe's test quote "Test-Kaady" #26915 (~$279k) was wiped to "Untitled Quote $0" in live Supabase right after Claude (Chrome) clicked Open then jumped to /review ~3s later. Likely ConfiguratorShell.tsx save-on-leave/autosave saved unloaded state. Pre-existing app risk → **tell Joseph** (not fixed; outside QB scope unless Ashe asks). Ashe said "that's ok".

## Side task (2026-11-23, DONE): PPT Tunnel Layout part-number export
- DONE: `Downloads/PPT Tunnel Layout Existing List - UPDATED.xlsx`. Rows 1-138 are unchanged, row 140 is "UPDATED PARTS" (bold, yellow), and the FINAL file has 161 new part numbers in col B rows 141-301 (configurator option values + 24 generated blower BL0522D* combos). 80 bundle sub-parts were added, then REMOVED at Ashe's request ("don't need the sub parts"). Ashe closed the session happy.
- OPEN: SUPABASE_SERVICE_ROLE_KEY is STILL in quoting tool .env.local. Ask Ashe next session whether to remove it or rotate it. Verified: no duplicates, no overlap with the original.
- Not exported (no part number in the tool): Purclean 15,000/6,000 RO, 400-gal Purclean/WTC reject tanks.
- Ashe added SUPABASE_SERVICE_ROLE_KEY to quoting tool .env.local (2026-11-23). Read-only use. Suggested removing or rotating it afterwards.
- Original notes below:
- Ashe wants every part number in the configurator from `presoak` (Equipment tab) through the end of the Backroom tab (order: lib/quote/quoteOrder.ts) that's NOT already in `Downloads/PPT Tunnel Layout Existing List.xlsx` (sheet "Tunnel Equipment", col B "Part Number", 137 rows).
- Output: a NEW copy named "...Existing List - UPDATED.xlsx". Add a divider row "UPDATED PARTS", put the new part numbers under it. Part number only: no description, other columns left blank.
- Blocker: catalog RLS = authenticated only. Public key returns 0 rows. .env.local has no SUPABASE_SERVICE_ROLE_KEY. The app has no catalog page (only inside the quote editor, which is the incident risk). Asked Ashe to add the service key to .env.local themselves.

## NEXT (in order)
1. Test discount path (10% for Kaady should be HELD; customer type allows 40% = ES04).
2. Test held path (part missing in QB → "Needs attention" + list) and double-click/resend guard.
3. One-time QB setup with Ashe at QB PC: QB user `QBSync` (customers/items/estimates only), authorize app once in single-user mode with "allow even if QB not running" + auto-login QBSync, back to multi-user; QBWC Auto-Run every 1 min. Never let app log in as Admin.
4. Always-on: run qb-sync as Windows service on QB PC (recommended next), later Cloudflare Tunnel or dedicated QB PC/VM. QB Desktop has no cloud API — QB PC + Windows login + QBWC must stay on; quotes queue while it's off.
5. Phase 2: "Create missing parts" button (approve-first). Optional: QB status badge on dashboard.
6. Before go-live: real company file needs one-time authorization again; run Pre-Launch Checklist; push branches (Ashe's OK); merge only on Ashe's approval.
7. Cleanup: ICA estimates #36513–#36516; quoting tool test quotes "TEST QB - Kaady" (#26917, now approved) and emptied "Untitled Quote" (#26915); also #26901 "Test- Kaady Equipment" was approved via plain Approve earlier.
8. Ask Ashe whether to push qb-sync main's unpushed addf4e7 + quoting-tool branch to GitHub.
