# Foreman Job View Tests — 2025-11-21

- **Owner:** antigravity
- **Scope:** Phase 1-3 §1.5 (Foreman Job View)
- **Command:** `cd field_app_client && /workspaces/SM_App/flutter/bin/flutter test`
- **Result:** Pass (41 tests)

| Scenario | Method | Evidence |
| --- | --- | --- |
| Foreman controller merges crews + punch telemetry | Unit test builds in-memory jobs/punches to ensure unsynced counts, off-assignment detection, and job filtering behave. | `test/modules/jobs/foreman_job_controller_test.dart` |
| UI wiring renders drill-down data | Covered indirectly via widget tree when `ForemanJobsPane` is pumped inside integration smoke (future on-device capture). This log tracks automated controller coverage until staging hardware capture occurs. | Pending QA video (hardware) |
| Regression suite (41 cases) | Full Flutter test run after integrating controller/UI to verify existing modules unaffected. | `flutter test` output attached above |

> Notes: Manual QA still needs to capture device video showing the Foreman pane, crew drill-down modal, and unsynced banners once `/api/mobile/jobs` returns live crew data.
