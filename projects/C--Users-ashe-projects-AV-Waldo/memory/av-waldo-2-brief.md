---
name: av-waldo-2-brief
description: "2026-11-17 \"AV-WALDO 2.0\" brief — strict approval rules (no repo inspection/tests/code/deploy without OK), 4-phase tracking roadmap; proposal given, awaiting approval"
metadata:
  node_type: memory
  type: project
  originSessionId: 610a01c2-2500-4004-9e2e-4fd480c31f38
  modified: 2026-11-17T20:45:35.075Z
---

2026-11-17: Ashe pasted the "AV-WALDO 2.0 — Intelligent Driver, Dispatch & Order Tracking" brief. Goal: answer "Where is Kenny, where is our material, what happened to this PO?"

Stricter rules from the brief (they override earlier habits):
- No task without approval, and that includes repo inspection, running tests, code changes, deploys and server restarts.
- Approving a plan is not approval to implement. Approving implementation is not approval to push LIVE: that needs the words "push it".
- No live data or user changes without OK. No deploy, env var or external service changes without OK.
- Port 3010 is reserved for AV-WALDO. Ports 3000 and 3123 belong to other apps.
- Before each change, explain what will change, why, the risk and the benefit.

My first reply was a review + plan only. Recommended order:
- Step 0: read-only repo check.
- Phase 1 (tracking reliability):
  - deploy over https + Sentry
  - GPS freshness states
  - feasibility policy, so routes like the 13.8 h one aren't auto-published
  - request timeline + PO search
  - photo rule enforced in the database
- Phase 2: command center, live ETAs, proactive exceptions, employee tracking.
- Phase 3: delivery proof, "in the van now" view, partial/discrepancy handling.
- Phase 4: daily email, integrations, tracker hardware, offline queue.

Open decisions for Ashe: feasibility policy, hard vs soft time windows, delivery proof minimum, GPS approach (web now, decide on a tracker after 2 weeks of freshness data), what employees can see, planning start time, GPS retention. See [[project-status]], [[waiting-on-user]], [[todo-daily-pickup-report]].

**Ashe's decisions (2026-11-17):**
- JobBOSS + QuickBooks import DROPPED. Don't propose ERP/accounting integration again.
- Vehicle tracker hardware is OK in principle, as long as it reports into AV-WALDO so we can see where the driver is. The phone GPS becomes the backup.
- This is NOT approval to buy hardware or build anything. Next step is to compare trackers by: open API or webhook, update interval, ignition events, OBD vs hardwired, privacy controls, monthly cost.
- The integration needs the https deploy (webhook endpoint) or a cron poll.

**2026-11-17 "Lets start" = OK for Step 0 (read-only check) + tracker research. Both are DONE.**

Step 0 findings:
- Already in place:
  - gps_events.source already allows 'vehicle_tracker'
  - wake lock + heartbeat in location-sharing.tsx
  - client_event_id dedupe
  - map stale marker
  - signed photo URLs (10–60 min)
  - RLS everywhere
- Gaps:
  - photo rule only in the app layer (completeStopAction), not in the driver_complete_stop RPC
  - delivery proof is optional
  - GPS permission-denied isn't reported to dispatch
  - stops.planned_eta is never written
  - no rate limiting
  - no exception severity / auto exceptions
  - route only goes in_progress on first arrival
  - proofs use device time

Tracker research:
- Top pick: Bouncie. OBD, about $90 hardware, roughly $8–10/mo (not confirmed), no contract, REST + webhooks, every 15 s while driving, nothing while parked.
- Runner-up: Teltonika + self-hosted Traccar (some models are end-of-life).
- Enterprise options (Samsara/Motive/Geotab/Verizon) are quote-only and multi-year: overkill.
- Rejected: LandAirSea, Spytec (no API), Zubie (gone), Linxup (gated API).
- Before buying, verify: Bouncie's monthly price, commercial/business-use API terms, rate limits.

**2026-11-17 "Proceed and build" = Phase 1 build APPROVED (local/worktree only; LIVE push still needs "push it"; no deploy yet).**

Decisions:
- **D1 = auto-move + flag.**
  - Non-urgent stops with no time window that don't fit (over max_route_hours or missing a window) → automatically go to the next workday, and the requester is told.
  - Urgent or time-window stops stay on today and are flagged for dispatch.
  - A started route is never changed silently.
- **D3 delivery proof** (Ashe's words): "The recipient name should show and then a photo should be asked for when clicking completed".
  - Meaning: the recipient-name field is visible (pre-filled if we know it), then tapping Complete asks for a photo.
  - Both are required unless the outcome is failed.
- **Deploy:** build first, deploy later. Waiting on GitHub/Vercel sign-in.
- **Tracker:** Bouncie recommended. Ashe buys it after checking price, business-use terms and rate limits. The integration code stays switched off until it's configured.
