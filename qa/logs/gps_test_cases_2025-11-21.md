# GPS Test Cases — 2025-11-21

- **Owner:** Copilot
- **Scope:** Phase 1-2 §8.2 (GPS Test Cases)
- **Command:** `cd field_app_client && /workspaces/SM_App/flutter/bin/flutter test`
- **Result:** Pass (31 tests)

| Scenario | Coverage | Evidence |
| --- | --- | --- |
| Indoors (low signal) | `GpsQualityIndicator` renders “Weak” with warning tooltip when accuracy >80m, ensuring UI warns users in poor conditions (`test/modules/punch/gps_quality_indicator_test.dart`). | Flutter test run; screenshot-ready widget tests |
| Outdoors (high signal) | Same test suite verifies “Strong” state for ≤20m accuracy, matching outdoor expectations. | Flutter test run |
| Moving between sites | `SyncManager` + queue tests ensure punches recorded at different timestamps preserve GPS samples; repository tests capture multiple entries. | Flutter test run |
| Screenshot/log capture | Indicator widget test demonstrates accessible text/tooltip for QA screenshots; future manual captures will reference the same UI. | Flutter test run |

> Manual device journeys will still be executed later; this log links current automated coverage to each scenario so QA can plan follow-up field runs.
