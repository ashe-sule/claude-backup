---
name: project-pc-migration
description: "New PC setup (2026-11-24) — what's installed, how memory was moved, npm install results, and what's left per NEW-PC-SETUP.md"
metadata:
  node_type: memory
  type: project
  originSessionId: ff31189f-6708-454e-a989-0b88c4013ab1
  modified: 2026-11-24T22:35:23.572Z
---

Guide: `C:\Users\ashe\Documents\claude-backup\NEW-PC-SETUP.md` (copy also in `~\.claude`). Windows user is still `ashe`.

**Done 2026-11-24**
- `~\.claude` already held the restored backup + chat transcripts (memory content identical to claude-backup; only diffs: theme, plugin versions).
- Session startup error = Vercel plugin SessionStart hooks run 
ode`, Node was missing. Installed **Node 24.22.3 / npm 11.19.1** (winget `OpenJS.NodeJS.24`); hook tested, exit 0.
- Projects now at **C:\Users\ashe\Documents\projects** (not C:\Users\ashe\projects). Copied every `C--Users-ashe-projects-*` memory+history folder to `C--Users-ashe-Documents-projects-*` and rewrote old paths in the .md memory files. Old folders kept as backup.
- Root memory for `Documents` sessions built: [[projects-overview]] + cross-project notes copied in.
- settings.json autoMode paths updated to Documents\projects.
- 
pm install` run on all 30 Node folders (avw-internal-request-hub used 
pm ci` so its lock file is untouched). Result: **30/30 OK**. npm rewrote lock metadata only (no version changes) in qb-sync, KOINORIX, visitors-tracking-system/kiosk-app; line endings only in avw-marketing-workspace, cloudspend-iq. Left uncommitted — Ashe to decide commit or `git checkout`.
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
- gh ✅ logged in as ashe-sule (https); `gh auth setup-git` done → git uses gh for github.com.
- Backup test ✅: manual run pushed cb7c43b "Auto backup 2026-11-24 16:28", in sync with origin.
- Vercel MCP ✅ connected (/mcp).
- Vercel CLI ✅ logged in as suleashe-3834 (device flow). Vercel suggested turning on 2FA (account settings → authentication) — Ashe's call.
- Sentry SKIPPED by Ashe's choice (only KOINORIX uses it, DSN not set yet) — set up near launch.
- GitHub MCP (optional) not added.

**Phase 6 ✅** — all .env files present (12 expected + smartcare, AV-Waldo-work, ICC, wash-si); none tracked by git, all ignored. No-remote projects all present.

**Phase 7 ✅ (2026-11-24)** — final versions: node 24.22.3, npm 11.19.1, git 2.56.1, Python 3.11.9 (default) + 3.13.17, pwsh 7.7.0, Claude Code 2.1.331, gh 2.105.0, vercel 66.6.0, VS Code 1.146, sqlcmd 1.10, .NET 8.0.34. **PC MIGRATION COMPLETE.**
- Lock files COMMITTED 2026-11-24 (Ashe asked), not pushed: qb-sync 1a90524 (branch quoting-tool), KOINORIX 24b9aa9, visitors 07edcc3; marketing/cloudspend were line-endings only (cleared, nothing to commit).
- Open (optional): retest merge_pdfs.py with pypdf 7; SQL Server 2019 only if needed; Claude in Chrome extension.
- Note: Claude sessions opened before the installs don't see new tools on PATH → restart Claude.
- Skipped: Chocolatey (optional), SQL Server 2019 (ask Ashe). Claude in Chrome extension = Ashe.

**Still to do**
- Phase 4: Python packages; pip install -r for avw-electrical-schedule(-equipmentx), job-finder.
- Phase 5: Ashe sign-ins (gh, vercel, /mcp for Vercel + Sentry), git identity, GitHub MCP token, 5 PM backup scheduled task.
- Copy .env files by hand; no-remote projects appear already copied into Documents\projects.
- Backup script/RESTORE.md still assume C:\Users\ashe\projects for re-clones.
