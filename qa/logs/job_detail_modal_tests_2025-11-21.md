# Job Detail Modal Tests — 2025-11-21

- **Owner:** antigravity
- **Scope:** Phase 1-3 §1.4 (Job Detail Modal)
- **Command:** `cd field_app_client && /workspaces/SM_App/flutter/bin/flutter test`
- **Result:** Pass (39 tests)

| Scenario | Method | Evidence |
| --- | --- | --- |
| Modal renders job metadata & crew list | Widget test pumps `JobDetailSheet` with a sample `JobListEntry` to validate that job IDs, service labels, crew chips, and action buttons appear. | `test/modules/jobs/job_detail_sheet_test.dart` |
| Job buckets still drive modal data | Existing bucketing tests verify the modal receives correctly grouped entries even after UI refactor. | `test/modules/jobs/job_list_controller_test.dart` |
| Route/Call OS intents | Pending physical device validation once we replace snackbars with platform intents and have permissions confirmed. | To be captured alongside staging video evidence (future log). |

> Notes: Copy Job ID action is fully wired to the clipboard; route/call buttons intentionally surface snackbars until the OS permission model is finalized in a later phase.
