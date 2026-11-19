---
name: project-status
description: "Current status of the avw-quoting-tool QuickBooks push work (branch quickbook) and what's next"
metadata:
  node_type: memory
  type: project
  originSessionId: 27b261f2-fed3-4226-890c-0e2b2152c31b
  modified: 2026-11-19T18:08:00.583Z
---

- 2026-11-18: QB "Approve & Send" works end-to-end in QB ICA test file (quote #26917 → Estimate #36516). Details in repo QUICKBOOKS.md.
- Branch `quickbook` only — do not merge to main without Ashe's OK.
- 2026-11-19: Ashe asked what must be running for a demo of the QB push. Answer: QB Desktop on ICA file (multi-user), QBWC with qb-sync app, qb-sync `npm run dev -- -p 3000`, quoting tool `npm run dev -- -p 3001` on `quickbook` branch, `.env.local` QB_SYNC_URL=http://localhost:3000 + QB_SYNC_API_KEY, admin login, throwaway test quote.
- 2026-11-19: Demo of QB push given — Ashe said it "went OK". Both dev servers were already running (qb-sync :3000, quoting tool :3001). No code changes; only uncommitted file is auto-generated AGENTS.md (left as is).
- Still open: discount/missing-part/resend tests, QBSync user + auto-run setup, always-on qb-sync (go-live blocker), phase 2 create-missing-parts, tell Joseph about empty-quote autosave risk.

**Why:** keeps "where did we stop?" answerable across sessions.
**How to apply:** update after each commit, deploy, decision or test.
