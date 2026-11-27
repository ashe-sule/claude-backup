---
name: portfolio-audit-2026-11-27
description: "Read-only security/correctness audit of all projects (2026-11-27); 47 findings F-001..F-047 + investigations I-001..I-005; awaiting Ashe's approvals, nothing changed"
metadata:
  node_type: memory
  type: project
  originSessionId: 4fe1f402-5cc9-44bd-b700-211bdaea2522
  modified: 2026-11-27T16:58:23.483Z
---

Read-only audit of C:\Users\ashe\Documents\projects done 2026-11-27. No code changed. Full report was written to session scratchpad (temporary): portfolio-audit-2026-11-27.md — if gone, the key points are below.

P0 (lead-verified in source):
- F-001 quoting tool: `profiles_update_own` (0001_init.sql:25) lets any user set role=admin; handle_new_user trusts metadata role.
- F-002 request hub: same self-admin bug (0001:286) + signup metadata role=admin (0002:48).
- F-003 AV-Waldo: helper SECURITY DEFINER fns revoked only from public/anon (0003_rpc.sql:748) → authenticated can call _try_status etc.
- F-004 electrical v2: current_user() always admin, no auth on API incl DELETE.
- F-005 electrical: SPA catch-all path traversal; launcher binds 0.0.0.0.
- F-006/F-007 qb-sync: QBWC ticket never checked; no UI auth. F-008 duplicate QB estimate race.
Owner actions flagged: rotate ICC .env.dev QBWC+JobBOSS passwords (values entered transcript), rotate Neon URL (pasted Sep 22), Vercel Deployment Protection, Anthropic/Google spend caps, Supabase signup OFF.

**Why:** Ashe requested approval-gated repairs; nothing may change without named-ID approval.
**How to apply:** On resume, ask which F-/I- IDs are approved; commits/pushes/migrations/deploys need separate explicit OK. Related: [[avw-quoting-tool]], [[av-waldo]], [[production-board-gabi]].
