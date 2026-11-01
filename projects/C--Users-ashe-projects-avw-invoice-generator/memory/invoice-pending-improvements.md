---
name: invoice-pending-improvements
description: Commercial invoice improvements Ashe deferred on 2026-10-30 (not yet in ROADMAP.md)
metadata:
  node_type: memory
  type: project
  originSessionId: fc04df56-96dd-4d90-834b-dfaffff918f0
  modified: 2026-10-30T20:04:11.622Z
---

On 2026-10-30 Ashe approved and shipped the new template (full descriptions, line #, page subtotals, N/A boxes, total box). These suggestions were deferred for later:

- Rename the "Sub Totals"/"Freight" fields. Users put package count and weight in them; add a real Freight charge ($) and a Total Gross Weight field.
- Weight per line / total weight (the column is always empty).
- Skip or flag zero-shipped Pack List lines (e.g. Deltic line 001 CTA1 shipped 0 → $0 line).
- Incoterms drop-down for Terms of Sale. The importer fills payment terms like "Net 30".
- Importer sets Consignee from the Pack List Ship To, which can be "AVW Equipment/Will Call". Check this with Ashe.
- "Sold To / Buyer" box, reason for export, signature space, USMCA statement (confirm wording with customs broker).
- HS code per part. Everything defaults to 8479.89.9860 and the broker should confirm the codes.

**Why:** Ashe asked for these to be done later, after the urgent 43-line fix.

**How to apply:** Offer these when Ashe returns to invoice work, and get approval before building any of them. Related: [[vercel-deploy-setup]].
