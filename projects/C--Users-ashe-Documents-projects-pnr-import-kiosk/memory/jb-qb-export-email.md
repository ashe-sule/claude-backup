---
name: jb-qb-export-email
description: JB + QB Excel export of approved NPR tickets — live as a kiosk download button; email plan dropped 2026-11-10
metadata:
  node_type: memory
  type: project
  originSessionId: 45f44710-a21b-4981-9c35-5aa8a3a6f71f
  modified: 2026-11-09T22:56:12.977Z
---

Ashe wants the kiosk to email a filled Excel (JobBoss "JB Import Utility" + QB "QB Mass Upload Template" sheets) built from HubSpot PNR tickets. Spec source: `C:\Users\ashe\Downloads\Hubspot PNR Report Build.xlsx` (row 4 = HubSpot field per column, defaults like Type=F, Location=SHOP, Qty=500, Make->P / Buy->B, JB Description = first 30 chars, GL = 4-digit of Updated Buy-Side Account).

Decisions (2026-11-09):
- Tickets: only ones that entered "Accounting Approved - Pending Input into JB/QB" since the last send
- Schedule: Mon + Thu, 7 AM Central
- Sender: Microsoft 365 (Azure app + Graph Mail.Send, shared mailbox)
- Format: 1 email with both files to all recipients

Sandbox (2026-11-09, with Ashe's OK): created ticket props `purchase_uofm`, `stock_uofm`, `cost_uofm`, `price_uofm` (select ea/box/ft/gal/in/lbs/sqft), `purchase_description` (textarea), `item_discount_category` (select EQUIP - M/EQUIP - B/PARTS - M/PARTS - B/BELT). Filled fake TEST data on empty fields of the 10 tickets in stage 1334756481. Class = `part_number_category`; Vendor = `vendor_suppplier` (text). Also in sandbox: added 10 new TEST tickets (TEST-PART-011..020), so 20 tickets sit in the stage. Converted `part_number_category` from text to a dropdown with the 101 codes from the Excel. The 14 invalid values (EQUIPMENT, hof, OTHER CHARGES, Uncategorized, etc.) were set to UNCATEGORI; backup is in that session's scratchpad `category_backup.json`. Prod is still text and the field is a formField, so check avwforms/forms before converting prod.

Prod read-only test (2026-11-09) used a key in git-ignored `.env.prod-readonly` (HUBSPOT_ENV=production). Results: Vendor = `vendor_suppplier` text (171 tickets; dropdown never used), so that question is settled. `item_discount_category` already exists in prod as free text with messy spellings. Missing in prod: 4 UofM + purchase_description. Buy-side accounts are QB sub-account paths, so GL = the LAST 4-digit number. Lead time is free text ("7 Days", "3-5 DAYS"). All 16 tickets in the prod stage are CEP.
2026-11-10: with Ashe's OK, created the 5 missing prod fields (4 UofM dropdowns + purchase_description textarea) in group ticketinformation. Ashe adds them to the record card by hand (no API for that).
2026-11-10: Ashe confirmed export is NPR ONLY (type_of_request contains "New Part Request"); CEP and blank-type tickets are excluded entirely (isNpr filter in buildExport). Prod stage currently has 16 CEP, 0 NPR.

**Why:** replaces manual re-keying of approved parts into JobBoss and QuickBooks.
**How to apply:** UofM/Class/Purchase Description/Discount Category fields are missing in sandbox. Ashe says they exist in HubSpot, so verify the prod internal names before mapping. Get Ashe's approval before building. Related: [[pnr-import-kiosk]]

2026-11-10: kiosk download button built (local, NOT deployed): `src/app/api/jbqb-export/route.ts` (GET, auth cookie, optional ?since=YYYY-MM-DD = midnight Central) + `src/app/export-card.tsx` on the signed-in page. Read-only. Sandbox-tested (8 NPR rows, audit 0 issues). Email/cron still not started.

2026-11-10: Button is LIVE (commit a8bcb42). Ashe DROPPED the Mon/Thu email: the on-demand kiosk download replaces it. Ashe built the HubSpot workflow that defaults the 4 UofM fields to ea. CLAUDE.md still says the email is "Not yet built" — fix that line on the next push.
