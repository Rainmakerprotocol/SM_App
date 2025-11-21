# API Wiring & File Drop Points

This document shows exactly where the proposed Laravel files/controllers/routes should live so human developers can slot them in without touching `external/`.

> **Rule:** Do **not** add/remove/modify anything under `external/`. All new work sits inside the core Laravel app (when reintroduced) or this `SM_APP_backend_wiring/` folder for planning artifacts.

## 1. Route Definitions

- File: `routes/api.php`
- Insert near existing job-clock routes:

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

## 2. Controllers

Place inside `app/Http/Controllers/Mobile/` (new directory):

- `MobileAuthController.php`
- `MobilePunchController.php`
- `MobileJobController.php`
- `MobileTimesheetController.php`
- `MobileProfileController.php`
- `MobileDisputeController.php`
- `MobileCrewController.php`

Each controller should defer heavy logic to services (below) to keep files readable for the partner dev team.

## 3. Services / Repositories

- Directory: `app/Services/Mobile/`
- Suggested classes:
  - `MobilePunchService` (batch validation, duplicate detection)
  - `MobileJobService` (query builder wrappers)
  - `MobileTimesheetService` (aggregations, NA1/NA2 logic reuse)
  - `MobileProfileService` (transform + update whitelist)
  - `MobileDisputeService`
  - `MobileCrewService`

## 4. Database Migrations

- Directory: `database/migrations/2025_11_XX_XXXXXX_add_mobile_fields_to_time_cards.php`
- Include all new columns (`gps_lat`, `gps_lng`, `gps_accuracy`, `gps_unavailable_flag`, `source`, `device_id`, `mobile_uuid`).
- Optional new tables (e.g., `mobile_sync_failures`) get their own migration files in the same folder.

## 5. Testing Harness

- Directory: `tests/Feature/Mobile/`
- Files:
  - `MobileAuthTest.php`
  - `MobilePunchTest.php`
  - `MobileJobTest.php`
  - `MobileTimesheetTest.php`
  - `MobileProfileTest.php`
  - `MobileDisputeTest.php`
  - `MobileCrewTest.php`
- Use Pest/PHPUnit to cover success + failure paths so mobile devs can reuse scenarios.

## 6. Postman Collection & Sample Payloads

- Keep exported collection JSON plus sample payloads inside `SM_APP_backend_wiring/postman/` (create once endpoints exist).
- Mobile team will reuse identical payloads for QA to keep integration friction-free.
- **Temporary mocks:** Use `SM_APP_backend_wiring/mock_external/payloads/` for throwaway JSON fixtures (login, jobs, punch batch, timesheet) that mirror `/external/` contracts without touching the vendor-owned folder. Each file documents the phase/sub-step it supports so backend devs can copy data directly into Pest/Postman tests.

## 7. SM_APP Standalone Section

- Treat this `SM_APP_backend_wiring/` directory as the single source of truth for planned API work.
- Add any future endpoint specs, mock data, or cURL recipes here so both AI-assisted and human developers stay aligned.
