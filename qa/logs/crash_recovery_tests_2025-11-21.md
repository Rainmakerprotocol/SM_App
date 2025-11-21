# Crash Recovery & Queue Alert Tests — 2025-11-21

- **Owner:** Copilot
- **Scope:** Phase 1-2 §6.3 (Crash Recovery safeguards, queue corruption alerts)
- **Command:** `cd field_app_client && /workspaces/SM_App/flutter/bin/flutter test`
- **Result:** Pass (24 tests, including new coverage in `test/offline/sync_manager_test.dart`)
- **Focus:** Verified Drift schema upgrade paths load corrupt queue rows into `CorruptQueueEntries`, `SyncQueueDao.fetchPending` invokes `onCorrupt`, and `SyncManager` emits a `QueueAlert` that the navigation shell surfaces so users are warned about archived punches.
