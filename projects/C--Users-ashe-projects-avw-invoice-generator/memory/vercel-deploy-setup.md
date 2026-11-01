---
name: vercel-deploy-setup
description: How avw-invoice-generator reaches production on Vercel (git-connected since 2026-10-30; earlier deploys were manual CLI)
metadata:
  node_type: memory
  type: project
  originSessionId: fc04df56-96dd-4d90-834b-dfaffff918f0
  modified: 2026-10-30T19:17:31.994Z
---

Live site https://avw-invoice-generator.vercel.app (Vercel team "team-ashe", project avw-invoice-generator). GitHub repo ashe-sule/invoicegenerator (private) was connected to Vercel on 2026-10-30; before that, pushes did NOT deploy and the site only updated via manual `vercel deploy --prod` from Ashe's PC.

**Why:** A fix was pushed but users still saw the old build until a manual deploy was run.

**How to apply:** Pushing to `main` now goes live straight away, so get Ashe's OK before pushing. If a push doesn't appear live, check the Git connection first. Claude Code blocks Claude from running prod deploys itself, so for a manual deploy Ashe runs `! npx vercel deploy --prod --yes`.
