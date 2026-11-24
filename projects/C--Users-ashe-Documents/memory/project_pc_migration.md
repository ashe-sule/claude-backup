---
name: project-pc-migration
description: "New PC setup (2026-11-24) — what's installed, how memory was moved, npm install results, and what's left per NEW-PC-SETUP.md"
metadata:
  node_type: memory
  type: project
  originSessionId: ff31189f-6708-454e-a989-0b88c4013ab1
  modified: 2026-11-24T22:12:45.053Z
---

Guide: `C:\Users\ashe\Documents\claude-backup\NEW-PC-SETUP.md` (copy also in `~\.claude`). Windows user is still `ashe`.

**Done 2026-11-24**
- `~\.claude` already held the restored backup + chat transcripts (memory content identical to claude-backup; only diffs: theme, plugin versions).
- Session startup error = Vercel plugin SessionStart hooks run `node`, Node was missing. Installed **Node 24.22.3 / npm 11.19.1** (winget `OpenJS.NodeJS.24`); hook tested, exit 0.
- Projects now at **C:\Users\ashe\Documents\projects** (not C:\Users\ashe\projects). Copied every `C--Users-ashe-projects-*` memory+history folder to `C--Users-ashe-Documents-projects-*` and rewrote old paths in the .md memory files. Old folders kept as backup.
- Root memory for `Documents` sessions built: [[projects-overview]] + cross-project notes copied in.
- settings.json autoMode paths updated to Documents\projects.
- `npm install` run on all 30 Node folders (avw-internal-request-hub used `npm ci` so its lock file is untouched). Result: **30/30 OK**. npm rewrote lock metadata only (no version changes) in qb-sync, KOINORIX, visitors-tracking-system/kiosk-app; line endings only in avw-marketing-workspace, cloudspend-iq. Left uncommitted — Ashe to decide commit or `git checkout`.
- AV-Waldo-work git worktree pointed at the old path → fixed with `git worktree repair`.
- Intelligence Command Center has no commits yet (package files show as untracked — expected).

**Phases 1-3 (2026-11-24, approved by Ashe)**
- Installed ✅: PowerShell 7.7.0, gh 2.105.0, Vercel CLI 66.6.0, VS Code 1.146, Notepad++, .NET 8.0.34 runtime, sqlcmd 1.10.
- Already on PC ✅: Chrome 158, ODBC 17, OLE DB 18, VC++ 2013 + 2015+ (x64/x86), QuickBooks Enterprise 24 + QB runtime, Crystal runtime 13.0.35.
- Python ✅ on retry: 3.11.9 (default `python`, C:\Program Files\Python311) + 3.13.17 via `py -3.13`. First try failed 1602 = UAC prompt timed out.
- Phases 1-3 COMPLETE.

**Phase 4 COMPLETE (2026-11-24)** — into Python 3.11 user site-packages (AppData\Roaming\Python\Python311): pip 26.3, all 17 base packages, + `-r requirements.txt` for avw-electrical-schedule, avw-electrical-schedule-equipmentx, job-finder. All imports OK, `pip check` clean. Newer majors than old PC: pypdf 7.1.1 (was 6.13), pywin32 312 (was 311) — retest merge_pdfs.py if PDF errors.

**Phase 5 (2026-11-24, approved)**
- Username = ashe → no folder renames needed.
- Global git restored per [[git-identity-leak]]: name "Ashe Sule", email = GitHub noreply, useConfigOnly=true, defaultBranch main. Repo-local emails came over intact (public repos noreply; qb-sync/pnr-kiosk/visitors = yahoo).
- 'Claude Daily Backup' scheduled task registered (daily 5 PM).
- ~/.claude fast-forwarded to 6c488c1 (old PC's last commit, adds NEW-PC-SETUP.md) from the local Documents\claude-backup copy, so first push won't be rejected.
- Plugins vercel + sentry enabled; claude.ai connectors (Docs, Canva, Floot) ✔ Connected.
- WAITING ON ASHE: `gh auth login` (then Claude runs `gh auth setup-git` + backup test push), `vercel login`, `/mcp` auth for Vercel + Sentry, GitHub MCP token.
- Skipped: Chocolatey (optional), SQL Server 2019 (ask Ashe). Claude in Chrome extension = Ashe.

**Still to do**
- Phase 4: Python packages; pip install -r for avw-electrical-schedule(-equipmentx), job-finder.
- Phase 5: Ashe sign-ins (gh, vercel, /mcp for Vercel + Sentry), git identity, GitHub MCP token, 5 PM backup scheduled task.
- Copy .env files by hand; no-remote projects appear already copied into Documents\projects.
- Backup script/RESTORE.md still assume C:\Users\ashe\projects for re-clones.
