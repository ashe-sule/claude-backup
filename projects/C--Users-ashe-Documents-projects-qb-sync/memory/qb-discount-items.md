---
name: qb-discount-items
description: "AVW QuickBooks discount items (Discount-Equipment Sales:ES##, Discount-Parts Sales:PS##, reversed-percent codes), subtotal 00SBT, customer discount lives in Customer Type"
metadata:
  node_type: memory
  type: project
  originSessionId: cf4f708c-908e-426d-abd6-1e3d8117f34e
  modified: 2026-11-10T21:44:39.847Z
---

AVW QB discounts (explained by Ashe, verified in the ICA QB file 2026-11-10):
- **ES** = Equipment Sales discount, **PS** = Part Sales discount. Code = percent digits **reversed** (zero-padded, decimal kept): 10%→ES01, 25%→ES52, 3%→ES30, 12.5%→ES521, 2.5%→ES520.
- **Real QB names are sub-items**: `Discount-Equipment Sales:ES01` … and `Discount-Parts Sales:PS52` … (plain "ES52" is NOT found). Equipment ones post to `Equipment Revenue, Net:Equipment Revenue, Discounts:Equipment Sales Discounts` (4021); parts ones to `Parts Revenue, Net:Parts Revenue, Discounts:Parts Sales Discounts` (4121).
- Existing ES: 01,02,03,04,15(51% "2024 Show Special"),30,50,51,52,520,521,53,571(set as $17.50 amount, not %, likely a setup slip). PS: 01,02,03,04,24,30,50,51,52,53 + some "-PARTS25" variants.
- **Subtotal item** = `00SBT` (ItemSubtotal).
- **Customer's assigned discount = its Customer Type**, e.g. KAA01 = `House Account:House - Mfg-40%,Purch-30%`. No QB custom fields on customers.
- Rule from Ashe: quoting-tool quotes are mostly equipment → ES item; if the quote's discount isn't one the customer is allowed → flag an error, don't send.

**Why:** needed to add the discount line to quote → QB Estimate pushes ([[project-status]]).
**How to apply:** build 00SBT + `Discount-Equipment Sales:ES<code>`; check against the customer type's % before queuing. Ashe's answers (2026-11-10): for **Kaady (KAA01) only**, Mfg-40% → ES04 and Purch-30% → ES03; this mapping does NOT apply to other customers: for everyone else follow the standard, Customer Type "Mfg-X%" → ES<code X>, "Purch-Y%" → PS<code Y>. **No mixed quotes** → one subtotal + one discount line per quote. Discount that doesn't match the customer → **drop for review** (hold, don't send).
