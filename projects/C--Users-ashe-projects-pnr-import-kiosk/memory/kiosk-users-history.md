---
name: kiosk-users-history
description: Kiosk per-user access codes (Ashe/Aleks/Goran), History in Neon Postgres, greeting with Maywood weather — built 2026-11-10
metadata:
  type: project
---

Built 2026-11-10 (local first, push only on Ashe's "push"):
- Per-user codes: KIOSK_ACCESS_CODE = Ashe (kept, Ashe chose this), KIOSK_CODE_ALEKS, KIOSK_CODE_GORAN. Ashe sets them in Vercel; Claude never sees them. Cookie v2 = "<user>.<hmac>" (old shared-code sessions sign out once). The "Your name" box was removed; imports log the signed-in user.
- History: Neon Postgres (Ashe uses Neon in avw-invoice-generator; switched from Upstash at Ashe's nudge). @neondatabase/serverless 1.2.0, DATABASE_URL, table kiosk_history (env, user_name, action, details jsonb), auto-created.
- Greeting: Good morning/afternoon/evening (viewer clock) + NWS weather for AVW office, 105 S 9th Ave, Maywood IL 60153.
- First question "What would you like to do today?" Import / Export / History; step numbers removed.

**Why:** Aleks and Goran use the kiosk; Ashe wants accountability + a friendlier, professional front page.
**How to apply:** History is untested until Ashe connects Neon. Related: [[jb-qb-export-email]]

Status 2026-11-10: pushed live (commit bbd73d2). Ashe set Neon DATABASE_URL + Aleks/Goran codes in Vercel (marked Sensitive) and saw the live greeting working. Then Ashe asked for emoji on the greeting: added locally (time-of-day icon, 👋, 📅, sky icon, emoji on the weather note). Pushed live 2026-11-10 (commit 783b52d), verified in live JS. Next: Ashe sends Aleks/Goran their codes privately; nothing else pending.
