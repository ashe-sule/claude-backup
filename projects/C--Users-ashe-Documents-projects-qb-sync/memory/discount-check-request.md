---
name: discount-check-request
description: "New request 2026-11-24 (Goran + accounting): app that checks invoice discount lines vs customer discount list and lists exceptions in Excel"
metadata:
  node_type: memory
  type: project
  originSessionId: 7329e78e-7a98-47ed-9f88-2bc1339e8947
  modified: 2026-11-27T16:15:36.906Z
---

Request received 2026-11-24 (pasted meeting notes to Ashe + Goran). Source workbook: `Downloads/2026 11 November Invoice Review Template - Sales Data 11 15 2026.xlsx`. **Not started; nothing built. Only analysed.**

**Phase 1 (the ask):** pick a date range → read all posted QB invoices → per invoice, sum the discount lines (items `Discount-Equipment Sales:ES..` / `Discount-Parts Sales:PS..`) → compare with the expected discount from the customer discount list → Excel exception list of mismatches. Filter invoices > $0.01.
**Later phases:** map ES discounts to equipment lines, PS to parts; then auto-generate the discount on invoices and check it against the Sales Order before posting.

**Today's manual process (in the workbook):** P&L Standard report → drill into net income → filter Invoice → export → split customer code from name → per line: expected % = INDEX(Customer Discount List[customer], column = line's Item Discount Category) × Amount → pivot by invoice → Calced vs Invoiced → "For Gwen to Review - Exceptions" sheet (Rep + Notes).
- Customer Discount List columns: EQUIP - M, EQUIP - B, PARTS - M, PARTS - B, NET, MD NET, BELT (+ Customer Type). ~988 customers. BELT is capped at 10%.
- Non-discountable lines are excluded: discount items, Labor-House, HNDST, 00SH, ACC-SH, Accommodations, MIR, RGA, 0CONV.
- Typical exceptions: discount missing, wrong % (40% on Equip-B), BELT over-discounted, a customer's % changed mid-period (DRE02, RMJ02, QCP01), one-off codes (DISTMTG2026, PSH25-RV20, PSD10-SS10).

**Fit with qb-sync:** "Item Discount Category" is a QB item custom field the SDK CAN read (seen in the 2026-11-23 probe). InvoiceQuery with lines is read-only. Customer Type is already used for quote discounts ([[qb-discount-items]]). The QB Lists pull ([[project-status]]) can provide items/customers.

**2026-11-24 Ashe answers (via a big "master prompt" for module "AVW Invoice Discount Audit"):** Customer Type in QB = master; use CURRENT % (snapshot it per audit); tolerance configurable; users = accounting (Gwen) + Ashe admin, reps no access; ICA first then LIVE read-only with OK; flag all promo codes; only 5 categories (EQUIP-M/B, PARTS-M/B, BELT), NET + MD NET excluded. Design only, no build until approved.
**Findings when reviewing it (workbook evidence):**
- Customer Type formats: `Direct - 25%`, `30%EQ_20%PTS`, `0%EQ_10%PTS`, `40%EQ_30%PTS_30%PURCH` (CRE01: EQ-M 40, EQ-B 30, parts 30), `Mfg-35%,Purch-30%` = M vs B on BOTH equip and parts (AVW02, KAA01, TOM01). Existing `src/lib/quote/discounts.ts` only parses Mfg-/Purch- and maps Mfg→ES, Purch→PS — possibly wrong vs the workbook; ask Ashe.
- BELT = 10% for all 155 discounted customers (min(base,10%)), no exceptions → rule, not per-customer; confirm.
- Customer Type disagrees with the list for AQU03, DRE02, QCP01 (type says 0%, list 20–30%) → QB types may be stale; fix before relying on them.
- 25 customers are plain "Direct Merchant Account" (no %) → unknown, not 0.
- qb-sync has NO user login/roles yet (no auth/proxy in src). App can't pick ICA vs LIVE: QBWC uses whatever file is open; detect + label it.

**Ashe decisions 2026-11-24 (after review):** use INVOICE NUMBERS (not TxnID) everywhere; NO logins/roles; ICA file only (Ashe uploads/refreshes it manually), no LIVE; few-minute run is fine; Phase 1 only; local only, no Vercel. Review statuses/notes/audit history were from Ashe's own master prompt (sections 15/17), not from Goran — treat as optional, not in scope unless Ashe asks.

**Ashe answers 2026-11-24 (round 2):** (1) Customer Type from QB as-is; flag unknown/no-% types. (2) BELT = 10%, capped at the customer's base %. (3) Paid/cash basis: don't filter, just INDICATE paid/unpaid/pending/void per invoice. (4) Decode Customer Type like the workbook: Mfg-X%,Purch-Y% = M vs B on both equip and parts (so quote decoder Mfg→ES/Purch→PS is suspect; fixing the quote tool is separate and needs OK).
Next: Phase 1 design sent for approval (one Neon table proposed, or a disk file).

**2026-11-24 BUILT (Ashe said "go"; NOT committed, NOT tested against QB yet):**
- `src/lib/audit/discount-rules.ts` (pure decoder + math, cents×basis points, outcomes Matched/Mismatch/Review/Incomplete), `src/lib/audit/audit.ts` (QBWC steps: InvoiceQuery w/ lines → CustomerQuery (CustomerTypeRef) → the 11 item queries from lists.ts; runs after queue + list pulls are idle), `src/lib/audit/audit-export.ts` (6 sheets, exceptions first in Goran's columns), `/discount-audit` page + actions, `/api/discount-audit/[id]` (Excel; refused on Vercel), nav link, hook in `api/qbwc/route.ts`. tsc + eslint clean.
- `db/discount-audit.sql` (table qb_discount_audit) written but **NOT created in Neon** — waiting for Ashe's explicit OK.
- Decoder vs Goran's list: 936/942 match; 6 differ = QB type ≠ list (AQU03, DRE02, KLE04, QCP01, RMJ01, THO04); 46 types have no %.
- Dry run on Goran's Nov 1–15 data (352 invoices): his per-invoice calc reproduced except those customers; 12 mismatches (DRE02/THO04/KLE04 = type issue; ELT01 DISTMTG2026; FIN01, HOL01, WVC01, KOP01, FIE01), 2 incomplete (SWI02 no %).
- Next: OK to create table → refresh ICA with Nov data → run on ICA → compare with workbook → commit.

**2026-11-24 end of session:** ICA is an OLD file (no Nov invoices); only LIVE is current. Proposed Option A: back up live (.QBB) → restore under a NEW name (e.g. AVW-COPY-2026-11.QBW) → grant qb-sync access on the copy (Admin, single-user) → run the audit there. Plus a company-file lock env (like QB_LIST_COMPANY_FILE) so the audit refuses any other file. Option B (LIVE read-only) deferred. **Ashe: "tomorrow we get a fresh copy of live."** Still NOT given: explicit OK to create table qb_discount_audit (ask again). Code still uncommitted.

**2026-11-25 FIRST REAL RUN ✅** on the Test copy of LIVE: matches Goran 350/351 for Nov 1–15 (HOL01 differs: QB type 25% vs his list 20%). Pending (non-posting) invoices explain the count gap, since his P&L omits them. Excel + email to Goran saved in Downloads. Open: Pending in or out (suggested a Posting Status column), "Direct Merchant Account" = 0%?, HOL01 confirm, commit OK. Details in [[project-status]].

**Open questions for Ashe (older, mostly answered):** does the Customer Discount List come from QB or a separate spreadsheet (and what's the master); what "posted" means in QB Desktop; how to handle discount % changes by date; tolerance (rounding < $0.01); who runs it (Gwen?); ICA or live file.
