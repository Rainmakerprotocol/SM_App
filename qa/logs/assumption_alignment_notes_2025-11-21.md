# Assumption Alignment Notes — 2025-11-21

- **Owner:** antigravity
- **Scope:** Phase 1-2 interim decisions (`DL-004`, `DL-005`, `DL-006`).
- **Context:** Documented temporary choices so Security + Backend teams know what to revisit before Phase 1-3 locking.

## Items to Validate Later

1. **Storage Encryption (DL-004):**
   - Drift DB currently uses `NativeDatabase` without SQLCipher. TODO in `lib/offline/database/app_database.dart` highlights the swap point.
   - Security to confirm whether SQLCipher or record-level AES is required before GA. Once decided, update the executor factory + plan status box.

2. **Punch Batch Envelope (DL-005):**
   - `RestPunchSyncTransport` now wraps queue payloads with `employee_id`, `device_id`, `app_version`, and `batch_id`.
   - Backend should review `SM_APP_backend_wiring/MOBILE_BACKEND_INTEGRATION_SPEC.md#4-1-punch-payload` and reply if additional metadata (cost codes, crew hash, etc.) is required so repositories can serialize it centrally.

3. **GPS Policy (DL-006):**
   - Plan + spec now state the 10s high-accuracy attempt → cached coordinate fallback → `gps_unavailable=true` flow.
   - When the GPS service lands, QA must capture logs/screenshots for indoor/low-signal scenarios to prove the policy matches field expectations.

## Follow-up Tracking

- Add backend responses + test evidence links to this log so decision references remain traceable.
