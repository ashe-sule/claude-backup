---
name: project-status
description: "Latest work done on the visitor system, how it was tested/deployed, and what's next"
metadata:
  node_type: memory
  type: project
  originSessionId: 10c41a1a-f087-4391-a83b-c406f27df62d
  modified: 2026-11-10T13:36:24.171Z
---

2026-11-10: Fixed times showing in UTC (7:06am check-in shown as 1:06pm). Added timeZone 'America/Chicago' to dashboard "In at", admin history, users last-login, and kiosk sign-out list. Tested with tsc + a format check (13:06Z -> 7:06 AM). Commit 32d1932 pushed to main, so Vercel auto-deploys. No tablet app update needed (website change; reopen the app or wait for the next page load).

**Why:** Vercel servers render in UTC; only the badge and email already forced Chicago time.
**How to apply:** Any new date display must pass timeZone 'America/Chicago'.

Still open: /admin/monthly page + AdminShell nav link uncommitted/untested; tablet 1.0.2 printer check; PIN 1234; device-owner lock-down.

**2026-11-24 (new PC):** Project moved to C:\Users\ashe\Documents\projects. npm install OK. Lock-file-only commit 07edcc3 on main (kiosk-app/package-lock.json) (npm metadata sync, no version changes) — LOCAL ONLY, not pushed.
