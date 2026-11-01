---
name: network-sonicwall-blocks-ashesule
description: The PC's network SonicWALL firewall blocks ashesule.com (TLS reset, HTTP 403 block page), so live checks from this machine fail
metadata:
  type: reference
---

From Ashe's PC, ashesule.com (and www) fails: HTTPS connections are reset and HTTP returns a "SonicWALL - Web Site Blocked" page. Google and vercel.com load fine. WebFetch also gets ECONNRESET. Seen 2026-10-28.

**Why:** a local network content filter, not a site outage.
**How to apply:** don't diagnose the site as down. Ask Ashe to check on a phone using mobile data, or to allow the domain in SonicWALL. Related: [[cloudspend-repo-and-website]]
