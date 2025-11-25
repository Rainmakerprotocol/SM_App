# Jobs Local Schema Tests — 2025-11-21

- **Owner:** antigravity
- **Scope:** Phase 1-3 §1.1 (Create Local Table: `jobs_local`)
- **Command:** `cd field_app_client && /workspaces/SM_App/flutter/bin/flutter test`
- **Result:** Pass (34 tests)

| Scenario | Method | Evidence |
| --- | --- | --- |
| JobsLocal columns persist required metadata | `jobs_local_test.dart` inserts a job with address, crew JSON, crew hash, and synced flag, then asserts each column value including timestamp storage. | `test/offline/database/jobs_local_test.dart` → `upsertJob persists schema fields and defaults`. |
| Scheduled window query + crew hash updates | Added `AppDatabase.jobsForWindow` helper to order records by `scheduled_date`, then re-upserted to confirm crew hash/crew list changes are saved. | Same test file → `jobsForWindow orders by scheduled date and updates crew hash`. |
| Reactive window watcher | `watchJobsForWindow` emits after insert/update so UI buckets (Today, Upcoming) can refresh without polling. | Same test file → `watchJobsForWindow reflects inserts and updates`. |

> Notes: These automated checks validate the Phase 1-3 §1.1 schema requirements before QA executes on-device DB snapshots. Future manual steps will attach SQLite dumps + device gallery proof when hardware time is scheduled.
