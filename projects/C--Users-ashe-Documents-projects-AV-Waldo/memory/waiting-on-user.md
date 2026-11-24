---
name: waiting-on-user
description: Open items AV-WALDO is waiting on from the user (as of end of 2026-11-11)
metadata:
  type: project
---
As of 2026-11-11 end of session, waiting on the user for:
1. ANTHROPIC_API_KEY: DONE 2026-11-13 (user added to apps/web/.env.local; PO reader tested OK). Still need: confirm Anthropic monthly spend limit set; add key to Vercel env at deploy.
2. User's "other things to add" (features) — collect before building [[todo-auto-optimize]] on 2026-11-12.
3. GitHub & Vercel sign-in to deploy (Phase 1 last step; also needed for the Bouncie webhook). Bouncie purchase after checking price + business-use API terms.
4. Email sending choice (M365 SMTP relay vs Resend) + DNS access for avwequipment.com.
5. Spending caps: Google Cloud budget alert, Anthropic limit, Supabase/Vercel.
6. HR-approved GPS privacy note for drivers (tracking is already live).
7. IT contact text for error pages.
8. Real staff list (names/emails/roles) incl. Kenny.
Later: delete Supabase access token (30-day), Supabase Pro + restore test. (JobBOSS/QuickBooks integration DROPPED by Ashe 2026-11-17.)
9. Daily pickup report email: choose email method (M365 Graph recommended vs Resend) + how recipients are managed. See todo-daily-pickup-report.md
10. (2026-11-20) Work emails for Mike (admin), Kenny (driver), Dane + Milutin (manager, view-only), so I can create real logins. Emails = login username + sign-in/reset links; work email preferred; Kenny's must be checkable on his phone. Explained to Ashe 2026-11-20.
11. (2026-11-20) Retire the demo vehicle "Company Truck 1" (DEMO-1)? I offered; no answer yet.
12. (2026-11-20) Order the 2 vehicle phones (Tahoe + Truck) + GPS device.
13. (2026-11-20) The Supabase access token in .env.local is INVALID (401). Either a new token, or keep using the dashboard SQL Editor for live SQL. `supabase login` can't run in the ! prompt (non-TTY).
14. (2026-11-20) Road speed limits: the free OSM/Overpass servers were flaky. If alerts need to be reliable → HERE/TomTom key + spending cap.
