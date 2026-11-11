---
name: av-waldo
description: "AV-WALDO — AVW dispatch/GPS/route/POD platform for driver Kenny; folder created 2026-11-11, no code yet"
metadata:
  node_type: memory
  type: project
  originSessionId: 412178c6-0093-45c3-b425-6e18f207d3ca
  modified: 2026-11-11T19:44:10.467Z
---

AV-WALDO = AVW internal logistics app (track: AVW, see [[two-tracks-ashe-avw]]). Replaces the paper PO/invoice box: employees submit pickup/delivery requests, dispatch assigns/routes, driver Kenny uses a mobile app (GPS, proof of delivery, offline, WALDO Voice). Future JobBOSS + QuickBooks Desktop integration (read-only first, never required for launch).

Key rules from Ashe's master prompt: NO geographic radius anywhere; NO Microsoft/Entra login (Supabase Auth, invite-only); request ≠ stop (one stop can hold many POs); pickup-before-delivery; dispatcher approves route changes; no fake tracking/optimization — label simulation modes.

Proposed stack: Next.js on Vercel (web), Expo React Native (mobile), Supabase Postgres, Google Maps Platform, monorepo apps/web, apps/mobile, packages/*.

Status 2026-11-11: empty folder created at C:\Users\ashe\projects\AV-Waldo. Ashe will work from there. Master prompt was pasted in chat (not saved to disk yet).

**Why:** Ashe requires approval before any task; only folder creation was approved.
**How to apply:** Next session in that folder — start with Phase 0 (critical assessment, ERD, MVP scope) and get approval before scaffolding code. Keep git identity rules from [[git-identity-leak]]; repo private per [[github-buildup]].
