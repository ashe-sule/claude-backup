---
name: pnr-import-kiosk
description: "Separate project \"PNR Import Kiosk\" (C:\\Users\\ashe\\Documents\\projects\\pnr-import-kiosk) — Excel → HubSpot NPR/CEP ticket importer, split out of qb-sync on 2026-11-02"
metadata:
  node_type: memory
  type: project
  originSessionId: 67983cea-1118-4c28-858a-ea5575560fff
  modified: 2026-11-02T21:14:52.302Z
---

Ashe asked (2026-11-02) for the Excel→HubSpot PNR importer to live in its own project named **PNR Import Kiosk** (folder `C:\Users\ashe\Documents\projects\pnr-import-kiosk`), hosted on Vercel so it works with Ashe's PC off. Ashe explicitly said **no Microsoft 365 login**; it uses a shared access code (`KIOSK_ACCESS_CODE`) instead.

Logic was first proven in qb-sync `scripts/import-excel.mjs` (`--type=npr|cep`). Both imports put tickets at ECN stage "Accounting Approved - Pending Input into JB/QB". CEP sets approver = Scott Grajeda (resolved by name, sandbox owner 78157877). Ticket names are `NPR|CEP - EXCEL - <PART> - <YYYYMMDD><NN>`.

**Why:** managers will eventually use it themselves; it's unrelated to QuickBooks sync.
**How to apply:** do new importer work in the kiosk repo, not qb-sync. Production still requires Ashe to set a prod token and say "point at prod" (see [[hubspot-prod-rule]]).
