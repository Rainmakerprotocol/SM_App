# Mobile ↔ Backend Integration Specification

**Version:** 1.0  
**Date:** November 20, 2025  
**Scope:** Defines how the Storm Master Field App interacts with the existing Laravel backend once `/api/mobile/*` endpoints are implemented.

---

## 1. System Overview

- **Existing flow:** Job clocks (RFID) → `/api/rm-check` → `time_cards` → Angular admin.
- **New flow:** Mobile app → `/api/mobile/*` → shared database. Mobile punches must peacefully coexist with hardware punches.
- **Deployment goal:** Provide human developers a drop-in wiring kit (see this folder) so they can add endpoints without touching `external/` data.

---

## 2. Authentication Flow

1. User opens app → enters email/username + password.
2. App hits `POST /api/login` (existing) or `/api/mobile/login` (wrapper once available).
3. Backend issues JWT (`Authorization: Bearer {token}`; 30-day TTL). No refresh endpoint; app re-prompts on 401.
4. App stores token securely (Keychain/Keystore) and attaches to all calls.
5. Optional device metadata payload:

   ```json
   {
     "email": "john@example.com",
     "password": "secret",
     "device": {
       "platform": "android",
       "model": "Pixel 6",
       "app_version": "1.0.0",
       "device_id": "a1b2c3"
     }
   }
   ```

- Mobile client implementation detail: `AuthMetadataCollector` (see `field_app_client/lib/modules/auth/data/`) now generates a persistent `device_id` via secure storage, ensuring login payloads report a stable identifier per install for audit trails.

---

## 3. Endpoint Matrix

| Feature | Endpoint | Method | Notes |
|---------|----------|--------|-------|
| Login | `/api/login` (now) → `/api/mobile/login` (future) | POST | Returns JWT + user profile |
| Profile read | `/api/mobile/profile/{employee}` | GET | Wraps `User` data; includes pay rate |
| Profile update | `/api/mobile/profile/{employee}` | PUT | Whitelist: phone, address, company phone, image |
| Jobs feed | `/api/mobile/jobs/{employee}` | GET | Employee view (today+future). Foreman view includes crew + ±14 days |
| Punch sync | `/api/mobile/punches/batch` | POST | Accepts queued punches, GPS, device metadata |
| Timesheet | `/api/mobile/timesheet/week/{employee}` | GET | Weekly totals, NA1/NA2, estimated pay |
| Disputes | `/api/mobile/disputes` | POST | Creates disputes; reuse existing tables |
| Dispute thread | `/api/mobile/disputes/{employee}` | GET | Returns dispute history + comments |
| Crew status | `/api/mobile/crew/status/{foreman}` | GET | Real-time crew punches, unsynced counts |

Detailed route stubs live in `API_WIRING.md`.

---

## 4. Data Contracts

### 4.1 Punch Payload

> _Assumption (`DL-005`): Mobile batches currently wrap punches with the metadata shown below (employee, device, batch id, app version). Laravel devs can override the schema later, but until then both sides should treat this as the working contract so QA can validate offline queues._

```json
{
  "employee_id": 12,
  "device_id": "a1b2c3",
  "batch_id": "2025-11-20T10:00:00Z-12",
  "punches": [
    {
      "mobile_uuid": "ba9f6fd7-...",
      "job_id": 245,
      "job_item_id": 611,
      "service_id": 4,
      "type": "IN", // IN, OUT, DRIVE, ROOF, SHOP
      "cost_code": 3,
      "timestamp_device": "2025-11-20T08:30:00-05:00",
      "gps_lat": 43.012345,
      "gps_lng": -83.123456,
      "gps_accuracy": 12.5,
      "gps_unavailable": false,
      "notes": "Starting tear-off"
    }
  ]
}
```

**Response:**

```json
{
  "success": true,
  "processed": ["ba9f6fd7-..."],
  "duplicates": ["c1d2..."],
  "errors": [{"uuid": "e3f4...", "code": "invalid_job", "message": "Job closed"}]
}
```

### 4.2 Job Feed Response

```json
{
  "employee_id": 12,
  "range": {
    "start": "2025-11-18",
    "end": "2025-11-25"
  },
  "jobs": [
    {
      "job_id": 245,
      "display_id": "JOB-2025-0010",
      "title": "123 Main - Tear-off",
      "address": "123 Main St, Flint, MI 48502",
      "scheduled_date": "2025-11-21",
      "scheduled_time": "08:00",
      "services": [
        { "job_item_id": 611, "service_id": 4, "service_name": "Roofing", "status": 3 }
      ],
      "crew": [
        { "employee_id": 12, "name": "John Doe", "role": "Installer", "status": "IN" }
      ]
    }
  ]
}
```

### 4.3 Timesheet Response

```json
{
  "employee_id": 12,
  "week": {"start": "2025-11-17", "end": "2025-11-23"},
  "days": [
    {
      "date": "2025-11-20",
      "punches": [
        {
          "uuid": "ba9f6fd7-...",
          "job_id": 245,
          "start_time": "08:00",
          "end_time": "15:30",
          "cost_code": 3,
          "source": "mobile_app"
        }
      ],
      "regular_hours": 7.0,
      "ot_hours": 0.5,
      "notes": ""
    }
  ],
  "weekly_total_hours": 38.5,
  "weekly_ot1_hours": 2.5,
  "estimated_pay": 1025.50
}
```

---

## 5. Offline & Sync Rules

- **Queue storage:** Drift `sync_queue` rows retain the full punch payload plus attempt counters so the client can batch up to 25 records. `DL-003` locks this architecture through `SyncManager`, and `DL-004` documents that the tables stay plaintext until SQLCipher/FFI encryption is approved.
- **Sync triggers:** foreground resume, manual “Sync now,” network reconnect, login success, and a 5-minute timer all call `SyncManager.trigger()`; background timers simply enqueue the trigger flag so the UI thread can drain the queue when awakened. Client instrumentation lives in `SyncLifecycleListener` (wraps `FieldApp`) and the manual sync icon inside `NavigationShell`, so QA/backends can trace exactly when triggers fire.
- **Conflict resolution:** Laravel is the source of truth. The mobile app trusts the server response (`processed`, `duplicates`, `errors`) and purges local punches once acknowledged. Validation failures stay server-side (422) with a human dispute created from the app if needed.
- **Duplicate handling:** `/api/mobile/punches/batch` must treat duplicate `mobile_uuid` values as 200 responses with a populated `duplicates` array. The app removes those queue entries without re-posting them.
- **Exponential backoff:** Failed batches retry with jittered doubling (5s → 10s → 20s → 40s → 5m) up to five attempts per punch. After the fifth failure the client drops the record locally but emits analytics so QA can reconcile with backend logs.
- **Transport states:** Unauthorized (401) responses pause sync until the user logs in again. Server/transport faults keep the timer active so the queue drains automatically once connectivity stabilizes.
- **GPS handling (`DL-006`):** Backend should persist all coordinates (even >80m) but flag high-variance readings. If `gps_unavailable` is true the record is still inserted with a “no-fix” marker for later QA review because the client continues punching after a 10s timeout per the interim policy.

### 5.1 Client Pseudocode (mirrors `field_app_client/lib/offline/sync/sync_manager.dart`)

``` Enhanced Text
triggerSync(trigger):
  if !hasConnectivity: return scheduleRetry()
  session = readAuthSession()
  if session == null: return

  batch = queue.fetchPending(limit=25)
  while batch not empty:
    response = transport.send(batch, session)
    delete queue entries marked processed or duplicates
    for each error in response.errors:
      if error.code == 'duplicate': delete entry
      else if attempts >= 5: delete + emit analytics
      else: increment attempt + scheduleRetry()
    batch = queue.fetchPending(limit=25)

scheduleRetry():
  delay = min(currentDelay * 2 + jitter, 5 minutes)
  Timer(delay, () => triggerSync('periodic'))
```

### 5.2 Backend Expectations

- Surface `processed`, `duplicates`, and per-record `errors` with `{ uuid, code, message }` so the mobile app can apply the above flow deterministically.
- Log every rejected punch with the mobile UUID, employee ID, and reason to match analytics coming from the app.
- Honor `Authorization: Bearer` headers and return `401` immediately so the app pauses syncing and prompts for login.

### 5.3 Punch Payload Definition (Phase 1-2 §5.2)

Mobile now ships a code-backed payload snapshot (see `test/modules/punch/punch_models_test.dart` + QA log `qa/logs/punch_payload_contract_tests_2025-11-21.md`) so Laravel devs can copy the exact structure into DTOs/Pest fixtures:

```json
{
  "employee_id": "12",
  "device_id": "device-123",
  "app_version": "1.0.0",
  "punches": [
    {
      "mobile_uuid": "resolved-id",
      "job_id": "245",
      "service_id": "611",
      "type": "IN",
      "timestamp_device": "2025-11-21T08:30:00.000Z",
      "gps_lat": 43.0,
      "gps_lng": -83.0,
      "gps_accuracy": 9.5,
      "gps_unavailable": false,
      "device_id": "device-123",
      "source": "mobile_app",
      "notes": "Starting tear-off"
    }
  ]
}
```

| Field | Required? | Notes |
|-------|-----------|-------|
| `employee_id` | Yes | Stringified to match mobile auth cache. |
| `device_id` | Yes | Unique per install; mirrors analytics + dispute references. |
| `app_version` | Yes | Already part of the envelope from §5.1 tests so backend can gate migrations. |
| `punches[].mobile_uuid` | Yes | Drift-resolved UUID; duplicates list references this same value. |
| `punches[].job_id` | Yes | String to avoid int/long drift between MySQL + Drift. |
| `punches[].service_id` | No | Present when user selected a service; omitted otherwise. |
| `punches[].type` | Yes | Enum values: `IN`, `OUT`, `BREAK_START`, `BREAK_END`. |
| `punches[].timestamp_device` | Yes | ISO-8601 UTC string; backend converts to payroll TZ. |
| `punches[].gps_lat` / `gps_lng` / `gps_accuracy` | No | Included only when a GPS fix exists; accuracy in meters. |
| `punches[].gps_unavailable` | Yes | Boolean toggled true when no fix within 10s per `DL-006`. |
| `punches[].device_id` | Yes | Repeated for audit parity with `employee_id` when logs get detached from envelopes. |
| `punches[].source` | Yes | Defaults to `mobile_app`; job clock imports will emit `job_clock`. |
| `punches[].notes` | No | Optional technician note attached to the punch. |

> Backend TODO: Align DTO validation to the above optional/required matrix and surface descriptive `errors[].code` values (e.g., `invalid_job`, `gps_required`) so the mobile app can keep dispute markers accurate.

---

## 6. Error Handling

| Scenario | HTTP | Response | Mobile Action |
|----------|------|----------|---------------|
| Invalid token | 401 | `{ "success": false, "msg": "Token expired" }` | Force logout + relogin |
| Validation error | 422 | `{ "success": false, "errors": {"punches.0.job_id": ["Job required"]} }` | Highlight offending record, keep queued |
| Duplicate punch | 200 | `duplicates` list populated | Mark local record as synced with "duplicate" badge |
| Invalid job / closed job | 200 | `errors` entry with `code: invalid_job` | Mobile flags punch as `requires_dispute`, stores backend reason, removes from pending queue |
| Invalid timestamp | 200 | `errors` entry with `code: invalid_timestamp` | Mobile stores validation text, marks record as dispute-required so user can correct locally |
| Job mismatch | 200 | `errors` entry with `code: job_mismatch` | Mobile auto-marks record as dispute-required and surfaces message once dispute UI lands |
| Server error | 500 | `{ "success": false, "msg": "Unexpected error" }` | Leave in queue, exponential backoff |

> **Client UX hook:** The mobile app now displays a snackbar when a batch returns any `errors` entries, so keep `errors[].code` + `errors[].message` human-readable (`invalid_job`, `gps_required`, etc.) to help field techs understand what still needs attention.

---

## 7. Testing & Tooling

- Backend team provides Pest/PHPUnit tests in `tests/Feature/Mobile` using payloads above.
- Postman collection (to be added under `SM_APP_backend_wiring/postman/`) mirrors every scenario: login, jobs, punches (success/duplicate/error), timesheet, disputes, crew status.
- Mobile team reuses same collection for manual QA to guarantee parity.
- Static sample payloads that mimic the eventual `/external/` drops now live under `SM_APP_backend_wiring/mock_external/payloads/`; treat them as temporary fixtures you can paste into tests until real integrations land.

---

## 8. Implementation Checklist

1. Migrate DB (GPS/device fields, indexes).
2. Add `/api/mobile/*` routes + controllers/services per `API_WIRING.md`.
3. Implement batch punch engine with per-record status.
4. Build job/timesheet/profile/dispute/crew endpoints.
5. Add logging + monitoring for `mobile_uuid`, `device_id`, GPS accuracy.
6. Publish Postman collection + README (this folder).
7. Run automated tests; share results with mobile team.

---

## 9. Handoff Notes

- This spec + wiring files are the “SM_APP standalone section” referenced in planning documents.
- Keep `external/` untouched; all new Laravel code lives in the main app tree when reintegrated.
- Update this spec whenever payloads or endpoints change so mobile + backend teams stay aligned.
