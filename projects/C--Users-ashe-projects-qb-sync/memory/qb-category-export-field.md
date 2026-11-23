---
name: qb-category-export-field
description: "QB item custom field \"Category(For Exports Only)\" holds the item Category, because the QB SDK can't read QB's real Item Category"
metadata:
  node_type: memory
  type: project
  originSessionId: fc1e5220-cb63-4dc6-bd60-ea3f84608aae
  modified: 2026-11-23T21:09:55.309Z
---

Decided 2026-11-23 (Ashe): QB item custom field named exactly **`Category(For Exports Only)`** (26 chars, QB limit 31) holds a copy of each item's Category.

- QB's own Item Category (LABOR, BLTCNVYRS, Uncategorized, about 95 values) can't be read or written through the qbXML SDK. A probe on Enterprise 24.0 at qbXML 13/16/17/18, plus a report query, came back with no Category.
- **Exports:** the QB Lists pull (src/lib/qb/list-export.ts) must put `custom:Category(For Exports Only)` into the "Category" column of Items.xlsx.
- **Imports/creates:** every part qb-sync creates or edits should set the field with DataExtMod (OwnerID 0, ListDataExtType Item). That covers NPR from HubSpot `part_number_category`, the /items/new form, quote-tool missing parts and Excel imports. On CEP, update it only if the category changes.
- **Backfill:** one time, from Ashe's last manual Items.xlsx (Sheet1, "Category" column). ICA first, then live after hours with Ashe's OK.
- **Staff burden: none.** Ashe (2026-11-23) does not want staff updating the extra field. Proposed: an occasional (e.g. monthly) manual Items export, dropped in a folder (e.g. QB Lists/Category Sync); qb-sync compares it and DataExtMods only the changed parts. NPR creates fill it automatically. Awaiting Ashe OK to build; first Ashe adds the field in ICA.
- Drift risk: someone may change the real Category in QB and not this copy. Remedy: an occasional manual export plus a re-copy.

**Why:** avwforms needs Category, and this is the only way to automate the Items export.
**How to apply:** use this exact field name everywhere. Related: [[project-status]], [[cep-requirements]].
