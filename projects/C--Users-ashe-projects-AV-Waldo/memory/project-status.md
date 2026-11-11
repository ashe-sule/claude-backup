---
name: project-status
description: AV-WALDO current status - what's done, how tested/deployed, what's next
metadata:
  type: project
---
AV-WALDO = AVW Equipment internal dispatch/GPS/pickup-delivery app (driver: Kenny, 1 vehicle). Full 40-section brief pasted 2026-11-11. Decisions: [[av-waldo-decisions]].

**Session 1 (2026-11-11) — DONE. Committed 9bd3c4b on main (local only, no remote yet). Not deployed.**
- npm-workspaces monorepo: apps/web (Next 16.4, Cache Components OFF), packages/shared (zod rules), packages/routing (Google + simulation providers, exact<=8 stops / heuristic solver, urgent insertion evaluator, long-distance warnings), packages/database (PGlite tests).
- supabase/migrations 0001-0005: schema, RLS, SECURITY DEFINER RPC "rules engine" (all writes), storage bucket, realtime, 64 status transitions. supabase/config.toml: signups off, min pw 10.
- Web: login/reset/invite confirm, dashboard, new request, requests list/detail, dispatch queue (bulk assign), routes + optimize/lock/reorder/publish, driver web view (shift/arrive/complete/proof/issues), exceptions, notifications, reports + CSV, admin users/settings, 404/500.
- Docs: README, docs/ARCHITECTURE.md (ERD, ADRs, 16 answers), SETUP.md, STATUS.md, LAUNCH-CHECKLIST.md.
- Tested: 57 vitest tests pass (9 shared, 16 routing, 32 DB on real Postgres via PGlite), tsc, eslint, next build, local prod smoke test (redirects to /setup with no DB; security headers present). NOT tested against live Supabase/Vercel/phone.
- Port 3123 on user's PC is used by another app — don't kill it.

**Next:** user creates Supabase project (+ env vars) -> push migrations, bootstrap admin (SQL in SETUP.md §4), click-through E2E; Google key w/ budget cap; Vercel deploy (root apps/web); Sentry; then Phase 2 Expo app + GPS. AVW HQ = 114 South 9th Ave, Maywood IL 60153 (migration 0005, Google-verified pin 41.887417,-87.844465). Google key added by user to apps/web/.env.local on 2026-11-11 and live-tested OK (geocoding + Routes matrix; AVW->Indianapolis 193 mi/207 min). Commit 9dab42f. Key must also go into Vercel env at deploy; budget alert not yet confirmed. User asked about Neon vs Supabase (2026-11-11) — recommended staying on Supabase. User wants a preview. Open items: IT contact for footer, GPS privacy policy (HR).

**Supabase live (2026-11-11):** project "AV-Waldo" ref xqbzxhxwmzspmeewmpiw (us-east-1), linked; 5 migrations + demo seed pushed. Keys written to apps/web/.env.local (incl. SUPABASE_ACCESS_TOKEN 30-day + SUPABASE_DB_PASSWORD; user may delete token later). Auth config via Management API: signups off, min pw 10, invite/recovery templates -> /auth/confirm, site_url http://localhost:3010 (port 3000 is used by another app on user's PC). Test users (passwords in scratchpad file av-waldo-test-logins.txt): kenny.test@ (driver), dispatch.test@, employee.test@example.com. Live E2E passed; data AVW-261111-001..003 left as history. Gotcha: hosted GoTrue sets app_metadata AFTER insert -> new users start inactive employee; activate via admin_update_user/SQL. Admin account created 2026-11-11: ashe@avwequipment.com (role admin, name Ashe Sule); user given one-time recovery link to set password (expires ~1h; regenerate with admin.generateLink type recovery if needed). Dev server run on port 3010.

**2026-11-11 later (commit after 5b13eb4):** User asked: only Pick up/Drop off trip types; upload customer PO → AI reads drop-off location + items; Kenny sees attachments; live driver location. DONE: ACTIVE_REQUEST_TYPES; PO reader (apps/web/src/lib/extract.ts, claude-opus-5-5, structured output, fallbacks default) — NEEDS ANTHROPIC_API_KEY in .env.local (not yet provided; without it file is attach-only); drafts storage; driver attachments; browser GPS on shift (/driver LocationSharing) + /map Live Map (Leaflet/OSM). Migrations 0006 + 0007 pushed live (0007 fixed real bug: staff could read others' drafts). pg_cron purge job scheduled. 65 tests pass. Not yet: real phone test, real PO through Claude.

**2026-11-11 demo route:** 5 DEMO drop-offs AVW-261111-005..009 (Milwaukee, Valparaiso, Rockford urgent, Kankakee before 11AM, Aurora high) on Kenny-TEST route 4e83e598-6c41-44ae-97fd-0b2e0a894ea0 for 2026-11-12 (route was already 'published' from an earlier test). Dry-run with live Google: as-assigned 622 mi/13h, Kankakee 6h late; recommended (exhaustive) 442 mi/10.1h, all on time. Insight to raise: "urgent" without a time window doesn't move a stop earlier (priority only weights lateness) — possible rule change if user wants urgent-first.

**End of session 2026-11-11:** all code committed (latest 88ede43, local git only, no remote). Live Supabase holds migrations 0001-0007, test users, demo data. Dev server was run with `npx next dev -p 3010` from apps/web (restart it next session to preview; login http://localhost:3010/login). Test logins saved in project root test-logins.local.txt (git-ignored). Next session start: read [[waiting-on-user]] and [[todo-auto-optimize]].
