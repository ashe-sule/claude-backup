# New PC Setup — Instructions for Claude

> **Hey Claude 👋 — read this whole file first.**
> Ashe is moving to a new Windows PC and wants **you** to set it up so work carries on exactly like the old PC.
> Inventory taken from the old PC on **2026-11-24**.
>
> **Your rules while doing this:**
> 1. **Ask Ashe before starting each phase** (Ashe's rule: never take on a task without approval). One "go ahead" per phase is enough.
> 2. **Check before installing** — run `<tool> --version` first; skip anything already there.
> 3. **Verify after installing** — run the version check again and report ✅ / ❌ per item.
> 4. **Never ask Ashe to paste passwords, tokens or `.env` contents into chat.** Tell Ashe to type them in the terminal or copy the files themselves.
> 5. Keep updates short, friendly, bullet points (see `CLAUDE.md`).
> 6. When done, update memory (`project_pc_migration.md`) with what was installed, what failed, and what's left.
> 7. Open a **new terminal** after installing things so PATH updates are picked up.

---

## 🚦 Phase 0 — What Ashe does by hand first (before Claude can help)

Ashe needs to do these so Claude can run at all:

1. Install **Git**: `winget install Git.Git`
2. Install **Claude Code**: `irm https://claude.ai/install.ps1 | iex` (PowerShell)
3. Open a new terminal, run `claude`, sign in, then exit.
4. Restore the Claude backup (brings back this file, memory, settings, CLAUDE.md):
   ```powershell
   cd $HOME\.claude
   git init
   git remote add origin https://github.com/ashe-sule/claude-backup.git
   git fetch origin
   git checkout -f -B main origin/main
   ```
5. Start `claude` in `C:\Users\<you>\.claude` and say:
   **"Read NEW-PC-SETUP.md and set up my new PC."**

---

## 🧱 Phase 1 — Must-haves

| Tool | Old PC version | Install command | Check |
|---|---|---|---|
| Node.js (+ npm) | 24.15.0 / npm 11.12 | `winget install OpenJS.NodeJS` (confirm major = 24 with `node -v`) | `node -v`, `npm -v` |
| Git (+ Git Bash, curl, ssh, openssl) | 2.54.0 | `winget install Git.Git` | `git --version` |
| Python 3.11 (main) | 3.11.9 | `winget install Python.Python.3.11` | `py -3.11 --version` |
| Python 3.13 (secondary) | 3.13.2 | `winget install Python.Python.3.13` | `py -3.13 --version` |
| PowerShell 7 | 7.6.7 | `winget install Microsoft.PowerShell` | `pwsh --version` |
| Claude Code | 2.1.x | already done in Phase 0 | `claude --version` |

Notes:
- On the old PC, `python` on PATH pointed to **3.11** (`C:\Program Files\Python311`). Keep 3.11 as the default.
- If `winget` is missing, use Chocolatey (`choco install <pkg> -y`) — old PC had Chocolatey 2.2.2.

---

## 🛠️ Phase 2 — Developer tools

| Tool | Old PC version | Install command | Check |
|---|---|---|---|
| GitHub CLI | 2.103.3 | `winget install GitHub.cli` | `gh --version` |
| Vercel CLI | 66.6.0 | `npm install -g vercel` | `vercel --version` |
| VS Code | 1.138 | `winget install Microsoft.VisualStudioCode` | `code --version` |
| Google Chrome | 158 | `winget install Google.Chrome` | open it |
| Notepad++ | 8.6.7 | `winget install Notepad++.Notepad++` | — |
| Chocolatey (optional) | 2.2.2 | see chocolatey.org/install (admin PowerShell) | `choco --version` |

Chrome also needs the **Claude in Chrome** extension — Ashe installs it and signs in.

---

## 🗄️ Phase 3 — Needed for specific projects

| Component | Used by | How |
|---|---|---|
| .NET 8 Runtime (x64) | various | `winget install Microsoft.DotNet.Runtime.8` |
| Visual C++ Redistributable 2015–2022 (x64 + x86) | Python wheels, Electron, drivers | `winget install Microsoft.VCRedist.2015+.x64` and `Microsoft.VCRedist.2015+.x86` |
| Visual C++ 2013 Redistributable (x64 + x86) | older drivers / Crystal | `winget install Microsoft.VCRedist.2013.x64` and `.x86` |
| Microsoft ODBC Driver 17 for SQL Server | **SO Label Printer** (JobBOSS SQL on V-JOBBOSS) | `winget install Microsoft.msodbcsql.17` |
| Microsoft OLE DB Driver 18 for SQL Server | JobBOSS / reports | Microsoft download page (manual) |
| sqlcmd (SQL Server command line utilities) | SQL checks | `winget install Microsoft.Sqlcmd` |
| SQL Server 2019 (local engine) | local DB work | **Ask Ashe** if still needed — manual installer |
| QuickBooks Runtime Redistributable | **QB Sync** (QB Web Connector) | Comes with QuickBooks / QBWC install — manual, **ask Ashe** |
| SAP Crystal Reports runtime for .NET (32-bit) 13.0.35 | JobBOSS reports | SAP download — manual, **ask Ashe** |

Items marked "manual" → tell Ashe what to download; don't hunt for random installers.

---

## 🐍 Phase 4 — Python packages (install into Python 3.11)

```powershell
py -3.11 -m pip install --upgrade pip
py -3.11 -m pip install fastapi uvicorn httpx pydantic python-dotenv pyyaml pyinstaller pypdf python-docx docx2pdf pywin32 beautifulsoup4 lxml geopy tqdm watchfiles websockets
```

Check: `py -3.11 -m pip list` — confirm all of the above show up.

Old PC versions for reference: fastapi 0.163.1, uvicorn 0.54.0, httpx 0.28.1, pydantic 2.14.3, python-dotenv 1.2.4, PyYAML 6.0.3, pyinstaller 6.20.0, pypdf 6.13.2, python-docx 1.2.0, docx2pdf 0.1.8, pywin32 311, beautifulsoup4 4.15.0, lxml 6.1.0, geopy 2.4.1, tqdm 4.67.3, watchfiles 1.3.0, websockets 17.4.

Project-specific Python deps come from each repo's `requirements.txt` (Phase 6).

---

## 🔌 Phase 5 — Claude-side setup

1. **Windows username check** — run `$env:USERNAME`. If it is **not** `ashe`, rename every folder in `$HOME\.claude\projects\` from `C--Users-ashe-...` to `C--Users-<newname>-...` (project memory is matched by path). Also tell Ashe that `settings.json` mentions `C:\Users\ashe\...` paths.
2. **Sign-ins — Ashe types these, Claude just tells them which ones** (Ashe can use `! <command>` in the prompt):
   - `gh auth login`
   - `vercel login`
   - Vercel + Sentry plugins: run `/mcp` and authenticate
   - Git identity: `git config --global user.name "Ashe Sule"` and `git config --global user.email` (ask Ashe which email)
3. **Plugins** — confirm `vercel@claude-plugins-official` and `sentry@claude-plugins-official` are enabled (`settings.json`). Reinstall from `plugins/installed_plugins.json` if missing.
4. **GitHub MCP server** — re-add it (needs a GitHub token; Ashe sets it, never pasted into chat):
   ```powershell
   claude mcp add github -s user -e GITHUB_PERSONAL_ACCESS_TOKEN=<Ashe types token> -- npx -y @modelcontextprotocol/server-github
   ```
   Check with `claude mcp list` → github should be ✓ Connected.
5. **claude.ai connectors** (Claude Docs, Canva, Floot) come back automatically with Ashe's Claude account — just confirm in `claude mcp list`.
6. **Daily backup task (5 PM)** — recreate it:
   ```powershell
   $a = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument "-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$HOME\.claude\backup-claude.ps1`""
   $t = New-ScheduledTaskTrigger -Daily -At 5:00PM
   $s = New-ScheduledTaskSettingsSet -StartWhenAvailable -RunOnlyIfNetworkAvailable -ExecutionTimeLimit (New-TimeSpan -Hours 2)
   Register-ScheduledTask -TaskName 'Claude Daily Backup' -Action $a -Trigger $t -Settings $s -Force
   ```
   Then run `backup-claude.ps1` once by hand and confirm it pushes.

---

## 📁 Phase 6 — Projects (`C:\Users\<you>\projects\`)

Clone each into `$HOME\projects\<folder name>` (keep the **same folder names** — memory depends on them), then run `npm install` (node) or `py -3.11 -m pip install -r requirements.txt` (python).

| Folder | Git remote | Type | Has secret env files |
|---|---|---|---|
| ashe-portfolio | https://github.com/Ilashe/ashe-portfolio.git | node | — |
| avw-electrical-schedule | https://github.com/ashe-sule/avw-electrical-schedule.git | python | — |
| avw-electrical-schedule-equipmentx | https://github.com/equipmentx/avw-electrical-schedule.git | python | — |
| avw-internal-request-hub | https://github.com/equipmentx/avw-internal-request-hub.git | node | — ⚠️ LIVE PRODUCTION — read-only, never edit/deploy |
| avw-invoice-generator | https://github.com/ashe-sule/invoicegenerator.git | node | .env.local |
| avw-marketing-workspace | https://github.com/ashe-sule/avw-marketing-workspace.git | node | .env.local |
| avw-quoting-tool | https://github.com/equipmentx/avw-quoting-tool.git | node | .env.local |
| avw-site-analysis | https://github.com/equipmentx/avw-site-analysis.git | node | .env.local |
| avw-smartcare | https://github.com/ashe-sule/avw-smartcare.git | — | — |
| cloudspend-iq | https://github.com/ashe-sule/cloudspendiq.git | node | — |
| CORYNEXA | https://github.com/ashe-sule/corynexa.git | node | — |
| electric-schedule-tool | https://github.com/ilashe/electric-schedule-tool.git | node | — |
| electric-schedule-tool-ashe | https://github.com/ashe-sule/electric-schedule-tool.git | — | — |
| hebron-consults | https://github.com/ashe-sule/hebron-consults.git | node | .env.local |
| job-finder | https://github.com/Ilashe/job-finder.git | python | — |
| KOINORIX | https://github.com/ashe-sule/koinorix.git | node | .env |
| pnr-import-kiosk | https://github.com/ashe-sule/pnr-import-kiosk.git | node | .env.local, .env.prod-readonly |
| qb-sync | https://github.com/ashe-sule/qb-sync.git | node | .env.local |
| so-label-printer | https://github.com/ashe-sule/so-label-printer.git | node | — |
| visitors-tracking-system | https://github.com/equipmentx/visitors-tracking-system.git | node | .env.local |

**⚠️ No git remote — these can't be cloned. Ashe must copy them from the old PC (USB / OneDrive):**
- AV-Waldo, AV-Waldo-work, avw-arch-configurator (has .env.local), Intelligence Command Center, so-ship-label, github-buildup
- avw-local-db-backup-* folders (4) — local DB backups, copy only if Ashe still wants them

**⚠️ Secret `.env` files are NOT in git.** Ashe must copy them over by hand (or pull with `vercel env pull .env.local` for Vercel-linked projects after `vercel link`). Never print their contents.

Also not in the backup: loose files in old `C:\Users\ashe\.claude\` like `electric-schedule-tool*` folders — remind Ashe to copy anything else they want.

---

## ✅ Phase 7 — Final check & report

Run all version checks again, `claude mcp list`, and `gh auth status`, then give Ashe a simple report:
- ✅ done / ❌ failed / ⏳ waiting on Ashe — per item
- List anything Ashe still has to do by hand (sign-ins, manual installers, copying `.env` files and no-remote projects)
- Save the result to memory (`project_pc_migration.md`) and update `MEMORY.md`.

**Not on the old PC — don't install unless Ashe asks:** Azure CLI, AWS CLI, Docker, Java, pnpm, yarn, bun.
