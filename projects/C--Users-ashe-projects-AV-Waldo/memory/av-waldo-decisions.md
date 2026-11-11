---
name: av-waldo-decisions
description: Key AV-WALDO tech decisions the user approved on 2026-11-11
metadata:
  type: project
---
- Database: "Build first, connect later" — no Docker on user's PC, no Supabase project yet. Code + SQL migrations written now; connect a Supabase cloud project later.
- Maps/routing: Google Maps Platform (Geocoding, Routes, Route Optimization). Until keys exist, use a clearly labeled SIMULATION mode. Add spending cap at launch.
- First session scope: Phase 0 docs + web Command Center vertical slice; mobile (Expo) next session.
- No pnpm/Docker on machine; Node 24 + npm 11 + git available.

**Why:** user chose these via question prompt. **How to apply:** don't push Docker/local DB; keep sim mode labeled; ask before adding paid services. Related: [[project-status]]
