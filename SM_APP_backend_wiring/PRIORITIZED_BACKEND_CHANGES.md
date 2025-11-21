# Storm Master Mobile API — Backend Priorities

**Purpose:** Sequence the backend work that must land before the mobile Field App can move beyond planning. Derived from `INTEGRATION_ANALYSIS_COMPLETE.md` (Nov 20, 2025).

## Priority 0 — Protect Existing Hardware Flow

- Keep `/api/rm-check` + job clock infrastructure untouched while new mobile logic is introduced.
- All schema and controller changes must default `source = 'job_clock'` unless explicit mobile metadata is present.

## Priority 1 — Database & Auth Readiness

1. **Extend `time_cards` schema**
   - Add `gps_lat`, `gps_lng`, `gps_accuracy`, `gps_unavailable_flag`, `source`, `device_id`, `mobile_uuid` columns.
   - Backfill existing records with `source = 'job_clock'`.
2. **Add supportive tables**
   - `mobile_sync_failures` (optional) for diagnostics.
   - `mobile_devices` for device fingerprinting (future expansion).
3. **JWT Hygiene**
   - Verify `config/jwt.php` TTL matches 30-day plan; document re-login UX since no refresh endpoint exists.

## Priority 2 — Core Mobile Route Layer (`/api/mobile/*`)

1. Introduce a dedicated route group in `routes/api.php`:

   ```php
   Route::middleware(['api', 'jwt.auth'])->prefix('mobile')->group(function () {
       Route::post('/login', [MobileAuthController::class, 'login']);
       Route::post('/punches/batch', [MobilePunchController::class, 'batchStore']);
       Route::get('/jobs/{employee}', [MobileJobController::class, 'index']);
       Route::get('/timesheet/week/{employee}', [MobileTimesheetController::class, 'show']);
       Route::get('/profile/{employee}', [MobileProfileController::class, 'show']);
       Route::put('/profile/{employee}', [MobileProfileController::class, 'update']);
       Route::post('/disputes', [MobileDisputeController::class, 'store']);
       Route::get('/crew/status/{foreman}', [MobileCrewController::class, 'status']);
   });
   ```

2. Align controllers with repository layer without breaking Angular flows.

## Priority 3 — Punch Engine Enhancements

- Build `MobilePunchController::batchStore` to accept queued punches, dedupe via `mobile_uuid`, validate GPS accuracy, and respond with per-record status (`processed`, `duplicate`, `invalid_job`).
- Refactor `TimeCardRepository` helpers into reusable services to avoid 6k-line sprawl affecting both mobile and hardware flows.

## Priority 4 — Read APIs (Jobs, Timesheets, Profile)

- Optimize job queries for employee-centric view (±14 days for foremen).
- Surface pay-rate + profile info through a sanitized transformer.
- Provide weekly timesheet aggregation that mirrors payroll calculations (NA1/NA2 logic) for parity with admin portal.

## Priority 5 — Foreman & Dispute Support

- Implement dispute submission/comments under `/api/mobile/disputes` using existing tables.
- Add crew status endpoint combining `crews`, `crew_members`, and latest punch state per employee (requires new query or view).

## Priority 6 — Observability & Docs

- Add structured logging (`mobile_uuid`, `device_id`, `gps_accuracy`).
- Deliver accompanying Postman collection + README (see other files in `SM_APP_backend_wiring/`).
