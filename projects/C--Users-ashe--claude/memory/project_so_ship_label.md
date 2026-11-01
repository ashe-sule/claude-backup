---
name: project-so-ship-label
description: AVW SO Label Printer — Windows desktop app (Electron) that looks up a JobBOSS SO and prints a 4x8 Zebra label; current v1.3.2 (2026-10-23), signed auto-updates from the v-server share
metadata:
  node_type: memory
  type: project
  originSessionId: 51eaf5cc-4339-43f0-99df-0462ee9bd962
  modified: 2026-10-23T13:47:12.279Z
---

**Current design (2026-10-22, user asked for an installable Windows app):** Electron desktop app reads JobBOSS SQL directly over the AVW LAN and sends raw ZPL to the Windows printer queue (koffi → winspool). No cloud: Neon/Vercel NOT created; the earlier web version (C:\Users\ashe\projects\so-ship-label — Next.js + sync script + office-IP lock) is parked locally, never deployed or pushed; snapshotted 2026-10-23 in a LOCAL-only git repo (no remote, no secrets).

- Code: C:\Users\ashe\projects\so-label-printer → private repo https://github.com/ashe-sule/so-label-printer, releases v1.0.0 → v1.3.1, all committed/pushed/tagged (Setup + Portable exe, unsigned → SmartScreen "Run anyway").
- SQL: V-JOBBOSS (192.168.1.4:1433), database `live`, table dbo.JBExt_Support_SOShipLabel (~294 rows, refreshed 7AM/1PM). Login `Ashe_SQL_RO` (personal; recommended a dedicated read-only login with expiration off). Its first password was pasted in chat — must be rotated.
- Settings per Windows user: %APPDATA%\AVW SO Label Printer\settings.json (password via DPAPI safeStorage); print-log.csv alongside.
- Label: centered S.O.#/P.O.#, big bold AddressName, address + country (always), AVW footer (company, 105 South 9th Ave Maywood IL 60153, (708) 343-7738, logo, tagline, website). No UPS notice, no box count (see v1.2.1).
- Shop has a network Zebra "ZDesigner ZD421-203dpi ZPL-Shop 1" (192.168.1.203) on user's PC; original target printer GK420.
- Build gotcha: multiple AVs (Webroot, Malwarebytes, OpenText, Defender) lock new .exe files → `npm run dist` preloads scripts/fs-retry.cjs; electronDist = node_modules/electron/dist. GitHub MCP token was bad; used git credential manager token for API (repo create/release).
- v1.1.0 (2026-10-22): printer discovery via EnumPrintersW (koffi, ~70 ms; Get-Printer/WMI took 8–10 s on user's PC), USB/Network/Server + status, picker on main screen saves the app's default (not Windows default), Refresh + Test print. Shop 1 ZD421 reported status "Error" by Windows that day.
- v1.2.0 (2026-10-22): self-update from \\v-server\Temp\AVW SO Label Generator (user's T: drive; Everyone=FullControl → updates are Ed25519-signed; private key at %APPDATA%\AVW SO Label Printer Publisher\update-signing-key.pem on user's PC, public key in electron/update-key.ts). Renderer checks on open + every 30 min; install = copy to %TEMP%, verify sha256, run setup `/S --updated --force-run`, quit → reopens. Ship updates with `npm run release -- --notes "..."` after bumping version. Tested 1.1.98→1.1.99 (local) and 1.1.99→1.2.0 (real share, ~64 s incl. copy); tampered manifest rejected. Country now always printed (USA included). Installed copy on user's PC is at %LOCALAPPDATA%\Programs\so-label-printer.
- v1.2.1 (2026-10-22, published to share + GitHub): NO box count (user wants it gone); copies via ^PQ; sizes company name 128 (weight 2 = boldest) > S.O./P.O. 84 (weight 1) > address 78 (weight 0); faux-bold = re-print shifted 2/4 dots. Release flow: bump version → `npm run release -- --notes "..."` from PowerShell (notes come through clean).
- v1.3.0 (2026-10-22, share + GitHub): "Edit address" on the label screen (shared/address.ts, AddressEditor.tsx). User chose: edit applies to that SO on screen, one time only — cleared when another SO is loaded/searched; never written to JobBOSS. Main validates (cleanAddress) and merges; print-log.csv gained an "Address Edited To" column (old header auto-upgraded). UI screenshots via electron + mock preload in scratchpad.
- v1.3.1 (2026-10-23, share + GitHub): start-up splash = AVW logo pop + looping flash + loading dots (renderer/public/splash.html, electron/splash.ts); main window show:false, revealed on ready-to-show after >=1.6 s. User REJECTED a cartoon worker/truck animation ("that's an emoji") and then real stock footage — wants logo only. Edit button renamed "Edit company / address", field "Company name". Preview builds: run electron with a harness that sets a separate userData (the installed app holds the single-instance lock).
- Gotcha: Git Bash heredocs/args mangle `\\server` UNC paths — use PowerShell or the Write tool for anything with UNC paths.
- 2026-10-23: user confirmed real printing tested on other computers — works fine (app is live in production).
- 2026-10-23: user backed up the signing key and changed the SQL password (pasted one is now dead; each PC needs the new password in Settings). User then signed out to pick up Administrators membership — verify update-folder write works next session.
- Pending (as of 2026-10-23): dedicated read-only SQL login with no expiry (optional), optional code signing, optional: delete stray junkJBExt_Support_SOShipLabel.xls from the update folder.
- 2026-10-23: update folder locked down — Everyone read; write = BUILTIN\Administrators (domain builtin, V-SERVER is the ONLY DC), AVW\Admin, AVW\bai (Bai Wu, IT). User removed Rosa/Katie/Evelyn from builtin Administrators and added AVW\ashe (needs sign-out/in before `npm run release` can write; first write test after adding was still denied on old token).

- v1.3.2 (2026-10-23): "Good morning/afternoon/evening, <FirstName> 👋" under the header; name from Windows display name via GetUserNameExW (secur32, koffi async, electron/user.ts) → fallback os username. User asked about per-user app logins → recommended NO (Windows sign-in already identifies people; print log records Windows user + PC). Offered (not built): "who's printing" picker for shared Windows accounts, central print log on V-SERVER.
- v1.3.2 committed/tagged/pushed + GitHub release done, but NOT yet on the update share: write still denied — token showed BUILTIN\Administrators "deny only" and logon session dated Oct 20 (user hadn't truly signed out). After real sign-out/restart, publish with `node scripts/publish-update.mjs --notes "..."` (installers already built in release/).

**Why:** user wants to carry the app to any onsite PC, type SO #, print on that PC's Zebra.
**How to apply:** don't revive the Vercel/Neon plan unless asked. Related: [[project-qb-sync]].
