---
name: demo-feedback-2026-11-19
description: "Feedback list Ashe pasted on 2026-11-19 after the boss demo — 8 feature asks + 2 purchases; plan proposed, NOT approved yet"
metadata:
  node_type: memory
  type: project
  originSessionId: 56e6ae79-69c9-449d-82b4-6ff53ffeaf07
  modified: 2026-11-19T22:52:06.899Z
---

Pasted by Ashe 2026-11-19, after the 11/18 boss demo (verbatim points):
1. Trial with **Mike** (manages the admin side) and **Kenny** (driver).
2. New status **"Partial Pick Up"**.
3. New status **"Future Deliveries"**, visible to admin only.
4. Phones installed in the **Tahoe and the truck** for GPS (so 2 vehicles now, not 1) + **speeding notifications**.
5. Driver lunch button: **"Punch Out" / "Punch In"**.
6. **Pick-up ready time** (when the pickup will be ready).
7. **Buddy Bear 7am–10am**: all their requests should be prioritized.
8. Live tracking + route on **Dane's and Milutin's phones**.
Purchases (Ashe's to-do): order phones, order GPS device.

Status: BUILT 2026-11-19 (see below), awaiting "push it". Rules from [[av-waldo-2-brief]] still apply (approval before build, "push it" before live).
Open questions sent: Mike/Kenny emails; does partial = leftover goes back on the next route; what "future" means with same-day dispatch; speed limit + who is alerted; does lunch pause new stops; Buddy Bear = customer receiving window or priority boost; Dane/Milutin = viewers or drivers; does the truck have its own driver.
See [[project-status]], [[waiting-on-user]], [[same-day-dispatch]].

**2026-11-19 Ashe said "build it"** (questions unanswered → I use sensible defaults and list them). Local/worktree build only; LIVE push still needs "push it"; real users (Mike/Kenny/Dane/Milutin) need emails + OK.

**2026-11-19 BUILT: commit c2d0044 on branch work/next-fixes (worktree). NOT merged into master, NOT live.**
- Migrations: 20261119000014_future_status.sql (enum 'future') + 20261119000015_demo_feedback.sql.
- Defaults I chose (Ashe didn't answer the questions; they can change any of these):
  - Partial pick up: the rest becomes a new "REST OF <TN>" request on the same driver's NEXT workday route (pickups only). The original shows "Partial Pick Up".
  - Future: only admins can create and see these. pg_cron runs release_future_requests hourly and releases each one on its day. The release skips the app's auto-arrange; Start shift re-plans.
  - Ready time = time-of-day window start (requests.daily_window_start). A trigger aims window_start/end at the route day and follows moves.
  - Buddy Bear: setting priority_customers = [{match, start 07:00, end 10:00, priority urgent}], matched when the pickup/drop-off location name contains the text. Editable in Admin → Settings. Requests submitted after 10 AM go to the next workday.
  - Speeding: setting speed_alert_mph = 75. Admin + dispatch get an alert when 2+ GPS fixes are over the limit within 3 min, max 1 per 15 min. Stored in table speed_alerts; shown on a dashboard card.
  - Lunch: driver_breaks + driver_punch_out/in. End shift closes an open lunch. Map and dashboard show 🍔.
  - Vehicles: admin_save_vehicle. driver_set_vehicle lets the driver pick Tahoe/Truck, kept as their default.
  - Dane/Milutin = "manager" role (view-only: map, routes, requests, reports). The map got live refresh, vehicle names and per-route colours.
- Tests 92/92; web tsc, eslint and next build OK. Root `npm run typecheck` fails in this worktree on packages/database (missing @types/node). This is an existing environment issue, not caused by this change.
- Next:
  1. Ashe says "push it" → push 0014 + 0015 live → merge to master → restart 3010 → click-through.
  2. Create the real accounts (need emails): Mike = admin, Kenny = driver, Dane + Milutin = manager.
  3. Add the Tahoe + Truck in Settings.

**2026-11-19 NEW ASK:** "Let speed limit be determined by the location they are at" (posted road limit instead of the flat 75 mph). Proposed: look up the road limit from GPS (free OpenStreetMap, or HERE/TomTom with an API key, free tier + spending cap); alert at limit + 10 mph; fall back to road-type defaults / 75 if no data. Ashe: "+10 is fine and you can build it" (no provider named → used my pick, OSM).
**BUILT commit 8dff313 (work/next-fixes, NOT live):**
- Migration 0016: gps_events gets speed_limit_mph/source/road_name; road_speed_tiles cache; set_fix_speed_limits (service_role only).
- Settings: speed_alerts_enabled, speed_alert_over_mph=10, speed_alert_mph is now the "unknown road" limit (75 → 65).
- apps/web/src/lib/speed-limits.ts: Overpass (3 public servers), 500 m tiles, nearest road + heading match, US road-type defaults.
- Driver phone calls checkSpeedLimitsAction after fast batches; Bouncie runs it after() the reply.
- Tests 93/93; tsc/lint/build OK. Real check: Kennedy Expressway = 55 mph (osm).
- CAVEAT: public Overpass was very slow/502 on 2026-11-19, so lookups may fail → falls back to 65+10. For reliability later: HERE/TomTom key or our own Overpass (set OVERPASS_URL). Untagged urban main roads get generous defaults (e.g. primary 55), so alerts may be missed but won't be false.
