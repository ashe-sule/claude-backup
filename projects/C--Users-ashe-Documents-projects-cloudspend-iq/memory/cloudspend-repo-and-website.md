---
name: cloudspend-repo-and-website
description: "CloudSpend IQ GitHub repo, branch-per-phase workflow, and Ashe's decision to keep it off ashesule.com until all 5 phases are done"
metadata:
  node_type: memory
  type: project
  originSessionId: e554eb49-ef55-4100-8f63-c3cf14563fe0
  modified: 2026-10-27T21:39:09.524Z
---

CloudSpend IQ pushes to the PRIVATE repo https://github.com/ashe-sule/cloudspendiq (remote `origin`). Each phase is its own branch (phase-1-foundation, phase-2-analytics, ...); none are merged into `main` yet and no PRs exist (gh CLI is not installed on this PC).

POSTED 2026-10-28: Ashe approved and the CloudSpend IQ card + page went to ashesule.com (Ilashe/ashe-portfolio main, commit e9de557; /projects/cloudspend-iq/, 7 screenshots of fake Northstar data, "private preview, request a demo on LinkedIn" since the app is not deployed). When a live demo exists, add its link to that page (needs Ashe's OK).

History: on 2026-10-27 Ashe chose "Wait until finished" for ashesule.com: do NOT add CloudSpend IQ to the portfolio site (repo Ilashe/ashe-portfolio) until all 5 phases are complete, then show screenshots of fake Northstar data and get Ashe's approval before pushing the site.

**Why:** Ashe's rules: finished work only on the website, all repos private.
**How to apply:** after each phase, push the phase branch; only raise the website update once Phase 5 is done. Related: [[cloudspend-phase-status]]
