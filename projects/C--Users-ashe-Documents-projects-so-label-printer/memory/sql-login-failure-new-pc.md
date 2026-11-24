---
name: sql-login-failure-new-pc
description: 2026-11-11 new PC "SQL login failed" — FIXED (wrong username + password reset); Ashe_SQL_RO verified read-only on whole live DB; follow-ups open
metadata:
  node_type: memory
  type: project
  originSessionId: eba15c7b-d85b-4426-a857-0c01be3ea628
  modified: 2026-11-11T16:32:49.327Z
---

## Status: FIXED 2026-11-11, with follow-ups still open

**Problem:** On a new PC the label app said "SQL login failed". Retyping the username and password didn't help, but the app worked on other PCs.

**How we found it:**
- In SSMS on V-JOBBOSS itself with the SQL login: error 233 "No process is on the other end of the pipe".
- `SERVERPROPERTY('IsIntegratedSecurityOnly')` = 0, so mixed mode is on and wasn't the cause.
- Error log: `Login failed for user 'Ashe'. Reason: Could not find a login matching the name provided. [CLIENT: 192.168.1.193]`, which is the new PC.
- The real SQL login is **Ashe_SQL_RO**. "Ashe" was typed in by mistake.
- I wrongly suspected the connection limit at first, because the first log paste was incomplete.

**Fix:** The user reset Ashe_SQL_RO's password in SSMS. The new PC now connects.

**Permission check** (run as AVW\Admin, using EXECUTE AS LOGIN = 'Ashe_SQL_RO' on live):
- 268 of 268 tables readable, 0 insert / update / delete, not sysadmin.
- So it's read-only on the whole JobBOSS DB, which is what the user wanted (whole DB, not one table).
- Stored-procedure EXECUTE rights weren't checked yet (optional; query given, waiting on a result).

**Code facts:**
- electron/sql.ts only runs SELECTs; the app never writes to JobBOSS.
- Each PC's settings.json keeps the password encrypted with DPAPI and locked to that Windows user on that PC. It can't be recovered, and SQL only stores a hash.

**Open to-dos:**
1. Type the new Ashe_SQL_RO password into Settings on every other PC (the reset breaks them until updated).
2. Optional: run the stored-procedure EXECUTE check (0 = fully read-only).
3. Proposed v1.4.2, not approved yet: in electron/main.ts friendly(), /Login failed/ matches before /Cannot open database/, so a wrong DB name or missing login shows as "SQL login failed". Show the real reason, and trim stray spaces off the password.
4. Security: Lantek software (client 192.168.1.179) signs in as **sa** to the missing DB 'Lantek360Edge'. Give it its own limited login.
5. Ideas discussed, not decided: a dedicated `SOLabelPrinter` login with SELECT on the ship-label table only (the user went with resetting the existing login instead). Windows / AD-group sign-in for v1.5 so PCs hold no passwords.

**Why:** The user wants the full history kept so the next session can pick up where we stopped.
**How to apply:** Next session, start from the open to-dos. Don't change the app or the server without the user's OK.

Related: [[v1-4-0-open-items]], [[publish-means-update-share]]
