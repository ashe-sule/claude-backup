---
name: publish-means-update-share
description: "When Ashe says \"publish\" in so-label-printer, it means pushing the signed update to the v-server share"
metadata:
  node_type: memory
  type: feedback
  originSessionId: b5e87d80-079a-4d45-96d4-43fda9588b08
  modified: 2026-10-23T17:25:14.832Z
---

"publish" = ship the current version to `\\v-server\Temp\AVW SO Label Generator` via `scripts/publish-update.mjs` (or `npm run release`), so every PC gets the Update prompt. Not a GitHub release.

**Why:** Ashe's flow is commit + tag + push, build, then "ok publish". On 2026-10-23 v1.3.2 went out this way.

**How to apply:**
- First read `latest.json` on the share to see what's live.
- If `release/AVW-SO-Label-Printer-Setup-<version>.exe` is newer than the last commit and git is clean, skip the rebuild and run `node scripts/publish-update.mjs --notes "..."`.
- Write the notes in plain language for end users.
- Afterwards, compare the sha256 of the local installer with the copy on the share.
- Offer a GitHub release as an optional extra; don't do it unless asked.
