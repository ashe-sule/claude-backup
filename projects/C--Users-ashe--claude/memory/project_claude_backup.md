---
name: project-claude-backup
description: ~/.claude backs up daily to private repo ashe-sule/claude-backup — memory/settings only, chats deliberately excluded
metadata:
  type: project
---
Since 2026-11-01, `C:\Users\ashe\.claude` is a git repo (whitelist `.gitignore`) pushing to private github.com/ashe-sule/claude-backup (branch `main`).
- Task Scheduler "Claude Daily Backup" runs `backup-claude.ps1` daily at 5 PM: commits memory (global + `projects/*/memory/`), CLAUDE.md, settings.json, plugin list, loose scripts. Log: `backup.log`. Restore steps in `RESTORE.md`.
- Chat transcripts/history are NOT backed up — user tried it (encrypted, then redacted, then full) and decided 2026-11-01 to skip chats and keep only memories + the rest.
- Never commit `.credentials.json`.

**Why:** user wants to resume all work if the device is damaged; memory files carry the key facts.
**How to apply:** don't re-add chat backup unless asked. User said "always compress well before pushing to github" — use max compression for any future large backup upload.
