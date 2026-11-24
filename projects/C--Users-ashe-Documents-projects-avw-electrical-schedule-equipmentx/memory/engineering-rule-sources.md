---
name: engineering-rule-sources
description: "Where AVW electrical schedule rules come from (engineer emails), who answers what, and where test quotes live"
metadata:
  node_type: memory
  type: project
  originSessionId: a3e2afcd-3079-4507-a047-3137d7945d77
  modified: 2026-11-09T17:22:33.341Z
---

Engineering rules for the schedule generator come from email Q&A that Ashe drafts (sometimes in a separate Claude chat that leaves no trace in git) and sends to the engineers. Rithin answers Master List and arch questions. Heri answers project-package and amps questions.

- 2026-11-09 answers were implemented in commit 476855b: GGBTL lights go under clamp-equipped arches, VACUTECH is motor-only, and the South Morang 400 V amps were dropped (Heri: that job was special, so its amps aren't the standard; still waiting on a standard 400 V table).
- Sample quotes are in OneDrive: `Information Technology - Documents/Aroon/Quotes/9 QUOTE PDF/` (EQ-1-1134…1202). Engineer schedules for the same jobs are in `.../Quotes/Schedules/*.xlsm`.
- The tests in test_learning.py need `QUOTE_PDF` set to EQ-1-1145.pdf (an AU 400/230 quote). There is no project .venv; create one in the scratchpad from requirements.txt.
- Edit the Master List xlsx through Excel COM, never openpyxl. The app reads cached values (data_only), so an openpyxl save wipes formula results.

**Why:** when Ashe says "I made changes this morning", look outside git (emails, other chats) before saying nothing changed.
**How to apply:** ask for the email or thread early, and check new rules against the engineer .xlsm schedules.
