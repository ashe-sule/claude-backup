---
name: project-status
description: "qb-sync current status — what's done, how it was tested/deployed, and what's next (check first for \"where did we stop?\")"
metadata:
  node_type: memory
  type: project
  originSessionId: cf4f708c-908e-426d-abd6-1e3d8117f34e
  modified: 2026-11-11T17:54:31.218Z
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

Environment notes: QB PC = Ashe's PC. Dev server can get reaped by low memory (start Claude Code with CLAUDE_CODE_DISABLE_BG_SHELL_PRESSURE_REAP=1); orphan `next dev` may linger and degrade ("Jest worker" errors) → taskkill and restart. Never change production without Ashe's OK ([[hubspot-prod-rule]]).

**Why:** Ashe asks "where did we stop?" at session start.
**How to apply:** read this first; update after every commit/deploy/decision.
