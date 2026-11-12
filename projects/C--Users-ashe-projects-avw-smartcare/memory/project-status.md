---
name: project-status
description: "Current SmartCare project status — what's done, how deployed, what's next (keep updated)"
metadata:
  node_type: memory
  type: project
  originSessionId: 7d6b9238-7def-46c5-b65b-40a4ff0865ff
  modified: 2026-11-12T14:11:30.208Z
---

**2026-11-12: Private online preview LIVE** at https://avw-smartcare.vercel.app (to show Ashe's boss).
- `often-bought-together` fast-forwarded into main (typecheck/lint/221 unit tests pass); untracked __pycache__; pushed to PRIVATE GitHub repo `ashe-sule/avw-smartcare` (git-connected, so pushes to main auto-deploy).
- Vercel: team `team-ashe` (Pro), project `avw-smartcare`, root dir `web`, Node 24.x. Linked in both repo root and web/ (.vercel ignored).
- DB: Neon free_v3 `avw-smartcare-db`, us-east-1, connected to Production + Preview only (local dev keeps local PGlite; never `vercel env pull` into .env.local). Loaded from backup `data/backups/20261112-140502` (61 tables, 612,959 rows, fingerprints verified).
- New BETTER_AUTH_SECRET (sensitive) for prod/preview; BETTER_AUTH_URL=https://avw-smartcare.vercel.app; SAFETY_LOCK_OWNER_EMAIL copied. Staff logins came across with the data.
- Checked live: /api/health ok, / redirects to sign-in, noindex. Vercel deployment protection does NOT block the production URL; the app's own login protects it.
- Ashe chose to share their own admin login with the boss (advised against).
- Open: Ashe to do a signed-in smoke test; claudetest@smartcare.local admin account also copied to cloud (deactivate or reset); set Vercel spend cap; turn on Vercel Analytics; data is a snapshot (no sync yet).

Related: [[smartcare-review-fix-list]]

**2026-11-12: Ashe now has JobBOSS access** (type of access not yet confirmed). JobBOSS was never loaded; all data so far is QuickBooks (backup Apr 17, 2025) + webstore. Plan in docs/02-data-discovery.md + docs/phase0-data-request.md (J1–J8 must-have, J9 BOM, J10 invoices; open questions: serial #s, distributor flag, Webstore→JobBOSS?, SO # on QB invoice). Next: confirm access type, then map the `live` schema read-only.
- 2026-11-12: Connected to JobBOSS as `Ashe_SQL_RO` (db_datareader only; not writer/owner/sysadmin). SQL Server 2019, db LIVE on V-JOBBOSS. Credential = DPAPI file data/jobboss/jobboss.cred.xml (git-ignored). 268 tables (all readable, 148 with data) + 52 views. Biggest: Quote_Req 214k, Quote 181k, InvoiceLine$ 148k, Job 73k, SO_Detail 49k, Packlist_Detail 46k. Existing JBExt_QBRawInvoiceLines / JBExt_QBImportItemMaster tables = QB data already inside JobBOSS (look at these). Step 1 (map + 4 questions) awaiting Ashe's "go".

**2026-11-12: JobBOSS loaded + "QB vs JobBOSS" page LIVE** (commit 8c3475f, pushed, Vercel Ready). Admin gear → QB vs JobBOSS (/admin/qb-vs-jobboss).
- Export: `pwsh -File scripts/jobboss-export/Export-JobBossData.ps1` → data/raw/jobboss/<stamp>/ (customers, sales_orders, shipments [SOShip pack list lines]). Import: `npm run import:jobboss -- --dir ...`. Migration 0029 (jb_customer, jb_sales_order, jb_shipment_line). Loaded locally AND into Neon (Neon backup first: data/backups/20261112-150125).
- Findings: JB customer QB_ID = QB ListID (595/1,043 have one; 428 linked to SmartCare orgs). Packlist_Header.Invoice = QB invoice # → 98% of JB invoices found in QB, 80% same amount ±1%. Jul 2024–Mar 2025: JB shipped $48.7M vs QB invoiced $68.3M (71%); 1,667 QB-only invoices ($32M: likely deposits/progress billing/freight). Pack lists start 2024-03-31, full use ~Jun/Jul 2024. Gap after QB copy (Apr 17 2025 → today): $140.7M shipped, 537 customers. 143 customers bought in last 12 mo but not linked (top: Burning Red Automotive $3.1M). Customer.Type: Direct/Distributor(57)/Reseller/House Account (Tommy Car Wash Systems = House Account, $37M since Apr 2025). Webstore orders DO reach JB ("WEB ORDER" in Customer_PO, ~6% of SOs). NO serial numbers in JB (Material.IsSerialized all false, no job user values). JB's own QB copy tables (JBExt_QBRawInvoiceLines) are incomplete (2022–23 nearly empty), ends Jun 2025: don't use.
- Local quirks: port 3000 is another app; SmartCare local uses 3100. `next dev` can crash on low memory (0xc0000142); use `npm run build` + `DB_POOL_MAX=1 next start -p 3100`. Local claudetest password was reset (local DB only).
- Next ideas (not approved yet): link the 143 unlinked customers (create/match companies), use JB shipments to refresh ideas/"last bought" after Apr 2025, nightly JB sync at go-live.
- 2026-11-12 (later): Ashe's same-period rule applied (commit 51cb4b4, pushed). import:jobboss now caps at the last QB invoice (2025-04-17) automatically; `--live` lifts it (go-live only). Local + Neon re-imported: 840 customers, 6,818 orders, 16,021 shipped lines; held back 203 customers / 12,431 orders / 30,343 lines. With the cut-off only 46 customers are unlinked (all small, top $6K): the big unlinked ones were customers new after Apr 2025.
- 2026-11-12: PAUSED for Ashe's meeting (likely the boss demo). Next decision after the meeting: (a) link the 46 small unlinked JobBOSS customers, (b) use JB data to refresh "last bought"/Ideas within the Apr 2025 cut-off, or (c) other. Still open: Ashe to sign in once to test login; deactivate claudetest@smartcare.local online; Vercel spend limit; Vercel Analytics.
