---
name: cep-requirements
description: "What Ashe wants the CEP (change existing part) QB update flow to support — multi-field edits regardless of the ticket's single reason"
metadata:
  node_type: memory
  type: project
  originSessionId: cf4f708c-908e-426d-abd6-1e3d8117f34e
  modified: 2026-11-10T22:08:01.231Z
---

Ashe's CEP requirements (2026-11-10), building on the working NPR flow:
- Edit **description**, **cost**, **price**, **G/L accounts** (income/expense, i.e. the P&L accounts) on an existing QB item.
- Change **active ↔ inactive** both ways.
- Cover the **other CEP reasons** too. Full list (read from avwforms `PartNumberForm.tsx`, unchanged since 2026-08-27): **Sell Price, Cost, Active, Inactive, Description, Update GL Account Mapping**. Which appear depends on Make/Buy × For Sale: Make+Sale = all 6; Make+NotSale = Active, Inactive, Description, GL; Buy+Sale = all 6; Buy+NotSale = Cost, Active, Inactive, Description, GL. GL Mapping collects current + updated sell-side and buy-side accounts (→ `updated_sellside_account` / `updated_buyside_account`). 2026-11-10: added option "Update GL Account Mapping" to the SANDBOX `reason_for_change` property (Ashe asked; PATCH 200, existing 8 options kept). Sandbox already has sellside/buyside + updated_* account text fields. Prod not touched (rule).
- **Several changes at once**, even when the HubSpot ticket was raised for only one reason (don't limit edits to the stated reason).

**Why:** CEP tickets often carry more than one real change; staff shouldn't need one ticket per field.
**How to apply:** the diff should show and send every field that differs, not only the field matching `reason_for_change`, and the approval screen should allow edits. AVW items are a mix of one-account (SalesOrPurchase) and two-account (SalesAndPurchase) setups, so the Mod must keep each item's setup ([[project-status]]). Accounts can only be changed within the item's setup (one-account items have a single AccountRef). Not yet planned or built as of 2026-11-10; the discount lookup ([[qb-discount-items]]) comes first.
