---
name: project-status
description: "qb-sync current status — what's done, how it was tested/deployed, and what's next (check first for \"where did we stop?\")"
metadata:
  node_type: memory
  type: project
  originSessionId: cf4f708c-908e-426d-abd6-1e3d8117f34e
  modified: 2026-11-23T20:34:13.264Z
---

**Last saved: 2026-11-10 evening. Commit 7356a75 on main, pushed, Vercel deploy success. Working tree clean.** Full detail in repo CLAUDE.md → "Session 2026-11-10" (parts 1 and 2).

Done 2026-11-10:
- **Quote → QB Estimate** (commit d6955a4): `scripts/queue-estimate.mjs` (--check, --commit, --status, --resend), QB auto-numbers, tool # in Memo, Amount sent explicitly, discounts 00SBT + ES/PS ([[qb-discount-items]]), mismatch held for review. Proven in ICA (#36514, #36515). Quoting tool NOT linked yet (Ashe wants auto-send later; needs customer map, QB names like `KAA01`).
- **CEP rebuilt** (commit 7356a75): edit-before-approve page, only changed fields sent, one-account vs two-account parts, review flag + checkbox for changes beyond the ticket's reason ([[cep-requirements]]), nav glitch fixed. 7 of 9 sandbox test tickets verified in QB.

2026-11-11: added `docs/QUOTING-TOOL-QB-SETUP.md` (quoting tool → QB setup, unattended QBWC, QBSync user) — commit addf4e7, NOT pushed yet. See [[qb-unattended-setup]].

Next (start here):
1. Retest sandbox ticket 51025999173 (**Inactive**, WS192GR100GPM), then 51036943143 (**Active**, shows "Retry — re-approve"). Reload pages first. Needs QB open on ICA + `npm run dev` + QBWC.
2. Understand QB **3410** on an IsActive-only Mod ("closing date password"). If it repeats, it's a QB setting for Ashe/accountant — don't change QB prefs.
3. Clean up ICA test data: estimates #36513–#36515; test edits on the 10 parts created 2026-11-10.
4. Later: quoting-tool auto-send + customer map; Reject → HubSpot write-back; Cloudflare Tunnel / Windows service for QBWC; rotate Neon password.

2026-11-23 QB LIST PULLS built (branch quoting-tool, NOT committed yet): replaces Ashe's manual Customer/Vendor/Items.xlsx exports for avwforms. Ashe approved + tables created in Neon: qb_list_pull, qb_list_snapshot (db/qb-lists.sql). Code: src/lib/qb/lists.ts (steps, iterators, parser), src/lib/qb/list-export.ts (xlsx/csv same columns, Sheet1), /api/lists/[list] (download; on Vercel needs QB_LISTS_DOWNLOAD_KEY), /lists page (Pull now), hook in api/qbwc/route.ts (runs only when queue empty). Env: QB_LIST_EXPORT_DIR=OneDrive Documents/QB Lists. **Ashe decision 2026-11-23: NO nightly pull — button only ("Pull now"), because QB may be on the wrong file.** Each pull records the QBWC company file (company_file col); optional QB_LIST_COMPANY_FILE env refuses any other file — set it after the first live pull. Neon pooler caches select * plans → use explicit columns. First queued pull cancelled. tsc+lint OK. First pull queued (095ee08f) against Ashe's LIVE QB file (read-only, Ashe OK'd). Next: run QBWC Update Selected, compare output vs Ashe's manual exports (discount price sign, custom field names Category/Item Discount Category, active-only). Phase 2 (avwforms reads live) needs OK. Also walk Ashe through QBSync unattended setup. BLOCKED 2026-11-23: live file never granted qb-sync access (QBWC "application has not accessed this company file before"); grant needs Admin + single-user mode, staff busy → do after hours (create QBSync user, "Yes, always… even if QB not running", login QBSync, back to multi-user). Offered ICA test meanwhile. Warn: once live file is granted, CEP approvals / quote pushes also hit LIVE QB.

Environment notes: QB PC = Ashe's PC. Dev server can get reaped by low memory (start Claude Code with CLAUDE_CODE_DISABLE_BG_SHELL_PRESSURE_REAP=1); orphan `next dev` may linger and degrade ("Jest worker" errors) → taskkill and restart. Never change production without Ashe's OK ([[hubspot-prod-rule]]).

**Why:** Ashe asks "where did we stop?" at session start.
**How to apply:** read this first; update after every commit/deploy/decision.

2026-11-23 ICA TEST PULLS ✅ (pulls cc08c315 + 5e0a88e6, ~1.5 min, ~14.4k records, no warnings). Files land in OneDrive Documents/QB Lists. Compared vs Ashe's manual (LIVE) exports: active-only ✅; account numbers fixed via AccountQueryRq step ("7400 · …") ✅; blank cost/price + ".." line breaks match QB export ✅; leftover diffs = ICA is an older copy (prices, descriptions, vendors). **Gap: "Category" column (LABOR/Uncategorized) is QB's Item Category feature — NOT exposed by the SDK (checked qbXML 13 and 16).** update_data.py keeps old values when blank, so existing parts keep Category; new parts get blank. Awaiting Ashe: Category decision; after-hours live grant; then set QB_LIST_COMPANY_FILE. NOT committed yet. Neon: qb_list_snapshot check now allows 'account'.
2026-11-23 later: Ashe says Category is REQUIRED ("I need the category") and was ready to drop the automation. Offered: (A) a QB custom field "Category" that we fill once from Ashe's last manual Items.xlsx (writes to live QB, needs OK), with new parts filled by the PNR flow (HubSpot part_number_category); (B) a hybrid where Customer/Vendor are automatic and Items stay manual; (C) a quick ICA test of whether a QB report query exposes Category (low odds). Awaiting a pick.

2026-11-23 Option C DONE (read-only probe on ICA, now removed): ICA = QB Enterprise Mfg & Wholesale 24.0, supports qbXML 1.0-18.0. ItemQuery at v13/16/17/18 with OwnerID 0 returns NO Category (only custom fields Price List Type, Item Discount Category, Surcharge). CustomSummaryReport has no Category either. Conclusion: Category unreachable via SDK. Category values in live export look like PNR categories (BLTCNVYRS, FTTNSPLUMB, LABOR, Uncategorized...; ~95 values). Ashe idea: custom field e.g. "Category-Dont touch" for export only (Option A). Awaiting go-ahead for A.

2026-11-23 END OF SESSION: Ashe chose field name "Category(For Exports Only)" ([[qb-category-export-field]]). Proposed a monthly Category re-sync from a manual export so staff do nothing extra; awaiting OK. Steps: (1) Ashe adds the custom field in ICA, (2) backfill from manual Items.xlsx, (3) export reads the field + NPR/CEP/New Item set it, (4) live after hours. List-pull work COMMITTED on branch quoting-tool (local, not pushed). Dev server reaped again; not restarted.
