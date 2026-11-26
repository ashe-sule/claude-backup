---
name: production-board-gabi
description: "AVW digital production board app for Gabi (production scheduling) — her pain points with Trello/paper, scoping stage, no code"
metadata:
  node_type: memory
  type: project
  originSessionId: 710f5a8e-d7e8-4a9a-a271-43e3306b41c9
  modified: 2026-11-26T20:50:19.901Z
---

AVW track. Digital production board for Gabi (production scheduling). Scoping only as of 2026-11-26, no folder/code yet.

Gabi's pain points (her email, pasted 2026-11-26):
- Paper document control: all files are printed and posted on the physical production board. Any change means hunting down paperwork so everyone has the latest copy. She expects the digital board to fix this.
- Daily "Released Production Report" (from JobBOSS): lists items paid partly or in full that can be released. She uses it to sort each item: production board, Fulfillment (packs from stock), or Purchasing (dropship).
- Slowest step: creating the production job in JobBOSS, then printing it, posting it on the board AND entering it in Trello (double entry).
- Payment status colour code: white = 50% down, green = paid in full.
- She builds a list of everything shipping in the next 3 weeks by hand and emails it weekly. She wants this automated from the board/Trello.

Report sample received 2026-11-26: Downloads\QUERYSales1101902026120000AM00.xlsx (contains customer PII, keep local).
- One row per Sales Order (204 rows, 102 cols), all Status=Open and IsSORelProd=True. No line items or part numbers.
- Colour logic found: a conditional format highlights the whole row when IsSORelShip=TRUE. So green = released to ship (paid in full), white = released for production only (50% down). 189 rows green, 15 white.
- ProdCardPrn and PickPrn are False on every row, so it works as a "not yet printed" to-do queue.
- Useful fields: SalesOrder, Customer, PromisedDate, ProdDueDate, DaysDiff (negative = late), ShipVia (Best Way/UPS/CPU/FOB/AVW Delivered), Terms, rep, NoteText, attachment flags (Quote/SignOff/CusPO etc.).
- Gaps: no line items, so we can't tell Production vs Stock vs Dropship from this file alone. Need SO line detail from JobBOSS. Likely built on a custom SQL view, so find it in the JobBOSS DB.

Possible lever: read-only JobBOSS SQL access works (see [[pc-move-secrets]]), so the board could pull the released report straight from JobBOSS. Writing into JobBOSS (creating jobs) is not possible with read-only access.

Decisions (Ashe, 2026-11-26):
- Login = our own username + password accounts (NOT M365 SSO).
- Trello is NOT retired. Run side by side; retire only once the app proves itself.
- Hosting = Vercel for now (2026-11-26).
- JobBOSS login = existing Ashe_SQL_RO for now. MUST swap to a dedicated read-only service login before launch (pre-launch blocker).
- Shop TV = yes, a touch screen coming later. Parked; build touch-friendly.
- D3 DECIDED 2026-11-26: NO L:\Designs fallback. Only L:\Drawings is used. Engineering is the sole decision maker on drawings (a drawing shows only once they put it in L:\Drawings). Day-one drawing coverage is therefore 46% (156/340 make parts).

Drawings discovery 2026-11-26 (read-only, Ashe_SQL_RO, metadata only; scripts at scratchpad drawings.cjs/drawings2.cjs):
- Drawings are PDFs on mapped drives: L:\Drawings (e.g. "01 Top Level PDFs\<part>_RevA.pdf"), L:\Designs ("...[DWG].pdf"). JobBOSS attachment roots are T:\Job Boss, O:\Job Boss Supporting Docs-*. All four drives are reachable from Ashe's PC.
- Attachment table: Owner_Type QuoteOperation 10.6k (7.1k drawing-like), JobOperation 2.1k (1.4k drawing-like), Material 3.7k (mostly jpg/png part photos), SOHeader 91k (quotes, sign-offs, customer POs).
- Coverage is thin: only 73 of 728 parts on open SOs have Material.Drawing + Rev filled. Recent 90 days: 2,485 jobs, 201 with a Job.Drawing number, only 33 with drawing attachments.
- SO_Detail.Job is empty on open SOs. The Job↔SO link probably goes through the Delivery table (Job, SO_Detail columns). To verify.
- L:\Drawings listed 2026-11-26 (names only, Ashe approved and said NO changes): 8,921 files (5.4k dwg, 3.3k pdf). Folders: 01 Top Level / 02 Assembly / 03 Weldments / 04 Fabricated / 05 Purchased PDFs, 06 Manuals, 07 BOMs Flat, 08 Tabulated, plus OldVersions/Archive/Checking (exclude those). Naming is `<PART>_Rev<X>.pdf` and gives 3,064 distinct parts.
- Match against open SO lines (553 distinct parts): 165 have a current PDF. By SO_Detail.Make_Buy: MAKE 156/340 (46%), BUY 9/212 (buy parts don't need drawings). Zero parts had two current revs. Only 4 revs differ from Material.Rev.
- SO_Detail.Make_Buy (M/B) is a strong triage signal (Production vs buy/stock). SO_Detail.Drop_Ship is a BIT (an earlier note calling it unusable was a test bug: '0' counted as filled), so USE it for Dropship triage. Material has Make_Buy, Pick_Buy_Indicator and Stock_Item, to explore.
- L:\Designs listed 2026-11-26: 147,207 files (Inventor working folder: ipt/iam/dwg/dxf/cnc). 4,774 PDFs, loosely named, organised under Product Lines\... A prefix match found 66 more MAKE parts with a non-manual PDF.
- TOTAL: MAKE parts on open SOs with a drawing = 222/340 (65%). The remaining ~118 are mostly raw-stock cut pieces (`*_RS`, e.g. ANG..., BARR...) and size/length variants (e.g. BCD3-1010-090, AA5DA-1). Those may map to a base-family drawing; ask Engineering.
- Recommendation: treat L:\Drawings as the official "released" source and L:\Designs as a fallback only (it's a WIP area and could hold unreleased drawings). Confirm with Engineering. Scripts: scratchpad match.cjs.

BUILD STATUS 2026-11-26 — Step 1 DONE, local only (commit 48f1182, branch main, local git, no remote, NOT deployed):
- Stack: Next.js 16 + Neon (prod) / PGlite `pglite:./.data/db` (local), own logins copied from avw-invoice-generator pattern (bcrypt+jose, lockout, roles admin/scheduler/supervisor/viewer). connector/ = Node + mssql, pushes full snapshot to /api/ingest (Bearer CONNECTOR_TOKEN) every 5 min.
- Gabi's report = JobBOSS view vw_SOLnRelPOActionStatus (SOHdrStatus='Open' AND IsSORelProd=1; green = IsSORelShip). Verified: 182 released (164 green/18 white). All 111 still-open SOs from her export match.
- Tests: 9 unit (triage) + 3 connector (read-only guard blocks writes/SSN) + 18 end-to-end API (auth, roles, lockout, switch-off, cross-site) all PASS. Browser-checked inbox, sort, details. Phone width NOT verified (Chrome window wouldn't resize); check on a real phone after deploy.
- Findings: 0 SO lines have Drop_Ship ticked, so Purchasing is never suggested; ask Gabi how she spots dropships. 41 of 182 "released" SOs are fully shipped but still Open in JobBOSS. Real late = 58, not 86. Shown as "Shipped, not closed".
- Local run: app on port 3001 (3000 = QB Sync). Ashe's local admin login is in avw-production-board\admin-login.txt (gitignored). Local test users qa-gabi (scheduler) and qa-viewer-* (switched off) exist in the local DB only.
- Connector password: for testing I used the ICC agent .env.dev via a second --env-file. Ashe should type JOBBOSS_SQL_PASSWORD into connector\.env.local himself.
- STEPS 2–4 BUILT 2026-11-26 (commit 2cb0698, local only): /board (per lane, default columns, editable in /settings, drag + "Move to", job # per card, 📐 drawing status), /orders/[so] (drawings + files + history), /shipping (overdue + 3 weeks, copy-for-Outlook/CSV/print), files stored as base64 chunks in Postgres (connector uploads 40/cycle). Tests: unit 18 + connector 7 + e2e 18 (step 1) + 26 (steps 2-4) PASS. Sync: JobBOSS 1.1 s, files 5 s, post 0.1 s.
- Findings: there is NO JobBOSS job↔SO link (Delivery, JBExt prod-card tables empty, job prefix, cust PO and notes all 0/182), so Gabi types job # on the card; ask her how she links them. Files ≈ 414 MB (drawings 207 + order files 207), near Neon's 0.5 GB free limit, so it's a deploy decision for Ashe (Neon paid vs Vercel Blob vs fewer file types).
- Browser-verified 2026-11-26: board drag-drop, order page, drawing PDF opens (OT2-FM1HA Rev A), shipping list (113 orders: 58 overdue + 3 weeks). Fixed "Invalid Date" in history (now ISO + APP_TIMEZONE). `next build` passes. Test sorts were undone, so the local DB starts clean (test users qa-* remain local).
- 2026-11-26 walkthrough with Ashe (on-screen captions, step by step, he says "continue"). He asked for the shipping page as 4 side-by-side columns (Overdue/This week/Next week/In 2 weeks); built with a List toggle (commit 0b920ef). Ashe asked to NOTE CONCERNS TO EMAIL GABI: list kept in avw-production-board\NOTES-FOR-GABI.md (41 shipped-not-closed, 58 late, no dropship flag, no job↔SO link, 46% drawings, which papers are posted?, Trello columns, users, email recipients, Engineering questions). Draft the email from that file when asked. The file also has a "Placeholders we chose" table (P1–P12: column names for all 3 boards, suggestion rule, paid = released-to-ship, late/due-soon, shipped-not-closed, Mon–Sun weeks, roles, job # box, which files, 5-min refresh). Per Ashe, the email must explain why each was assumed and what it does ([[no-made-up-business-rules]]).
- 2026-11-26 end of walkthrough: demo data reset (column back to "Job created", demo sorts and job # undone). Walkthrough GIF saved at Downloads\AVW-Production-Board-walkthrough.gif (7.6 MB, 50-frame cap, so it may not include the last steps). v2 GIF (Ashe asked: faster, Scribe-style caption on every frame): Downloads\AVW-Production-Board-walkthrough-v2.gif, 14 numbered steps in 28 frames, 5.2 MB. This is the one to share. Demo data reset afterwards. EMAIL DRAFT for Gabi at avw-production-board\EMAIL-DRAFT-GABI.md (commit 22687d9), NOT sent; waiting for Ashe's review. Ashe sends it himself.
- STILL NEEDS ASHE: deploy (Vercel project + Neon + storage choice), weekly email sender mailbox + recipients, dedicated JobBOSS login before launch, always-on PC for the connector.
- ACCEPTANCE TEST 2026-11-26 (Ashe asked "does it work per Gabi's request"): compared the app's data with Gabi's 19 Nov export for the 111 SOs in both. Customer, prod due, ship via, terms and PO match 111/111. 18 promised dates and 3 white→green differ, and all 21 were confirmed as real JobBOSS edits after 19 Nov (so the app is more current). Browser as scheduler: 50% filter = 18, part search, sort → counts update → undo, and a sort survives a resync. Verdict given: Step 1 meets her released-list + payment-colour + triage needs; NOT yet done = doc control/drawings (Step 3), Trello-style board (Step 2), 3-week ship email (Step 4); JobBOSS job creation stays manual.
- NEXT: Ashe reviews locally → deploy (needs Ashe: Vercel project + Neon DB) → Step 2 board/columns (needs Gabi's Trello columns) → Step 3 drawings (L:\Drawings only) → Step 4 weekly ship email.

Earlier status 2026-11-26: Ashe said "let's start". Phase 1 scope drafted at projects\avw-production-board\SCOPE.md (DRAFT, not yet reviewed). My coverage rating given to Ashe: ~80% of Gabi's pain in Phase 1 (JobBOSS job creation stays manual). NEXT: Ashe reviews the scope, then Gabi + Engineering answer the open questions and Ashe makes decisions D1–D4. No code yet. Not a git repo yet.

**Why:** Replace Trello and the paper board, and cut Gabi's daily double entry.
**How to apply:** No build until Ashe approves scope. Open questions were sent to Ashe 2026-11-26 (attachment, card contents, columns, who views it, ship-list recipients, whether Trello is retired).
