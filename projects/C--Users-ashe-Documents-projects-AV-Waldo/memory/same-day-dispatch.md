---
name: same-day-dispatch
description: 2026-11-13 decision — requests are same-day only; no dispatch queue; auto-add to driver's route, auto-publish
metadata:
  type: project
---
Ashe (2026-11-13): "we dont need the dispatcher queue as this is only uploaded for the day there is no set up for future pickups or drop offs."
Decisions (chosen via question prompt):
- On submit, the request is added straight to the driver's (Kenny's) route for TODAY and the system picks the best spot. No dispatcher step. Remove the Dispatch queue page.
- Late request (after the cutoff, default 3 PM; or the driver has ended his shift; or a weekend) → goes on the next workday's route automatically, and the requester is told.
- Routes publish automatically, with no Publish button. Kenny sees new stops right away. If he's already driving, big re-orders still go through dispatch approval ([[todo-auto-optimize]]).
**Why:** AVW only books same-day trips. A queue is a wasted step.
**How to apply:** Don't build future-date scheduling UI. Keep the driver's view simple ([[driver-view-simple]]). Manual reassign stays only as a fallback for failed or rescheduled requests.
