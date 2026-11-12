---
name: avw-environment-facts
description: "Confirmed AVW system versions & hosting decisions (QuickBooks, JobBOSS, Azure) given by the user"
metadata:
  node_type: memory
  type: project
  originSessionId: 388de537-7e8f-4684-b80a-c84facf27166
  modified: 2026-11-12T20:44:29.180Z
---

Confirmed by user 2026-11-12:
- QuickBooks Desktop version **24** (2024). Exact edition (Enterprise vs Pro/Premier) still to confirm — non-Enterprise 2024 support ends ~2027.
- JobBOSS **18.0** (classic JobBOSS line, SQL Server). Read-only DB access was verified on 2026-11-12 in the SmartCare project.
- Hosting: **Azure is approved** for ICC.
- Related projects with reusable work: "qbsync" (QuickBooks sync, has a test environment) and "SmartCare" (has JobBOSS read-only DB access).

- Test data (2026-11-12): user builds/tests in SANDBOXES. QuickBooks sandbox data ENDS ~Apr 2025 (file dated 2025-04-17); JobBOSS data is current to date. So ICC must age/score quotes against the "QB data through" date, not today, and show the coverage gap. JobBOSS server V-JOBBOSS, database `live`, read-only login Ashe_SQL_RO (personal; prod should use a dedicated service login), self-signed cert (TrustServerCertificate), READ UNCOMMITTED + LOCK_TIMEOUT 5000.
- Proven JobBOSS 18 columns (SmartCare export): Customer(Customer, Name, Status, Type, QB_ID, Customer_Since); SO_Header(Sales_Order, Customer, Order_Date, Status[Open/Closed/Hold], Customer_PO, Total_Price); SO_Detail(SO_Detail, Sales_Order, Material); Packlist_Header(Packlist, Packlist_Date, Invoice=QB invoice #, Customer_Vendor, Type='SOShip'); Packlist_Detail(Packlist_DetailKey, Packlist, SO_Detail, Quantity, Unit_Price). Keys space-padded → RTRIM. NOT proven: Promised_Date, notes, Last_Updated, attachments.
- QB ↔ JobBOSS link facts: Customer.QB_ID = QB customer ListID; QB invoice Memo "E nnnnn, Q nnnn" (estimate #, Quoting Tool #) since 2023; QB invoice custom field "Job/Packing Slip No." = "PL####" since Apr 2024; before 2024/25 orders were QB SalesOrders linked to estimates. QB jobs (sub-customers) ≈ wash sites. QBWC works with http://localhost; qbXML 13.0 works (qb-sync).

Verified on V-JOBBOSS/live 2026-11-12 (read-only discovery, user-approved, via SmartCare DPAPI cred file):
- SQL Server 2019 (15.0). Ashe_SQL_RO: SELECT on all 268 tables, 0 insert/update/delete.
- Last_Updated (datetime, no nulls) on SO_Header, SO_Detail, Customer, Packlist_Header, Packlist_Detail → incremental sync, NO daily sweep (user questioned the sweep; removed).
- SO data effectively starts Apr 2024 (1 order from 2020): 2024 4,329 orders, 2025 7,713, 2026 7,204. SO_Header 19,261; SO_Detail 48,983; Packlist_Header 20,822.
- SO_Header.Note_Text/Comment: "QBQ#nnnnn" on ~2,907 orders (5-digit 14372–75204; assumed = QB estimate #, NOT yet confirmed by user); "Quote: nnnn" on ~2,259 (4–5 digit 1111–43997; ambiguous — maybe Quoting Tool #). 286 orders have both.
- Attachment: Owner_Type 'SOHeader' 90,396 files (~20k names mention QB, ~13k "quote").
- SO_Detail.Quote = JobBOSS internal GUID quote ids (Quote table 181k rows) — not QB numbers.
- Customers 1,045; only 596 have QB_ID → ~449 need manual/name-suggested mapping. Pack lists changed in last 7 days: 186, 175 with QB invoice #.
- SO_Header.Sales_Rep filled on only ~17% of orders. JBExt_SO_Header.QuoteToSODateTime never used.

Confirmed by user 2026-11-12:
- "QBQ#nnnnn" in JobBOSS SO notes = the QuickBooks quote/estimate number. Strong evidence.
- "Quote: nnnn" in JobBOSS SO notes = the number of a JobBOSS QUOTE that staff RETYPED from the QuickBooks quote, so they can use a consultant-built "Quote to Sales Order" app that converts the JobBOSS quote into a sales order. It is NOT a QB estimate # and NOT the Quoting Tool # → never match it against QB estimate numbers.
- User asked whether ICC team could build a Quote→SO app (replace retyping). Idea logged; needs write access (separate approval), supported JobBOSS write method, JobBOSS test DB.

Decisions by user (2026-11-12, later):
- **Use the existing `Ashe_SQL_RO` JobBOSS login for ICC — do NOT create a new account.** (Risk already explained once; don't re-push it. Rotation is covered by [[todo-rotate-passwords]].)
- **No Azure for now** — run locally / on-prem. Azure doc (07) is parked.
- **No Microsoft Entra SSO for now** — user wants a simple login (local username + random generated password).

Related: [[project-status]]
