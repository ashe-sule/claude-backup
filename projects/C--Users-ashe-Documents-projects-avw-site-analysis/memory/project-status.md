---
name: project-status
description: "Current status of AVW Site Analyzer — last work, deploy, what's next (full detail lives in repo CLAUDE.md)"
metadata:
  node_type: memory
  type: project
  originSessionId: cd546917-c0c5-4bbf-9ed8-310e7ebb9492
  modified: 2026-11-25T15:37:27.069Z
---

As of 2026-11-25:
- **Ban detection is LIVE**: `422eeae` pushed to main with Ashe's OK. Vercel deploy succeeded. Ran the daily GitHub Action by hand once; it passed (5 min), found 0 new council items, and opened no issue.
- News half fixed in commit `e777861` (2026-11-25), **pushed and live on 2026-11-25 with Ashe's OK**. Vercel deploy succeeded. A manual Action run passed: it read all 104 GDELT files (about 155K articles) and found 0 leads. It reads GDELT's raw news files (no rate limit) plus the carwash.com RSS feed. Replay tests caught the Warren and Mission TX stories with 0 false alarms. Also added Avon OH (reviewed, holds until about Dec 23, 2026) and 5 places that only warn (Henry Co GA, Greenville Co SC, Birmingham AL, Hemet CA, Streetsboro OH).
- 2026-11-25: checked the live Warren MI report in Chrome with Ashe; the pop-up, headline and Local rules panel all work. Fixed and pushed `eaaee8c`: city-ban reports no longer say "No wash type pays back at any budget", and What-if is folded with the reason. Checked again live afterwards.
- The LPR research file `docs/research/lpr-laws-by-state.md` is still uncommitted (the repo is public; counsel must review it first).
- CLAUDE.md was updated locally with the live status and isn't committed yet.
- Ashe hasn't looked at these yet: the "Local car wash rules" panel in production (try a Warren MI address), the San Antonio planned-wash pin, /accuracy on a phone.

**Why:** a quick pointer for "where are we?". The repo's CLAUDE.md has the detail.
**How to apply:** see [[decisions-2026-11-24]] and [[gap-research-2026-11]].
