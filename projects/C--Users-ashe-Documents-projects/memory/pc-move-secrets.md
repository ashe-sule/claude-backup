---
name: pc-move-secrets
description: "PC move 2026-11-25: signing key + private backup placed & verified; .env files were already on new PC; JobBOSS login still NOT working"
metadata:
  node_type: memory
  type: project
  originSessionId: 0c9187f0-634a-4c5c-b31e-c4993f63aa28
  modified: 2026-11-25T15:19:26.152Z
---

2026-11-25 status (old PC still available; old projects path was C:\Users\ashe\projects, new is C:\Users\ashe\Documents\projects):
- Secrets folder brought over at C:\Users\ashe\Desktop\AVW-old-pc-secrets (323 files, the complete one). Duplicate ..._2026-11-24_2031 is a subset (299 identical files), told Ashe to delete it.
- DONE: SO Label Printer signing key placed at %APPDATA%\AVW SO Label Printer Publisher\update-signing-key.pem — ed25519, derived public key MATCHES electron/update-key.ts. Label Printer updates can ship again.
- DONE: AVW-private-backup (283 files incl. Android kiosk .jks) copied to Documents\AVW-private-backup.
- All 39 project .env files were ALREADY on the new PC and byte-identical — nothing needed copying.
- FIXED 2026-11-25: Ashe typed the Ashe_SQL_RO password into ICC apps\agent\.env.dev himself; one read-only test → CONNECTED as Ashe_SQL_RO, 268 tables visible. JobBOSS read access is back. (ICC agent config still defaults user to avw_icc_reader — set jobboss.user if the agent itself must use Ashe_SQL_RO.)
- (Earlier, before the fix) JobBOSS NOT working: ICC agent .env.dev JOBBOSS_SQL_PASSWORD (config labelled mock-dev-agent) rejected for avw_icc_reader AND Ashe_SQL_RO; Windows auth AVW\ashe also rejected. No other file mentions V-JOBBOSS. Stopped trying (lockout risk). jobboss.ts says Ashe_SQL_RO had SELECT on all 268 tables (verified 2026-11-12) — that password isn't stored in any collected file; Ashe/JobBOSS admin must supply/reset it into .env.dev himself (never in chat).

**Why:** signing key needed to push Label Printer updates; JobBOSS read access needed for ICC/SmartCare.
**How to apply:** remaining: Ashe gets working read-only JobBOSS password into ICC .env.dev, wipe USB + delete Desktop secrets folder copy + old PC Downloads copy. See [[avw-thanksgiving-banner]].
