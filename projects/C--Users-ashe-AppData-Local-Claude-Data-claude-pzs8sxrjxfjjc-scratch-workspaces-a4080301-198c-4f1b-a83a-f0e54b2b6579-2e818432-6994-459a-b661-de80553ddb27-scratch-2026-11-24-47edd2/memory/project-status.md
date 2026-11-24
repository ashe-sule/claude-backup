---
name: project-status
description: "Status of Claude Code CLI install on Ashe's Windows PC (2026-11-24)"
metadata:
  node_type: memory
  type: project
  originSessionId: 435ecc76-bbe1-43db-9de7-5fd3f46cc779
  modified: 2026-11-24T19:35:44.969Z
---

2026-11-24: Installed Claude Code CLI 2.1.331 (native installer) at C:\Users\ashe\.local\bin\claude.exe.
- Added that folder to the Windows User PATH.
- Git Bash: added `export PATH="$HOME/.local/bin:$PATH"` to ~/.bashrc; ~/.bash_profile sources ~/.bashrc.
- Tested: `claude --version` works in PowerShell and in a Git Bash login shell.
**Why:** user wanted the CLI usable from Git Bash too.
**How to apply:** next steps are just running `claude` and signing in; nothing open.
