# Claude Code Backup — Restore Guide

## What's in here
- `CLAUDE.md` — global instructions (who I am, how I like to work, launch checklist)
- `settings.json` — Claude Code settings (model, plugins, auto-mode rules)
- `memory/` — global memory
- `projects/*/memory/` — per-project memory (QB Sync, SO Label Printer, Portfolio, CloudSpend IQ, Invoice Generator, Hebron, Visitors Tracking...)
- `plugins/installed_plugins.json`, `known_marketplaces.json` — list of plugins to reinstall
- `merge_pdfs.py`, `AVW_Glide_Plate_Generator.spec` — loose scripts

## Chat transcripts (encrypted, separate)
- Stored as **Releases** in this repo (`transcripts-YYYY`), not in the code.
- Each file is max-compressed (xz -9e) + AES-256 encrypted. First one = full, later ones = only new/changed chats.
- Password: in your password manager (set via `setup-backup-password.ps1`).

## Not backed up (on purpose)
- `.credentials.json` — login token. Just run `claude` and sign in again.
- `.transcript-key` — your password, locked to this PC's Windows account.
- Caches, telemetry, file-history.

## Restore on a new PC
1. Install Node.js + Git, then Claude Code: `npm install -g @anthropic-ai/claude-code`
2. Run `claude` once and sign in (creates `C:\Users\<you>\.claude`), then exit.
3. In PowerShell:
   ```powershell
   cd $HOME\.claude
   git init
   git remote add origin https://github.com/ashe-sule/claude-backup.git
   git fetch origin
   git checkout -f -B main origin/main
   ```
4. **If your Windows username isn't `ashe`**, rename folders in `projects\` to match
   (e.g. `C--Users-ashe-projects-qb-sync` → `C--Users-NEWNAME-projects-qb-sync`).
   Project memory is matched by folder path.
5. Restore chats: `powershell -ExecutionPolicy Bypass -File $HOME\.claudeestore-transcripts.ps1` (asks for your backup password).
   Then re-run `setup-backup-password.ps1` and re-create the daily task (see below).
6. Re-clone your project repos into the same paths (e.g. `C:\Users\<you>\projects\qb-sync`).

## Daily auto backup (Task Scheduler)
```powershell
$a = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument "-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$HOME\.claudeackup-claude.ps1`""
$t = New-ScheduledTaskTrigger -Daily -At 5:00PM
$s = New-ScheduledTaskSettingsSet -StartWhenAvailable -RunOnlyIfNetworkAvailable -ExecutionTimeLimit (New-TimeSpan -Hours 2)
Register-ScheduledTask -TaskName 'Claude Daily Backup' -Action $a -Trigger $t -Settings $s -Force
```

## Back up again (anytime)
```powershell
cd $HOME\.claude; git add -A; git commit -m "Backup $(Get-Date -f yyyy-MM-dd)"; git push
```
