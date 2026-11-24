---
name: qb-unattended-setup
description: "How quotes from the quoting tool reach QB without users having QB open — QB PC setup, QBSync user, single vs multi-user, Windows login rule"
metadata:
  node_type: memory
  type: project
  originSessionId: 1807a341-985e-428f-a4b2-1f66acf721e7
  modified: 2026-11-11T17:54:29.677Z
---

Decided/explained 2026-11-11 (for future quoting-tool auto-send, see [[project-status]]):

- Users never need QB/QBWC; they only use the quoting tool. Quote → Neon queue → QBWC on the ONE QB PC polls → QB.
- One-time: Admin + single-user mode to authorize the app (re-run .qwc, "Yes, always", auto-login as dedicated QB user `QBSync`). Then switch back to multi-user.
- Daily: works in multi-user mode while staff (incl. Admin) work in QB. QB need not be open (QBWC launches it unattended).
- App must NOT log in as Admin (QB user can only be logged in once → collisions). Use `QBSync`.
- Switching QB users = fine (permission lives in company file). Signing out of Windows = sync stops (QBWC runs in the Windows session; its app list is per Windows user). Lock screen is fine.
- Anyone opening the file in single-user mode blocks QBWC until they switch back.
- Blocker before go-live: QBWC points at localhost:3000 (npm run dev). Need Windows service on QB PC, or Cloudflare Tunnel/custom domain to Vercel. Best: always-on dedicated machine/VM.

Full copy-ready summary saved at `docs/QUOTING-TOOL-QB-SETUP.md` in the qb-sync repo (2026-11-11, committed addf4e7 on main, not pushed).

**Why:** Ashe wants to know configuration for when the quoting-tool → QB project starts.
**How to apply:** reuse when planning quoting-tool auto-send or QB PC setup.
