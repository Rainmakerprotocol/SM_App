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
| Login | `/api/login` (now) → `/api/mobile/login` (future) | POST | Returns JWT + user profile.
| Profile read | `/api/mobile/profile/{employee}` | GET | Wraps `User` data; includes pay rate.
| Profile update | `/api/mobile/profile/{employee}` | PUT | Whitelist: phone, address, company phone, image.
| Jobs feed | `/api/mobile/jobs/{employee}` | GET | Employee view (today+future). Foreman view includes crew + ±14 days.
| Punch sync | `/api/mobile/punches/batch` | POST | Accepts queued punches, GPS, device metadata.
| Timesheet | `/api/mobile/timesheet/week/{employee}` | GET | Weekly totals, NA1/NA2, estimated pay.
| Disputes | `/api/mobile/disputes` | POST | Creates disputes; reuse existing tables.
| Dispute thread | `/api/mobile/disputes/{employee}` | GET | Returns dispute history + comments.
| Crew status | `/api/mobile/crew/status/{foreman}` | GET | Real-time crew punches, unsynced counts.

Detailed route stubs live in `API_WIRING.md`.

---

## 4. Data Contracts
### 4.1 Punch Payload
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
- **Queue storage:** `punches_local` table on device with `synced` + `sync_attempts` flags.
- **Sync triggers:** app launch, resume, connectivity change, manual button, 5-minute timer.
- **Conflict resolution:** server wins; client raises dispute if mismatch discovered.
- **Duplicate handling:** backend rejects same `mobile_uuid`; response still returns HTTP 200 with duplicates array so client can mark local punch as synced.
- **GPS handling:** backend stores coordinates even when accuracy > 80m but flags record; if GPS missing, `gps_unavailable` set and record flagged for review.

---

## 6. Error Handling
| Scenario | HTTP | Response | Mobile Action |
|----------|------|----------|---------------|
| Invalid token | 401 | `{ "success": false, "msg": "Token expired" }` | Force logout + relogin.
| Validation error | 422 | `{ "success": false, "errors": {"punches.0.job_id": ["Job required"]} }` | Highlight offending record, keep queued.
| Duplicate punch | 200 | `duplicates` list populated | Mark local record as synced with "duplicate" badge.
| Server error | 500 | `{ "success": false, "msg": "Unexpected error" }` | Leave in queue, exponential backoff.

---

## 7. Testing & Tooling
- Backend team provides Pest/PHPUnit tests in `tests/Feature/Mobile` using payloads above.
- Postman collection (to be added under `SM_APP_backend_wiring/postman/`) mirrors every scenario: login, jobs, punches (success/duplicate/error), timesheet, disputes, crew status.
- Mobile team reuses same collection for manual QA to guarantee parity.

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
