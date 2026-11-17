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

**2026-11-13:** User forgot password; one-time recovery link generated (generateLink recovery → http://localhost:3010/auth/confirm?token_hash=…&type=recovery&next=/account/password). Script lives in session scratchpad (reset.cjs) and is easy to recreate. Dev server was already running on port 3010.

**2026-11-13 finding (user asked why the Nov 12 drop-offs "never changed / never got sent to routes"):** Live DB: AVW-261111-005..009 ARE on Kenny-TEST route 4e83e598 (2026-11-12, published, v12) in the ORIGINAL order (Valparaiso, Kankakee, Aurora, Rockford, Milwaukee). The 442-mi recommended order was a dry run only and never saved. Root causes: (1) auto-optimize not built yet ([[todo-auto-optimize]]); (2) Routes page (apps/web/src/app/(app)/routes/page.tsx) lists route_date >= today only, so yesterday's route is hidden; (3) no rollover/alert for a missed past-date route, so stops stay "scheduled" forever. Proposed: move them to Mon 2026-11-16, add the 5 pickups, build auto-optimize + a missed-route alert/rollover + show past unfinished routes. In progress: 5 new demo pickups + PO reader test (ANTHROPIC_API_KEY present).

**2026-11-13 session — auto-optimize BUILT (not committed, migration NOT pushed live):**
- Migration supabase/migrations/20261113000008_auto_optimize.sql: routes.proposed_order; _apply_order (shared), reorder_route now wraps it; auto_apply_order (dispatch, or own driver, only while every stop pending); propose_route_order / dismiss_route_proposal; roll_route_forward(route, date) moves not-started requests and cancels the emptied route.
- App: src/lib/auto-optimize.ts (applies before start; suggests once rolling, threshold 1 mi / 5 min / fewer late stops); planner.ts load check (trunk space vs vehicles.capacity_lbs); hooked into assign, bulk assign (one matrix call per route), cancel, return-to-queue, publish (re-plan with live traffic), Start shift (silent re-plan, nothing for the driver to do); route page "Approve new order" card; MissedRoutes alert + "Move stops to this day" on dashboard and Routes page.
- Tests 70/70 (4 new DB, 1 routing), tsc, eslint, next build compile OK.
- `supabase db push --remote` was BLOCKED by the auto-mode safety check → needs the user's OK or for them to run it. Until it's pushed, assigning on the LIVE app quietly skips auto-arrange, and the roll-forward button will error.
- 5 demo pickups were created LIVE: AVW-261113-001..005 (Elk Grove, Joliet high, Schaumburg, Bolingbrook urgent, Gary IN with an 8–11 AM window and a 1960-lb load), requested 2026-11-16, ready_for_dispatch, Google-verified. Note: Google moved the Gary pin to 600 Richard Gordon Hatcher Blvd.
- Next: push 0008 → roll the Nov 12 route to Mon 11/16 → bulk-assign the 5 pickups to Kenny on 11/16 → check the order → publish → commit.

**2026-11-13 later:**
- User said "push it" → migration 0008 pushed LIVE. Nov 12 route rolled to Mon 11/16 (new route 052b6756-6ba5-470b-b40a-dd6d7d763071, draft). The 5 pickups were assigned, and auto-arrange ran using the real code: 10 stops, 509 mi, about 12.6 h (heuristic, since there are more than 8 stops), peak load 2,424 lbs, and the vehicle has no capacity_lbs set.
- BUG found: rolling forward kept Kankakee's (AVW-261111-008) window on Nov 12, so the plan shows it "late". Fix = migration 20261113000009_roll_forward_windows.sql (shifts windows by the number of days moved; test added). The push was BLOCKED (each production push needs the user's OK). After the push: shift 008's window +4 days in live data, then re-run auto-arrange on the 11/16 route.
- Pickup photo proof: big "📷 Take photo of shipment or paperwork" button on the driver screen with thumbnails and a big ×. A photo is REQUIRED to confirm a pickup (unless the outcome is failed) and is checked server-side in completeStopAction. Photos are shrunk before upload. Dispatch already sees proof photos on the request page.
- Live map: date picker (?date=), "next route" link, always-visible labels (📦 Pick up in blue / 🚚 Drop off in orange, plus the name), and queue requests shown as "?" dashed markers.
- Still NOT committed. 70 tests pass, tsc and eslint OK. Not yet tested in a browser on a phone.
- User asked for plain-English explanations of "Dispatch queue" and "Routes".
- Note: one 10-stop day is too long for one driver (12.6 h). Raise splitting it across days with the user.

**2026-11-13 same-day build ([[same-day-dispatch]]), code done, NOT pushed or committed:**
- Migration 20261113000010_same_day_dispatch.sql adds:
  - settings auto_schedule=true and same_day_cutoff_hour=15
  - _assign_request (assign_request wraps it), same_day_route_date(at, driver), _pick_driver, _auto_schedule (assign + auto-publish + notify driver)
  - create_request: every submit → ready → auto-scheduled; dispatch is only pinged if there's no active driver
  - _is_service() lets the server's secret key run auto_apply_order / propose_route_order
- App changes:
  - createRequestAction geocodes, then calls autoOptimize(createAdminClient()).
  - Dispatch queue page removed (/dispatch redirects to /routes). Nav link and bulkAssignAction removed.
  - "Needed on" date field removed from the form and replaced with a note ("today; after 3 PM → next workday").
  - The success banner now says which day the request went on.
  - Dashboard stat renamed to "Not on a route".
- Tests 74/74 (legacy tests run with auto_schedule=false; 4 new same-day tests). tsc and eslint clean.
- Waiting on the user's OK to push 0009 + 0010 live, then:
  - fix Kankakee's window (+4 days)
  - re-run auto-arrange on the 11/16 route
  - check the service-key path works live (new sb_secret key → role service_role?)
  - commit

**2026-11-13 END: all LIVE + committed 8663e60 (local git only, no remote).**
- Migrations 0009 + 0010 pushed live (user said "push it"). Live settings: auto_schedule=true, same_day_cutoff_hour=15.
- Kankakee window fixed to 11/16 7–11 AM.
- Monday route 052b6756 was re-arranged with the server key (proves the employee-request path works). Result: 504 mi, 12.4 h, 0 late. The route is still DRAFT because it was created by roll-forward before 0010. roll_route_forward does not auto-publish yet (possible follow-up).
- Open follow-ups:
  - 10-stop day is too long (12.4 h): offer to split
  - ANTHROPIC_API_KEY added 2026-11-13 (local only; add to Vercel at deploy)
  - nothing tested on a real phone or in a browser click-through yet
  - warn before testing with Kenny's real phone, because new requests land on his route instantly
- 2026-11-13: Map fix (commit after 8663e60). /map with no route today now redirects to the next route day (?date=&auto=1), the map re-fits when the date changes (key=date), and a dashed route line is drawn AVW→stops→AVW. Server-side check: 10 stops in the payload for 11/16. Not visually checked in a browser.

**2026-11-13 PO reader live test PASSED:** user added ANTHROPIC_API_KEY to .env.local. Sample customer PO (Sudsy Shine, PO SS-44817, ship-to Plainfield IL) read in ~4s via extract.ts (vitest harness in scratchpad po-test/, server-only aliased to empty.js). All fields correct: delivery trip type, ship-to (not AVW/vendor addr), contact, PO ref, 3 items, required date, dock notes, no warnings. Note: requestedDate is extracted but same-day mode ignores it (no date field). Next: real AVW PO test in the app UI, spend limit confirm.

**2026-11-17:** User demoing the app NOW. Prod build running via `next start -p 3010` from main folder (background). My work happens in git worktree C:/Users/ashe/projects/AV-Waldo-work (branch work/next-fixes) so the demo isn't disturbed. Don't write live DB test data until the user says the demo is done (same live Supabase). Plan approved: click-through test → deploy (deploy still needs GitHub/Vercel accounts). Daily pickup report parked ([[todo-daily-pickup-report]]).
- 2026-11-17 commit 1f99e9c on branch work/next-fixes (worktree AV-Waldo-work, NOT merged into master yet). Migration 20261117000011_roll_forward_publish.sql: roll_route_forward allows today (rejects past dates) and auto-publishes the receiving route + notifies the driver when auto_schedule is on. Missed-routes card defaults to today on weekdays before the cutoff (min = today). 76/76 tests, tsc and eslint OK. NOT pushed live (needs the user's OK, and only after the demo). Demo note: the live app still only allows tomorrow+ for "Move stops to this day".
- Next after "demo done": push 0011 → merge to master → click-through test on live → split-long-day option → deploy (needs GitHub/Vercel).
- 2026-11-17 user said "demo done, push it": demo server stopped; work/next-fixes fast-forward merged into master (1f99e9c); migration 0011 pushed LIVE and verified (live roll_route_forward has the new past-date check). Live routes: 11/12 cancelled, 11/16 draft with 10 pending stops (missed). Next: click-through test (approved earlier), split-long-day decision pending from the user.
- 2026-11-17 CLICK-THROUGH TEST (headless Playwright, scripts in session scratchpad e2e/; Chrome extension wasn't connected). PASSED: dispatcher login, missed-route alert, "Move stops to this day" (defaults to today, the moved route 87c693f2 is auto-published + auto-optimized: 576 mi / 13.8 h, ends after midnight), live map (labels overlap a bit near Chicago), employee submit (AVW-261117-001 E2E test pickup, Elgin, landed on today's route in ~2 s), driver on phone width: start shift, arrive, Confirm locked until photo, Gary pickup (AVW-261113-005) completed with photo + "released by", dispatch sees the photo, reports page OK.
  BUG FIXED: employee request page crashed after submit (stop null under RLS) → commit e266d93, merged to master, verified on dev copy. Port 3010 restarted with the new build.
  FINDINGS for user (not fixed, need decisions): (1) driver gets a pile of must-tap alerts from automatic re-orders (12 unacked for Kenny-TEST; only 5 shown at a time) — conflicts with [[driver-view-simple]]; propose one combined "route changed" note and no alerts for silent re-plans. (2) No warning when a day runs past driver hours/midnight or windows are missed (Gary 8-11 window, ETA 12:23 PM) → ties to split-long-day. (3) Driver alert text shows raw date "2026-11-17". (4) "Dispatch added …" wording when an employee added it.
  Test leftovers LIVE: Kenny-TEST on shift since 11:34 AM; AVW-261117-001 E2E pickup on today's route; Gary pickup completed.
- 2026-11-17 user said "fix all" → commit a638079 (merged to master, NOT pushed live): migration 20261117000012_calmer_driver_alerts.sql = route-change alerts only while driver on shift/route started, ONE combined "Your route changed" per route (dedupe route_change:<id>, latest 3 lines), silent re-plan within 2 min of Start shift, clears old route_updated backlog, _fmt_day friendly dates, "was added to your route" wording, setting max_route_hours=10, RPC move_stops_forward. Route page LongDayCard: too long / missed windows + "Move N stops to <next workday>" (dispatch taps). Verified the card on today's route (13.8 h, suggests moving Rockford + Milwaukee to Wed 11/18). 80 tests pass, build OK. WAITING: user OK to push 0012 live, and whether to tidy test leftovers.
- 2026-11-17 user said "push it": migration 0012 pushed LIVE + verified (move_stops_forward exists, max_route_hours=10, new wording/dates, 0 open route_updated alerts). App rebuilt and running on 3010 from master a638079. Test leftovers tidy-up still awaiting the user's answer.
- 2026-11-18 PHASE 1 BUILD (user said "Proceed and build"): commit 5f67ae5 on branch work/next-fixes (worktree), NOT merged into master, NOT live.
  Migration 20261118000013_tracking_reliability.sql:
  - proof rules in the DB: driver_complete_stop wrapper over _driver_complete_stop_core; photo must exist in storage under a request on the stop; delivery needs the recipient name
  - driver_report_gps_status + driver_shifts.gps_status
  - tracker_ingest (server key only, tracker_enabled setting off by default, only while on shift, md5 dedupe) + vehicles tracker columns + admin_set_vehicle_tracker
  - rate_limits table + _rate_limit; wrappers on create_request and driver_report_location; check_rate_limit('po_extract'|'geocode')
  - _move_requests_forward + handle_unfit_request (D1); move_stops_forward now uses the same core
  - deletes max_route_hours (the shift_minutes admin setting is the single day-length limit)
  App:
  - lib/freshness.ts states on the map + dashboard
  - /api/tracker/bouncie webhook (BOUNCIE_WEBHOOK_KEY; /api/tracker/ is public in proxy)
  - Admin tracker box
  - driver delivery name (pre-filled) + camera opens on Confirm, then auto-finishes; app-layer photo check removed (the DB enforces it)
  - lib/day-fit.ts after create (uses the autoOptimize plan; AutoResult now carries the plan)
  - request Timeline; "route full" banner
  85 tests pass, tsc/eslint/build OK.
  ⚠️ This app code needs 0013 LIVE first, or PO reading breaks (check_rate_limit is missing). Not browser-tested yet; that needs 0013 live (no local Supabase).
  Next: user says "push it" → push 0013 → merge to master → Playwright click-through. Deploy + Sentry are still waiting on GitHub/Vercel accounts.
- 2026-11-17 ~3:40 PM: user said "push" → migration 0013 pushed LIVE and verified (8 new functions; max_route_hours removed; tracker_enabled=false). Master = 35db607 (includes fix: the GPS-status RPC was never sent because Supabase builders are lazy → added .then; GPS shows "off" as soon as the phone reports it blocked). User approved restarting the 3010 server; it is running the new build.
  Hidden-browser test PASSED:
  - webhook 401 without key
  - employee submit after 3 PM → Wed 11/18 + Timeline OK (AVW-261117-002 E2E leftover)
  - delivery: name pre-filled ("Receiving"), Confirm opens the camera, photo → auto-saved (Kankakee AVW-261111-008 delivered, proof 1 photo)
  - GPS blocked → dashboard and map "GPS off" + dispatch alert; allowed again → status ok
  Not live-tested (covered by DB tests): day-full move/flag (Wed route not full), rate limits, tracker ingest.

**END OF SESSION 2026-11-17 — where we stopped**
- All code committed: master = 35db607, and branch work/next-fixes is the same. Local git only (no GitHub yet). Live DB has migrations 0001–0013.
- Test leftovers waiting for a "tidy it":
  - Kenny-TEST still on shift
  - AVW-261117-001 (on the 11/17 route)
  - AVW-261117-002 (on the Wed 11/18 route)
  - demo Kankakee delivery marked done
- Next, in order (each needs approval per [[av-waldo-2-brief]]):
  1. Deploy to Vercel + Sentry. Needs Ashe's GitHub/Vercel sign-in. Set env vars there: Supabase, Google, Anthropic, BOUNCIE_WEBHOOK_KEY. Update Supabase site_url and redirects.
  2. Bouncie: Ashe checks price + business-use terms, then buys. After that: IMEI in Admin → Settings, and register the webhook at /api/tracker/bouncie with the key.
  3. Phase 2: Command Center, live ETAs (fill stops.planned_eta), proactive exceptions (cron + severity), employee arrival window.
- Daily 5 PM pickup email is still PARKED ([[todo-daily-pickup-report]]).
