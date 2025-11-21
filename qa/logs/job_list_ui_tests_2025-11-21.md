# Job List UI Tests — 2025-11-21

- **Owner:** Copilot
- **Scope:** Phase 1-3 §1.3 (Build Job List Screen)
- **Command:** `cd field_app_client && /workspaces/SM_App/flutter/bin/flutter test`
- **Result:** Pass (38 tests)

| Scenario | Method | Evidence |
| --- | --- | --- |
| Job buckets render Today/This Week/Last Week order | `job_list_controller_test.dart` covers the bucketing logic that the UI consumes, ensuring jobs fall into exactly one section with chronological sorting. | `test/modules/jobs/job_list_controller_test.dart` → `categorizes rows into the correct buckets`. |
| Crew parsing displayed in chips | Same test verifies crew JSON parsing before the UI renders chips, ensuring watchers handle malformed payloads safely. | Same file → `parses crew names safely`. |
| Widget wiring smoke test | Manual QA walkthrough of the new Job List screen with mock crew/job data after refreshing via the UI; screenshot appended once hardware matrix available. | Pending hardware capture; automated evidence above + `phased_plan.md` §1.3 notes. |

> Notes: Next manual step is to record device video showing pull-to-refresh, section headers, and crew chips once the jobs endpoint is available in staging.
