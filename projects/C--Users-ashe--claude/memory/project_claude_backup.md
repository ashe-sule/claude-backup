---
name: project-claude-backup
description: ~/.claude backs up daily to private repo ashe-sule/claude-backup; chats go redacted + max-compressed to GitHub Releases (no password)
metadata:
  type: project
---
Since 2026-11-01, `C:\Users\ashe\.claude` is a git repo (whitelist `.gitignore`) that pushes to private github.com/ashe-sule/claude-backup (branch `main`).
- Task Scheduler "Claude Daily Backup" runs `backup-claude.ps1` daily at 5 PM: commits memory/settings/CLAUDE.md, then runs `backup-transcripts.ps1`.
- Chat transcripts: only new/changed since `.transcript-stamp`, secrets blanked via `redact.sed` in a staging copy, `xz -9e`, uploaded as release assets under tag `transcripts-YYYY`. Restore with `restore-transcripts.ps1`. Log: `backup.log`.
- Never commit `.credentials.json` or unredacted transcripts (12 contain real secrets). User explicitly does NOT want a password on chat backups; redaction is the agreed safeguard.

**Why:** user wants to be able to resume all work if the device is damaged.
**How to apply:** user said "always compress well before pushing to github", so use max compression for any backup upload. Keep incremental-only (old chats shouldn't be uploaded again).
