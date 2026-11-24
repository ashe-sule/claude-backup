---
name: cloudspend-phase-status
description: "Where CloudSpend IQ stands - all 5 phases coded 2026-10-28 (phase-5-production, 903ed45); deploy waits on Ashe's accounts; AI key decision"
metadata:
  node_type: memory
  type: project
  originSessionId: e554eb49-ef55-4100-8f63-c3cf14563fe0
  modified: 2026-10-28T19:20:17.139Z
---

As of 2026-10-28: all 5 phases are coded and pushed. Phase 5 (accounts + roles + 24h demo sandbox, rate limits, alerts, analytics, backup/restore, legal + contact pages, DEPLOYMENT/LAUNCH-CHECKLIST/CASE-STUDY docs) is commit 903ed45 on branch phase-5-production (chained from phase-4-reports). Nothing is merged to main and nothing is deployed.

Waiting on Ashe (see docs/LAUNCH-CHECKLIST.md): Vercel + Neon + Resend accounts, email DNS (SPF/DKIM/DMARC), APP_URL, CRON_SECRET, Anthropic and Vercel spend caps, approval of /privacy and /terms, enabling Vercel Analytics, a Teams alert webhook, Neon PITR + restore drill, a real-inbox smoke test. Then re-verify the 20-item checklist on the live site.

AI Analyst is OFF until Ashe sets ANTHROPIC_API_KEY; it has never been run against the real model. Before enabling: Ashe sets a Claude Console spend limit and approves spend for an answer-quality check.

**Why:** Ashe asked to build phase by phase and only publish when finished.
**How to apply:** next steps are the deploy (with Ashe's accounts), then the merge to main and the ashesule.com update, each needing Ashe's approval. E2E must run with servers stopped (PGlite is single-process); playwright uses 3 workers. Don't call the real Claude API without approval. See [[cloudspend-repo-and-website]].
