---
name: git-identity-leak
description: "Ashe's rule: git must NEVER expose the AVW work email (or yahoo on public repos); useConfigOnly=true; noreply on public repos; check author email BEFORE every push"
metadata:
  node_type: memory
  type: feedback
  originSessionId: ae547534-d280-4b97-a9c7-4949f2251bdb
  modified: 2026-10-19T19:11:10.340Z
---

Ashe (2026-10-16): "never ever should it guess my avwequipment email and make it public." Root cause: no global git identity, so git auto-built `ashe@avwequipment.com`; it leaked into public commits on ashe-sule/ashe-sule and Ilashe/ashe-portfolio (cleaned 2026-10-19 by history rewrite; PR #1 on ashe-portfolio still holds old refs until GitHub Support purges them).

2026-10-19 incident: the global user.email had become `sule.ashe@yahoo.com`, and ashe-portfolio had no local email, so one commit went to the PUBLIC repo with the yahoo address. Fixed within a minute (amend + force-push to noreply). Global email was then switched to noreply (told Ashe; he can ask to revert).

**Why:** Ashe never wants an email on public sites/repos ([[github-buildup]]); yahoo is OK only in private repos.
**How to apply:**
- Global `user.useConfigOnly=true` must stay. Global email is now the noreply address.
- Public repos (Ilashe/ashe-portfolio, ashe-sule/ashe-sule): repo-local `user.email "178430674+ashe-sule@users.noreply.github.com"`.
- BEFORE every commit to a public repo: run `git config user.email` and confirm noreply. Before every push: `git log --format='%ae %ce' | sort -u` must show no avwequipment or yahoo.
- Don't change the global user.email again without asking.
