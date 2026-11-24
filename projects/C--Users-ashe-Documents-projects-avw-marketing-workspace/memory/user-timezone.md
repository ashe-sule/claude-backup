---
name: user-timezone
description: Ashe is in Illinois (US Central Time) — check the clock before any time-of-day greeting
metadata:
  type: user
---

Ashe works in Illinois, US Central Time (America/Chicago).

**Why:** I once signed off with "have a great evening" when it was about 10:40 AM for them, and they corrected me.
**How to apply:** Don't guess the time of day. Check the time with PowerShell first: `[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTime]::UtcNow,'Central Standard Time')`. If you haven't checked, use a neutral sign-off like "have a great day". See [[project-status]].
