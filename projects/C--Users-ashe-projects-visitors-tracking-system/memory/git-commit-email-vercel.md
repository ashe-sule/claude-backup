---
name: git-commit-email-vercel
description: Commit as sule.ashe@yahoo.com (the GitHub account email) — Vercel blocks deploys of commits authored by ashe@avwequipment.com
metadata:
  node_type: memory
  type: feedback
  originSessionId: d107da63-83d8-4836-9697-c19ea4e52886
  modified: 2026-10-18T17:17:38.073Z
---

Commit with the identity in the global git config (Ashe Sule <sule.ashe@yahoo.com>). Never override the author with `-c user.email=ashe@avwequipment.com` or any other email.

**Why:** 2026-10-18, avw-site-analysis: two commits authored as ashe@avwequipment.com were pushed but Vercel never deployed them ("can not be redeployed"). Vercel flagged a git config mismatch between the commit email and the GitHub account email. Ashe's own commit as sule.ashe@yahoo.com deployed straight away.

**How to apply:** If git says "Author identity unknown", stop and ask Ashe to set the global config. Don't invent an identity. After a push, check that Vercel actually deployed (live chunk changed), not just that the push succeeded.
