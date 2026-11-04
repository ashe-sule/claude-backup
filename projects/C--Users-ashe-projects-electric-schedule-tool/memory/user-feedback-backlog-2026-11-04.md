---
name: user-feedback-backlog-2026-11-04
description: "Pending end-user feedback list for the Electrical Schedule Generator (data fixes + Copy/multi-select/uppercase features), discussed 2026-11-04, not started yet"
metadata:
  node_type: memory
  type: project
  originSessionId: 9a117213-341a-454c-8d90-eb2d1a74c075
  modified: 2026-11-04T16:55:44.375Z
---

On 2026-11-04 Ashe shared end-user feedback and asked to save it to continue later. NOTHING has been implemented yet — get Ashe's approval before starting.

**Data fixes (MASTER_LIST Google Sheet; main rows, sub-components are rows whose description starts with "-"):**
- CPU3 → add child: 1× 7.5HP motor (M7.5)
- PO1-EL → 3× M1.5 motors
- OT2-PO1-EL → 3× M1.5 motors
- SOB-RO-10GPM → 1 HP, 3 PH, 460 V, 4.8 A
- SOB-PSR15 → 5 HP, 3 PH, 460 V, 7.6 A
- Air control panel solenoids → current 0.25 A
- Exclude from schedule: CN1D-150-36-SPC (floods schedule when qty is in the 100s), VAC-CUFFSWIVEL-150HX150T, VAC-HOSE-150-50-BK, VA5129AV, VA5129CAP500-SS, VA3352WS

**Feature requests (code):**
- "Copy" button next to the existing "Move" button (copy parent or child rows)
- Multi-select rows (Shift/Ctrl-click, Ctrl+A style) instead of clicking each line
- Force all descriptions to UPPER CASE for consistency

**Open questions still to ask Ashe:**
- VAC/VA list wording was contradictory ("Remove… these PNs necessary needs to be there") — my read: they are NOT needed; confirm.
- This repo has NO Move button / row editing UI (GeneratedSchedule.tsx only has Download + Reset). Users may be on a newer version elsewhere — confirm which codebase/deployment, or Move/edit must be built first.
- Recommended: add the excluded PNs to the EXCLUSIONS sheet tab instead of deleting from master list (reversible). Need sheet edit access or Ashe edits it.
- How are child quantities (e.g. "3× M1.5") represented in the sheet — repeated rows or a qty column? Check before editing.

**Planned fix approach:** sheet edits for data; uppercase via `.toUpperCase()` on descriptions in scheduleGenerator/excelWriter; Copy + multi-select in the schedule editing UI once its location is confirmed.
