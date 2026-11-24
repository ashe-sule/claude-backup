---
name: project-status
description: "AVW-ICC build status — what's done, tested, and next (update every session)"
metadata:
  node_type: memory
  type: project
  originSessionId: 388de537-7e8f-4684-b80a-c84facf27166
  modified: 2026-11-12T22:08:18.294Z
---

**AVW Intelligence Command Center (AVW-ICC)** — started 2026-11-12 from a master spec the user pasted (internal BI app for AVW Equipment: QuickBooks Desktop quotes ↔ JobBOSS sales orders matching, revenue recovery, value ledger; later margin guard, competitor research, AI). Year-end 2026 deadline for a measurable win.

Repo: `C:\Users\ashe\Documents\projects\Intelligence Command Center` (npm workspaces: packages/shared, apps/web = Next.js 16.4, apps/agent = on-prem connector). Git initialized, **nothing committed yet** (user hasn't asked).

Decisions (2026-11-12):
- On-prem agent (Node/TS, Windows service via NSSM) hosts QuickBooks Web Connector SOAP endpoint on 127.0.0.1:8085 + reads JobBOSS SQL read-only (configurable SQL mapping, UNVERIFIED classic table names), pushes OUTBOUND to ICC /api/ingest with hashed bearer tokens.
- Postgres via Drizzle; PGlite for dev/tests (no Postgres/Docker on dev PC). Cache Components disabled.
- Auth: Microsoft Entra ID OIDC (AUTH_MODE=entra); dev login only with AUTH_MODE=dev.
- Admin cannot approve ledger; approver ≠ creator. Customer identity only via confirmed mapping.
- Dev server uses **port 3100** — port 3000 is the user's other app "AVW QB Sync" (don't kill it).

Done & tested 2026-11-12: 98 tests pass (core, agent, embedded-Postgres integration); typecheck + production build pass; live E2E with mock agent → ingest → matching → pages for 6 roles; 0 prod npm vulns. Built: Quote Assurance, customer mapping, follow-ups, Value Ledger + Finance approval, year-end report (/reports), integrations health, users/roles, hash-chained audit log, CSV export. Docs in /docs (01–06).

Not tested: real QB/QBWC, real JobBOSS, Entra SSO, browser form clicks, real Postgres server.
Planned (not built): Margin Guard (next), Competitive Intel (workbook file missing), Customer Opportunities, AI/MCP, error tracking, email alerts.

Open questions for AVW (blocking): QB Desktop edition/version; JobBOSS classic vs JobBOSS²; approval for read-only SQL login; hosting choice; Entra app registration; examples of how QB quote # is typed in JobBOSS; competitor workbook.

Update 2026-11-12 (afternoon), after user confirmed QB 24 / JobBOSS 18 / Azure and pointed at qb-sync + avw-smartcare:
- Matching now uses AVW's proven chain: QB estimate → (LinkedTxn | invoice memo "E nnnnn" | memo "Q nnnn"→estimate's Quoting Tool #) → QB invoice → (Packlist_Header.Invoice | invoice custom field "Job/Packing Slip No." PL#) → JobBOSS pack list → SO. Evidence code REF_EXACT_INVOICE_CHAIN (+55).
- Customers auto-linked via JobBOSS Customer.QB_ID (linkSource "jobboss_qb_id"); user overrides sticky ("user"/"user_unlinked"). QB jobs inherit parent company mapping.
- Pre-2024 QB SalesOrder links count as QB-native conversion (Probable).
- "Data as-of" (lib/asof.ts): ages/expiry/default ranges measured from QB data end (sandbox ends 2025-04-17), banner shows QB vs JobBOSS coverage.
- Agent JobBOSS reader rewritten to JobBOSS 18 proven columns only, SmartCare connection settings, window sync (120d + open) + daily full sweep, pack lists. Invoice qbXML uses OwnerID 0 for custom fields; htmlEntities decode.
- Migration 0001_invoice_chain. 113 tests pass; typecheck clean; live mock E2E: 25 Confirmed via chain, banner correct.
- Docs: 01 rewritten with confirmed facts; new 07-AZURE-DEPLOYMENT.md (not executed).
- Flagged: rotate qb-sync Neon connection string (was pasted in chat); production needs dedicated JobBOSS service login (not Ashe_SQL_RO).
- Next: confirm QB edition; Entra app reg + Azure resource group; install agent on QB PC; run discover-jobboss/test-jobboss against V-JOBBOSS; reconcile counts; pilot. Nothing committed to git yet.

Update 2026-11-12 (evening): added simple local login (AUTH_MODE=local): email + random generated password (scrypt hash), 5 failed tries → 15-min lock, admin "Reset password" button (shown once), `npm run admin:create -w web -- --email .. --name ..` writes password to apps/web/.data/ADMIN-LOGIN-delete-after-reading.txt (never printed). Local dev now runs AUTH_MODE=local; admin = ashe@avw.local. 116 tests pass. Explained the daily "full sweep" (no proven Last_Updated column in JobBOSS) — awaiting user's choice whether to keep it.

Update 2026-11-12 (late):
- Admin is now ashe@test.com (ashe@avw.local deleted). No Azure, no Entra for now; using Ashe_SQL_RO (no new account).
- JobBOSS reader: incremental by Last_Updated (5-min overlap), NO daily sweep, checkpoints advance only after enqueue. test-jobboss ran OK against real V-JOBBOSS (counts only).
- Refs: "QBQ#nnnnn"/"QB quote" = QB estimate (strong). "Quote: nnnn" in JB notes = kind jobboss_quote → never matched to QB. 122 tests pass.
- Side idea logged: build own Quote→Sales Order app (QB estimate → JB SO, auto-stamp QB #). Recommended for early 2026, needs write-access approval, ECI supported import/API, JB test DB. Not started.
- Dev server (port 3100) was stopped by Claude Code due to low memory; not restarted.
- Waiting on user: run first real JobBOSS load now or after hours? Then QB sandbox via QBWC, map 449 customers without QB_ID.

Paused 2026-11-12 end of day ("save all, continue tomorrow"). Resume plan for 2026-11-13:
1. Ask: first real JobBOSS load now or after hours? (still unanswered)
2. Restart dev server: `cd apps/web && npx next dev -p 3100` (login ashe@test.com). Never touch port 3000.
3. After load: compare counts vs JobBOSS (19,261 SOs, 1,045 customers).
4. Then QB sandbox via QBWC; then map 449 customers without QB_ID; Margin Guard in Dec.
All code is saved on disk; nothing committed to git (user hasn't asked).

How to apply: read this first when asked "where did we stop?"; update after each milestone.
