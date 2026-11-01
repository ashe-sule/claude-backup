---
name: hebron-project-status
description: "Hebron Consults site — where it's hosted, who the owner is, and the agreed 8-step launch plan"
metadata:
  node_type: memory
  type: project
  originSessionId: 8a0f6583-3c1f-4163-aacb-e371f1a14a73
  modified: 2026-10-21T00:21:04.166Z
---

Hebron Consults LLC website, built for owner Chinonso Olufemi Umeanor (Army Reserve, VOSB in progress). Source content: ~/Downloads/4_Capability_Statement_Hebron_Consults_LLC.docx.pdf.pdf.

- Vercel: team **team-ashe** (Pro, chosen 2026-10-20 because Hobby bans commercial use), project `hebron-consults`, URL https://hebron-consults.vercel.app (noindex until NEXT_PUBLIC_SITE_LIVE=true)
- GitHub: https://github.com/ashe-sule/hebron-consults (private, branch `main`), connected to Vercel for auto-deploys as of 2026-10-20. gh CLI not installed — user creates repos on github.com
- Steps 1–2 done 2026-10-20; step 3 (user emails owner) is with the user — wait for them to say they're ready
- Launch-checklist pre-work done 2026-10-20: Vercel Firewall rule "Contact form rate limit" (5 per IP per 10 min, verified), Vercel Analytics + Speed Insights, global-error page. Lighthouse mobile scored 92–98 (local runs need --throttling.cpuSlowdownMultiplier=1.5; this PC's benchmark is low)
- Agreed plan (2026-10-20): 1 GitHub → 2 Vercel preview → 3 email owner → 4 owner answers → 5 domain + M365 email → 6 Resend wiring → 7 20-item launch checklist → 8 go live

- Brand (requested 2026-10-20): colors blue+gray, army green+gold, black+red; logo tied to Hebron meaning. Shipped to production 2026-10-20 (shield + pillar "H" + Army chevron + red star). Preview URLs need Vercel login (302)

- Session closed 2026-10-20, all work pushed (main @ 23b5acb). Waiting on user: (a) Chinonso's answers to review email (phone, email, address, logo, headshot, name OK, NAICS 334118 vs 423430, TX security licensing, 1-business-day promise, legal review, domain); (b) Vercel spend cap, enable Analytics/Speed Insights, pick error alerts (Sentry recommended). Then steps 5–8

**Why:** user wants to follow along step by step and be told only when they're needed.
**How to apply:** resume from the next unfinished step; flag "🙋 You" items clearly.
- 2026-10-20: user's own skills (from ~/projects/ashe-portfolio, i.e. ashesule.com) folded into IT Services + Network cards, all vendor-neutral by user request (no brand names like Cisco/Microsoft/HubSpot). User's personal certs (CISSP etc.) and NexuCentri projects deliberately NOT added under Hebron until user is formally on the team
- 2026-10-20: Unsplash stock photos shipped on all 6 service cards/pages (credits in README; free-license check = download endpoint 302 vs 403 for Unsplash+). Live home LCP 2.5–2.7s after photos. Swap for Chinonso's real job photos later
