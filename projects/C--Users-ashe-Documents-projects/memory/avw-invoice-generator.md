---
name: avw-invoice-generator
description: "AVW Invoice Generator — Publisher commercial-invoice replacement, live on Vercel; paused 2026-10-19, upgrades later"
metadata:
  node_type: memory
  type: project
  originSessionId: 400fff45-aa97-43c6-91ad-b0f0631f9e18
  modified: 2026-10-19T23:38:04.001Z
---

Replaces the retired MS Publisher commercial-invoice template used by AVW's shipping coordinator. Built and deployed 2026-10-19 (AVW track, see [[two-tracks-ashe-avw]]).

- Local: `C:\Users\ashe\Documents\projects\avw-invoice-generator`; GitHub private `ashe-sule/invoicegenerator` (noreply identity, see [[git-identity-leak]])
- Live: https://avw-invoice-generator.vercel.app (Vercel Team Ashe); Neon Postgres free plan via Vercel Marketplace
- Stack: Next.js 16 (proxy.ts), react-pdf template measured from originals, single admin login (bcrypt in DB, jose cookie)
- Source samples: `OneDrive - AVW Equipment Company Inc\Shipping - Documents\International Shippments\*.pub/.pdf`
- Gotchas: Carlito font needs ligatures off (else "Destnaton" in PDF text); Vercel CLI re-appends `.env*` to .gitignore (breaks `!.env.example`); Neon integration drops `.agents/`, `.claude/`, `skills-lock.json` (gitignored); bash heredocs here can eat backslashes, so use Write tool for code with regex

**Why:** Ashe paused on 2026-10-19 ("fine for now") and will do upgrades/features later.
**How to apply:** When resuming, start from `ROADMAP.md` in the repo (owner to-dos, checklist gaps #3/#9/#10/#13/#17, feature ideas). Get approval before starting any item.
