# Backend Development Tasks — Storm Master Mobile API

| ID | Category | Task | Deliverables | Dependencies |
|----|----------|------|--------------|---------------|
| B-01 | Schema | Add GPS + source columns to `time_cards` | Migration + model updates; default `source='job_clock'` | None |
| B-02 | Schema | Introduce `mobile_uuid` uniqueness constraint | Migration + DB index | B-01 |
| B-03 | Routing | Create `/api/mobile/*` route group | Routes + stub controllers with feature flags | B-01 |
| B-04 | Auth | Build `MobileAuthController` wrapper around existing JWT login (records device info) | Controller + tests + Postman sample | B-03 |
| B-05 | Punches | Implement `MobilePunchController::batchStore` with per-record outcomes | Controller, validation rules, repository helpers, logging | B-01, B-02, B-03 |
| B-06 | Jobs | Implement `MobileJobController::index` (employee + foreman views ±14 days) | Controller + query optimization + transformers | B-03 |
| B-07 | Timesheets | Implement `MobileTimesheetController::show` returning weekly summary + pay estimates | Controller + service wrappers | B-03 |
| B-08 | Profile | Implement `MobileProfileController::show/update` (limited editable fields + photo upload) | Controller + upload handling + policy checks | B-03 |
| B-09 | Disputes | Implement `MobileDisputeController::store` + comment thread retrieval | Controller + events | B-03 |
| B-10 | Crew | Implement `MobileCrewController::status` returning live punch state per crew member | Controller + SQL view/service | B-01, B-03 |
| B-11 | Docs | Publish Postman collection + README describing endpoints | `SM_APP_backend_wiring/API_WIRING.md`, Postman JSON | B-03..B-10 |
| B-12 | QA | Create automated feature tests for `/api/mobile/*` | Pest/ PHPUnit suites mirroring mobile flows | B-05..B-10 |
