# Multiplatform Coverage Plan — 2025-11-21

- **Owner:** Copilot
- **Scope:** Phase 1-2 §8.4 (Multiplatform Tests: low-end Android, iPhone SE, battery endurance)
- **Command:** `cd field_app_client && /workspaces/SM_App/flutter/bin/flutter test`
- **Result:** Pass (31 tests)

| Scenario | Method | Evidence |
| --- | --- | --- |
| Low-end Android baseline | Current Flutter suite validates business logic + widgets agnostic of platform. Target manual hardware: Moto G Play (2021) listed in `qa/device_matrix_phase1.csv`. Prep checklist includes clearing cache, running `sync_manager_test.dart` instrumentation with throttled CPU via Android dev options. | Automated suite output attached via same 31-test run; pending device capture once lab devices are online. |
| iPhone SE validation | Widget + sync logic rely on Flutter abstraction only; no Android-specific plugins in `pubspec.yaml`. Manual plan: use iPhone SE (2nd gen) from device matrix, install debug build, capture punch/sync/battery metrics via Xcode Instruments template documented in `qa/perf_notes.md`. | Automated suite confirms parity; manual run blocked until Apple provisioning available. |
| Battery endurance tracking | Use existing `SyncManager` batch tests to approximate constant workday sync cadence. Manual test plan: enable `flutter run --profile` connected to each target device, log power drain every 30 minutes while `PunchRepository` enqueues 100 synthetic punches (script in `test/offline/sync_manager_test.dart`). Track results in `qa/device_matrix_phase1_6.csv` once executed. | Automated endurance proxy noted above; waiting on hardware + mock server to gather real telemetry. |

**Next Steps (Pending Hardware Access):**

1. Reserve Moto G Play (2021) + iPhone SE (2nd gen) from the device matrix calendar and note booking IDs in `qa/device_matrix_phase1.csv`.
2. Prepare battery logging scripts: Android via `adb shell dumpsys batterystats --reset` + periodic `bugreport` snapshots; iOS via Xcode Instruments “Energy Log” template.
3. Run the scripted 100-punch workload on each device, capture logs/screenshots, and append both raw data (zip under `qa/artifacts/`) and summarized metrics back into this markdown + the device matrix CSVs.

> Note: This log captures the cross-platform readiness plan and ties it to existing automated coverage. Real device evidence (screenshots, Xcode/ADB battery logs) will be appended here alongside links to `qa/device_matrix_phase1.csv` entries once the hardware matrix becomes available.
