# Offline Punch Scenarios — 2025-11-21

- **Owner:** Copilot
- **Scope:** Phase 1-2 §8.1 (Offline Test Scenarios)
- **Command:** `cd field_app_client && /workspaces/SM_App/flutter/bin/flutter test`
- **Result:** Pass (31 tests)

| Scenario | Method | Evidence |
| --- | --- | --- |
| Airplane mode punch | Simulated by `PunchRepository.recordPunch` storing queue rows without network dependencies (`test/modules/punch/punch_repository_test.dart`). | Flutter test run; pending punches persisted in Drift.
| Airplane mode → travel → reconnect → sync | `SyncManager` tests cover reconnect triggers + exponential backoff ensuring queued punches flush once connectivity resumes (`test/offline/sync_manager_test.dart`). | Flutter test run confirms success/partial failure handling. |
| Multiple punches offline | Repository + sync tests enqueue multiple drafts and dedupe duplicates before sync. | Flutter test run; see `punch_repository_test.dart` duplicate coverage. |
| Queue survives reboot | Drift DB integration tests ensure pending punches remain (`getPendingPunches` assertions) until sync deletes them. | Flutter test run; referenced tests in repository suite. |
| Offline UI indicator | `OfflineWarningBanner` widget test confirms banner copy surfaces when offline status flips (`test/modules/navigation/offline_warning_banner_test.dart`). | Same flutter test run. |

> Note: These scenarios map automated coverage to the plan’s offline reliability checklist. Manual field validation (device airplane mode runs) remains pending until hardware is available.
