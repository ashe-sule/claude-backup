---
name: qb-sync-project
description: AVW QB Sync — Next.js 15 + Neon Postgres app on Vercel that syncs data to QuickBooks Desktop via QBWC. Working locally as of 2026-09-28.
metadata:
  node_type: memory
  type: project
  originSessionId: 2aaabe92-b11d-4b87-ad2a-aec1b3d3242f
  modified: 2026-09-28T21:49:41.957Z
---

**AVW QB Sync** — Next.js 15 web app that syncs data with QuickBooks Desktop through the QuickBooks Web Connector (QBWC).

**Why:** Ashe needs to edit/add customers, vendors, and items in QuickBooks from a web interface AND from auto-processed Excel uploads, so office staff can update QB without touching the desktop app directly.

**How to apply:** Real, in-progress project. Ashe confirmed 2026-09-28 that the local dev version (http://localhost:3000/) has all previously reported problems solved. Do NOT restart from scratch. Always check the repo/live app and ASK Ashe for current status before assuming state.

## Stack

- **Next.js 15** (App Router, TypeScript)
- **Tailwind CSS** — dashboard
- **Neon Postgres** (free tier) — sync queue + audit log. Portable: same schema/code works on Supabase, Vercel Postgres, RDS, local. Switch by changing `DATABASE_URL`.
- **QuickBooks Web Connector (SOAP)** — bridge to QB Desktop
- **postgres** npm client — connection cached, ssl auto-detected

## Key locations

- **Live app (Vercel):** https://qb-sync-one.vercel.app/
- **Local dev:** http://localhost:3000/ (Ashe reports all issues resolved here as of 2026-09-28)
- **Repo:** https://github.com/ashe-sule/qb-sync.git
- **Excel data sources (Ashe's OneDrive):**
  - `Customer.xlsx`
  - `Items.xlsx`
  - `Vendor.xlsx`
  - Path pattern: `/c/Users/ashe/OneDrive - AVW Equipment Company Inc/Documents/`

## Endpoints

- `POST /api/qbwc` — SOAP endpoint QBWC polls
- `GET  /api/qbwc/qwc` — download the `.qwc` file to register with QBWC
- `GET  /` — dashboard: queue status + session history

## Entities synced

- customer
- vendor
- item_inventory
- invoice

## Environment / secrets

- Neon Postgres account was created by Ashe during setup — connection string lives in `.env.local` as `DATABASE_URL` (and in Vercel env vars).
- **Do NOT paste live connection strings into chat or save them to memory.** If Ashe shares one to debug, treat as sensitive: suggest rotating it in Neon console if it may have been exposed.

## History (chronological)

- QBWC 1048 + 1051 (SSL cert on *.vercel.app not trusted by QBWC) — **BYPASSED, not fixed.** GTS Root R1 + WR1 intermediate cert installs didn't work. Workaround: run `npm run dev` on the QB PC and point `.qwc` at `http://localhost:3000/api/qbwc` (plain HTTP, no cert check).
- QBWC 1039 (app permissions on company file) — resolved (QB admin granted access via first-time consent dialog, single-user mode).
- HRESULT 0x80040400 XML parse errors (2026-09-22, customer/vendor/item/invoice creates) — RESOLVED per Ashe on 2026-09-28.
- **2026-09-28 evening — HubSpot ECN → QB approval flow shipped end-to-end (read-only + approve).** Sandbox connected (Hub `50557468`), private-app token stored, `/admin/pending` + `/admin/pending/[id]` pages live on localhost with diff, quality flags, verdict, Approve/Reject, and live status banner. Sandbox has 3 tickets at trigger stage. Ashe hasn't yet clicked Approve to fully verify real-QB write.
- Current state (2026-09-28 end): Local flow WORKS end-to-end. **QBWC talks to localhost, NOT Vercel.** `npm run dev` must be running on the QB PC. Prod cert issue still open — future fix options: Cloudflare Tunnel, custom domain, or run app as Windows service on QB PC.

## Where to pick up next session (2026-09-29+)

1. Test the Approve button end-to-end — recommend starting with the CEP `AIRGATE-TOMMY'S` (ticket `44117500336`) since we have a live QB snapshot for it. Watch the status banner move ⏳ → 🔄 → ✅.
2. After success: teach the approve action to flip the HubSpot ticket status back to `Part Number Approved` (currently rule-blocked; unblock when ready).
3. Deferred: edit-before-approve, reject-to-HubSpot, real audit-with-attribution, Excel-upload path, Cloudflare Tunnel, Neon password rotation.
4. QB stability: `.QBW` is on Desktop but NOT OneDrive-synced (verified). Real risk is file size (~2 GB) — Verify Data / Condense Data still worth doing.

## Related

- [[project_github_vercel]] — deploy pipeline used for this app.
