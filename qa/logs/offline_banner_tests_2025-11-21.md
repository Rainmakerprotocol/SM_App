# Offline Warning Banner Tests — 2025-11-21

- **Owner:** antigravity
- **Scope:** Phase 1-2 §7.1 (Offline warning banner)
- **Command:** `cd field_app_client && /workspaces/SM_App/flutter/bin/flutter test`
- **Result:** Pass (26 tests)
- **Focus:** Verified `OfflineWarningBanner` renders the required guidance text and icon via `test/modules/navigation/offline_warning_banner_test.dart`, ensuring the navigation shell now shows the offline banner whenever `offlineStatusProvider` reports no connectivity.
