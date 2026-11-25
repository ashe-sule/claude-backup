---
name: avw-thanksgiving-banner
description: "Thanksgiving 2026 greeting LIVE on Internal Hub (raffle drum) + Visitors kiosk (leaves flash), Nov 25–27 only; deployed 2026-11-24"
metadata:
  node_type: memory
  type: project
  originSessionId: 0c9187f0-634a-4c5c-b31e-c4993f63aa28
  modified: 2026-11-25T15:26:32.351Z
---

**Status: DEPLOYED 2026-11-24 (evening), verified live.** Shows Wed 2026-11-25 to Fri 2026-11-27 (viewer's local date, re-checked every minute), hidden otherwise. Preview any day with `?tg-preview=1`.

- **Internal Hub** (repo avw-internal-request-hub → Vercel project **avwforms**, https://avwforms.vercel.app, team-ashe): commit 93b9ae6 pushed to origin/main. Brass raffle drum cranked, sprays gift cards ~5s, then banner "Happy Thanksgiving from AVW Equipment Co. / Thank you to everyone who joined today's raffle, and congratulations to our winners!" docks under header and stays. Public pages only (not /portal). Note: local branch is `fix/npr-category-101` tracking origin/main; local `main` is stale/diverged — push with `git push origin HEAD:main`.
- **Visitors kiosk** (visitors-tracking-system, Vercel auto-deploy on main): commit ea72142. Autumn-leaves "Happy Thanksgiving! Thank you for visiting AVW Equipment Co." card flashes every 3s on idle /kiosk welcome screen; check-in/out are separate pages so it never shows during check-in. Push also carried Ashe's own unpushed commit 07edcc3 (kiosk-app package-lock sync). `/admin/monthly` + AdminShell.tsx left uncommitted (not touched).
- Component: `src/components/ThanksgivingGreeting.tsx` (same file in both repos; modes raffle | banner | kiosk; dates START/END constants). Safe to delete after Nov 27.
- History: turkey design rejected → Ashe chose raffle theme (AVW held a raffle 2026-11-24); first drum looked like a ship's wheel ("worst raffle draw ever"), redrawn as real brass hex cage. Visitors uses leaves because visitors weren't at the raffle (Ashe didn't object). Other internal apps (label printer, invoice gen, PNR, etc.): Ashe chose NOT to do them this time.
- Design canvas (private): https://claude.ai/artifact/VsyoV9zgW2ZGewYq3L4D7w
- Vercel MCP lacks team-ashe access (403); use `vercel` CLI with `--scope team_PjDxl7Ca8atAvPwHgPadeXVi`.

- **Round 2 (same evening, Ashe: "say hi to most of them"):** raffle `banner` mode (stays at top, no spin) added + deployed + live-checked on: Invoice Generator (e4decba; rebased onto 2 remote Caps-Lock commits from Nov 1 that weren't pulled locally), PNR kiosk (a4929e3, carried Ashe's unpushed brief commit), Marketing Workspace (8e868cc, after-login pages only), Electrical Schedule equipmentx repo (cc181b4 → both Vercel projects avw-electrical-schedule + -v2). Banner hidden in print. Skipped: Label Printer (Electron desktop), Ship Label (not deployed), Quoting Tool, QB Sync (no UI), Site Analysis (PUBLIC customer tool), customer/distributor apps, request forms not cloned locally (vendorrequestform, po-form-request, customerform, partnumber, tiles, vacuum).
- Found: Next.js build sometimes throws SecurityFatalError (known vuln) on invoice-generator/pnr — Vercel built fine; Next upgrade recommended. Electrical Schedule shows a pre-existing "Needs attention: Request failed" box on its home page (not caused by banner).

- **Round 3 (2026-11-25):** SO Label Printer v1.4.2 = banner mode added in renderer/src/main.tsx (component in renderer/src/components), screenshot-checked locally, published signed to \\v-server\Temp\AVW SO Label Generator (latest.json = 1.4.2), commit 9e6e17f pushed. Shop users get "Update available → Install now". Rollback = republish 1.4.1 setup with a higher version number.

**SCHEDULED (2026-11-25):** Windows Task Scheduler task "AVW - Remove Thanksgiving banners" runs Mon 2026-11-30 07:00 on Ashe's new PC: C:\Users\ashe\Documents\scheduled-tasks\Remove-Thanksgiving.ps1 — fresh clones in %TEMP%, `git revert` of each banner commit, grep-verify, push main with correct author email; skips on any problem; log + balloon note in that folder. Dry run 2026-11-25: all 6 OK. Cloud routine was tried first but failed (Claude GitHub app lacks repo access). After it runs: check the log, check sites, then only SO Label Printer remains (remove in its next real release). Local project clones will be behind origin afterwards (pull before next work).

(Original to-do:) remove the Thanksgiving code from ALL 7 apps** — Hub (AppChrome.tsx + component; also discard uncommitted print-rule tweak), Visitors (KioskHome.tsx + component + CLAUDE.md note), Invoice Gen (layout.tsx), PNR (layout.tsx + src/app/ThanksgivingGreeting.tsx), Marketing WS ((app)/layout.tsx), Electrical equipmentx (frontend/src/main.tsx), SO Label Printer (renderer/src/main.tsx; ship removal inside the next real release, not its own update, unless Ashe says otherwise). Banners already self-hide after Nov 27, so this is cleanup, not urgent. Each push needs Ashe's go.

**Open / next:** kiosk tablet must reload once (reopen the kiosk app) to pick up the new code before Wed morning; optional cleanup commit removing the component after Nov 27. See [[avw-quoting-tool]] (left out on purpose).
