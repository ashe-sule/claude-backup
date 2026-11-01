---
name: Drive Mapping Script - Hide H Drive
description: Login script that maps network drives and hides H drive from File Explorer
type: project
---

Script lives at `E:\HIDE-DRIVE.cmd` (fixed copy saved at `C:\Users\ashe\.claude\downloads\Hide H Drive.cmd`)

**Server & Drive Mappings:**
- H: `\\v-server\%username%$` (user home — hidden from Explorer)
- L: `\\v-server\Library`
- Q: `\\v-server\QuickData`
- T: `\\v-server\Temp`
- Y: `\\192.168.1.11\AVW_Archive`

**Fixes applied (2026-05-01):**
- Added `HKLM` registry write so the hide is enforced at machine level (requires Run as Admin)
- Replaced individual `net use /delete` lines with `net use * /delete /y` — catches all mapped drives in one sweep
- Added registry cleanup loop (`HKCU\Network\*`) to remove persistent drive mappings that `net use /delete` misses
- Added `/persistent:no` to all `net use` map commands so drives don't get saved permanently
- Fixed Explorer restart: full path `%SystemRoot%\explorer.exe` + increased delay to 4 pings — old `start explorer.exe` was unreliable and left Explorer dead

**Why:** Two PCs behaved differently because one had persistent registry-stored drive maps that `net use /delete` doesn't touch. Explorer not restarting was caused by `start explorer.exe` not resolving the path reliably after taskkill.

**Script requires Run as Administrator** for HKLM reg write to succeed.
