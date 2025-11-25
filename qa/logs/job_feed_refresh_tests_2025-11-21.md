# Job Feed Refresh Tests — 2025-11-21

- **Owner:** antigravity
- **Scope:** Phase 1-3 §1.2 (Job API Fetch)
- **Command:** `cd field_app_client && /workspaces/SM_App/flutter/bin/flutter test`
- **Result:** Pass (36 tests)

| Scenario | Method | Evidence |
| --- | --- | --- |
| API response persisted to jobs_local | `jobs_repository_test.dart` stubs `JobService.fetchJobs` and verifies upserted rows capture customer name, crew JSON, and hashed roster data for Today window queries. | `test/modules/jobs/jobs_repository_test.dart` → `refreshJobs upserts feed metadata and job rows`. |
| Feed metadata stored even with empty payload | Same test file asserts `job_feed_state` rows persist `api_version`, `next_cursor`, and `last_refreshed` for compatibility tracking, even when no jobs returned. | `test/modules/jobs/jobs_repository_test.dart` → `refreshJobs still records feed metadata when no jobs returned`. |
| Regression pass | Full Flutter suite (36 tests) executed to ensure punch/offline modules remain stable after the jobs feed wiring. | CI-equivalent local run referenced above. |

> Notes: Manual API smoke tests (Postman mock server + Charles) remain blocked until backend endpoints are reachable; once available, append captured responses and device sync timings to this log.
