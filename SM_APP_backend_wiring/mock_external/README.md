# Mock External Payloads (Temporary)

**Purpose:** This `mock_external/` folder mirrors the structure of the vendor-owned `/external/` assets without ever touching the real directory. Use these files as disposable, demonstrative payloads so the backend team can validate `/api/mobile/*` contracts while the Field App is still under construction.

## Ground Rules

1. **Temporary only.** Files here are treated as throwaway references. Do not ship, deploy, or version them into the production Laravel app.
2. **Segregated from `/external/`.** All mock data must stay in this folder (or its subdirectories). Never copy them into `/external/` or vice versa.
3. **Minimal scope.** Keep only the payloads and cURL/postman snippets required to unblock current milestones. Delete or archive obsolete files once the matching backend feature lands.
4. **Document references.** Whenever you add a new mock file, cite it in `API_WIRING.md` or the integration spec so backend contributors know why it exists.
5. **Mark ownership.** Add a short header comment (or JSON field) indicating which phase/sub-step the mock supports and the date it was added.

## Directory Layout

``` Example
mock_external/
├── README.md (this file)
└── payloads/
    ├── login_mock.json
    ├── jobs_feed_sample.json
    ├── punch_batch_sample.json
    └── timesheet_week_sample.json
```

Add additional payloads or fixtures inside `payloads/` (or new subfolders) as the plan references new endpoints.

## Usage Pattern

1. Reference these files when building Postman collections or Pest fixtures.
2. Copy the relevant JSON into Laravel feature tests (`tests/Feature/Mobile/*`) to keep parity with mobile expectations.
3. Once the live backend responses diverge, update both this folder and `MOBILE_BACKEND_INTEGRATION_SPEC.md` to prevent drift.

> **Reminder:** This is not an API mock server—just static examples that emulate what `/external/` integration points would provide when the system is complete.
