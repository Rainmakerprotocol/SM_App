# Storm Master Field App

## Storm Master Field App — Phase 1-1 Detailed Breakdown

**Document Version:** 1.1
**Prepared For:** Agentic AI and Copilot
**Prepared By:** Storm Master / Eugene Therrien
**Scope:** Phase 1-1 (formerly Week 1) — Detailed Technical Steps
**Platforms:** Android + iOS
**Backend:** Laravel (API) + MySQL

---

### 📘 Plan Charter & Workspace Layout

#### 📋 Purpose of This Document

- This document is the **authoritative build plan** for all phases of the Field
App—treat it as a standalone guide that captures every dependency, step, and
consideration.
- **Backend wiring** artifacts live under `SM_APP_backend_wiring/`
(see sections below) so the Laravel web team can stage connectivity without
touching `external/` assets.
- The **Field App source** will live in a new root-level folder (recommended name: `field_app_client/`). That folder must be initialized as its own repo-ready structure (separate README, `.gitignore`, package manager files) to simplify export and handoff.
- Whenever this plan references new endpoints, payloads, or sync logic, cross-check the matching specs inside `SM_APP_backend_wiring/` to ensure parity between documentation and implementation.
- Record every architectural or process decision that affects this plan in `decision_log.md` (ID, date, section, rationale, impact). Each phase below includes prompts on when to add an entry so future contributors can trace why something changed.
- When `decision_log.md` gains a new entry, update any impacted sections here, in `COPILOT_BUILD_GUIDE.md`, or in the backend wiring folder so all docs stay in sync.

#### 🕰️ Narrative Lens (Past · Present · Future)

- **Past:** Each section references lessons learned from the integration analysis and prior tooling spikes so we remember why certain constraints exist.
- **Present:** Tasks describe the exact state of work-in-progress, including current blockers or testing gaps, so priorities can shift without losing context.
- **Future:** Completion criteria highlight how the work unlocks subsequent phases; note any assumptions that might change and flag them in `decision_log.md`.
- Testing and documentation are first-class deliverables—every milestone must link to QA evidence and updated docs so future readers (human or AI) can follow the full arc.

---

### 🧱 Current Backend Architecture Snapshot (Reality Check)

The integration analysis confirmed several mismatches between this plan and the live Storm Master stack. Keep these facts in mind while executing every Phase 1 task:

- **Traffic flow today:** RFID job clocks (Raspberry Pi) ➜ `/api/rm-check` (Laravel 10) ➜ Angular admin UI. There is **no mobile layer** yet.
- **Authentication:** JWT via `POST /api/login` with 30-day TTL. No refresh endpoint, no `/api/mobile/login` route.
- **Jobs & crews:** Web app pulls jobs through `/api/get-all-formatted-job` queries filtered by employee/foreman. Responses are not optimized for mobile consumption.
- **Time cards:** `time_cards` lacks GPS/device/source columns. Punch logic auto-updates prior entries but cannot store mobile-specific metadata.
- **Disputes & timesheets:** Existing endpoints (`/api/time-card-dispute`, `/api/get-employee-timecards`, etc.) power the Angular UI only; none are namespaced for mobile clients.
- **Missing building blocks:** `/api/mobile/*` routes, batch punch submission, offline queues, duplicate detection by UUID, and crew status endpoints must all be created during backend work.

> **Implication:** Every reference to `/api/mobile/...` in this plan represents **new Laravel development** (Phase 1 backend deliverables) before the mobile app can function.

---

### 🗂️ SM_APP Backend Wiring Package

- All planning assets for the new endpoints now live under **`SM_APP_backend_wiring/`** at the repo root. This folder is the hand-off bundle for the human Laravel team (see `PRIORITIZED_BACKEND_CHANGES.md`, `BACKEND_TASKS_BOARD.md`, and `API_WIRING.md`).
- **Do not** add, delete, or modify anything inside `external/`; keep extracted vendor artifacts pristine. Any reference implementations, mock payloads, or Postman exports must land inside `SM_APP_backend_wiring/` instead.
- The wiring docs include the exact file paths, controller names, migrations, and testing harnesses we will use to validate the `/api/mobile/*` endpoints so the backend team can mirror the same structure.

#### 📄 Mobile ↔ Backend Integration Spec

- Detailed payloads, sync logic, and error-handling rules for every `/api/mobile/*` route are captured in `SM_APP_backend_wiring/MOBILE_BACKEND_INTEGRATION_SPEC.md`.
- Mobile and Laravel teams must reference that spec when implementing or reviewing endpoints; any payload change must be reflected there before code updates.
- Postman collections and mock data will be stored alongside the spec (same folder) once controllers are live so everyone tests against identical contracts.

#### 🧭 Decision Tracking Hooks

- `decision_log.md` is the single source of truth for why we deviated from or expanded on this plan. Add an entry whenever you:
  - Choose between technology options listed in a phase (e.g., Flutter vs React Native, SQLite provider, auth caching strategy).
  - Adjust API contracts, payloads, or sync behavior described here or in the wiring spec.
  - Introduce new QA evidence locations or change completion criteria.
- Each phase section below contains "Decision Hook" callouts reminding you to log outcomes. When you add an entry, include the decision ID (e.g., `DL-004`) inline in this plan for quick cross-reference.

---

## 🚀 Phase 1-1 — Detailed Technical Breakdown

This section expands Phase 1-1 (formerly Week 1) into precise, sequential engineering tasks.
These are the micro-steps developers must complete to properly initialize the project.

> **Perspective:** Past (integration analysis + tooling audit) taught us Flutter alignment and backend gaps. Present focus is bootstrapping the repo, documenting architecture, and standing up CI smoke tests. Future phases depend on these scaffolds, so capture every deviation plus testing/doc evidence before moving on.

---

## ✅ Phase 1-1: Project Setup & Foundations (Detailed Steps)

### **1. Project Initialization (Mobile App Base Setup)**

### **1.1 Choose Tech Stack**

- Decide between **Flutter** (preferred) or **React Native**.
- Confirm dev team proficiency.
- Create initial tech stack document.
- **Decision Hook:** Log the chosen stack, state management approach, and justification in `decision_log.md` (e.g., `DL-001`). Reference the ID here for future readers.
- _Decision recorded as `DL-001`: Flutter 3.x + Riverpod selected for cross-platform parity and offline plugin ecosystem._

#### **1.2 Initialize Project Repository**

- Create new project folder.
- Location: `/workspaces/SM_App/field_app_client` (treated as standalone repo for future export—include dedicated README, license, and `.gitignore`).
- Initialize with:
  - `flutter create stormmaster_field_app`
    or
  - `npx react-native init stormmaster_field_app`
- Add folder conventions:
  - `/lib` or `/src`
    - `/modules`
    - `/services`
    - `/offline`
    - `/models`
    - `/screens`
    - `/utils`

#### **1.3 Add Platform Builds**

- Configure **Android build.gradle**
- Configure **iOS Podfile**
- Ensure app builds cleanly on both platforms before any logic added.

---

### **2. Core Architectural Decisions**

#### **2.1 Offline-First Strategy**

- Decide on **SQLite** (preferred) or **secure storage + JSON file** hybrid.
- Create local database schema with tables:
  - `punches_local`
  - `jobs_local`
  - `profile_local`
  - `sync_queue`
- Document migration/versioning rules for the local DB (how schema upgrades are handled per release).
- Define encryption/obfuscation requirements for sensitive fields (employee IDs, GPS metadata) before implementing storage adapters.
- Align on ORM/DAO helpers (e.g., Drift, Moor, Room) and add boilerplate files in `field_app_client/lib/offline/`.
- **Decision Hook:** Document the selected local DB technology, encryption stance, and versioning approach in `decision_log.md`.

**Present:** `DL-002` locks Drift + `sqlite3_flutter_libs` as the storage stack. `lib/offline/database/app_database.dart` now defines schema version 1 with `punches_local`, `jobs_local`, `profile_local`, and `sync_queue` tables plus Riverpod providers so services can request DAO access without wiring SQL manually.

#### **2.2 Sync Engine Blueprint**

- Define:
  - Queue architecture
  - Retry logic
  - Data precedence (server wins or client wins?)
  - Conflict detection (duplicate punches)
- Write sync diagram:

``` Process Flow:
Local Punch → Queue → Retry Loop → API POST Batch → Server Response → Purge Queue
```

- Identify trigger events (app launch, resume, manual button, background timer) and document them in `lib/offline/sync/sync_manager.dart`.
- Specify exponential backoff and max-attempt rules for failed batches; capture analytics so backend can diagnose problematic batches.
- Add pseudocode or flowchart to `SM_APP_backend_wiring/MOBILE_BACKEND_INTEGRATION_SPEC.md` when sync rules change.
- **Decision Hook:** Capture final queue architecture + conflict-resolution rules in `decision_log.md` and link to the wiring spec revision.

**Status Checklist (2025-11-22):**

- [x] Copilot — Implemented `SyncManager` + `PunchSyncTransport` under `field_app_client/lib/offline/sync/`, added `offline_status.dart`, and exposed DAO helpers so queue batches carry attempt counts.
- [x] Copilot — Wrote unit coverage for retry/backoff logic (`field_app_client/test/offline/sync_manager_test.dart`) and documented triggers/backoff flow in the integration spec + `decision_log` (`DL-003`).
- [ ] Backend Team — Mirror the exponential backoff + duplicate handling rules in Laravel’s `/api/mobile/punches/batch` controller + logging once route scaffolds begin.

**Past:** Queue accessors existed but no engine consumed them, leaving trigger/backoff decisions undocumented.

**Present:** `SyncManager` now drains queued punches in 25-item batches, reads session/connection state, and enforces server-wins precedence with duplicate detection + five-attempt exponential backoff (5s→10s→20s→40s→5m w/ jitter). `/SM_APP_backend_wiring/MOBILE_BACKEND_INTEGRATION_SPEC.md` contains the mirrored flow diagram, ensuring backend + mobile teams reason about the same retry cadence.

**Future:** Wire triggers to real lifecycle hooks (foreground/background services + manual “Sync now” CTA) and emit analytics for permanently dropped punches before expanding the engine to jobs/timesheets in later phases.

#### **2.3 Authentication Flow**

- Mirror the existing Laravel JWT flow:
  - `POST /api/login` accepts **email OR username + password** (lookup order matters)
  - Tokens are JWTs with a **30-day TTL**; **no refresh endpoint** is available, so the mobile app must re-authenticate when a 401 occurs
  - Store the bearer token securely and attach as `Authorization: Bearer {token}` for every API call
- Document device metadata to send alongside login (device id, OS) so backend can log mobile sessions once `/api/mobile/login` is implemented.
- Create basic login screen (placeholder UI) that reflects the above constraints (two input fields + password, error copy for 401/expired tokens).
- Define token persistence strategy (secure storage keys, refresh timers, logout hooks) and add helper functions to `auth_service.dart`.
- Stub integration tests that simulate expired tokens to guarantee the app gracefully re-prompts without data loss.
- **Decision Hook:** Note any deviations from the baseline JWT flow (e.g., adding biometric unlock) in `decision_log.md` and cite that ID in the auth section.

**Status Checklist (2025-11-21):**

- [x] Copilot — Added secure token persistence (`field_app_client/lib/modules/auth/data/token_storage.dart`) plus metadata-aware auth services/controllers; mock + REST providers share Riverpod DI hooks.
- [x] Copilot — Unit tests guard session restore + 401 handling (`field_app_client/test/auth_controller_test.dart`).
- [ ] Backend Team — Switch `USE_MOCK_AUTH` off once `/api/mobile/login` ships and update wiring spec with real payload/response IDs.

**Past:** Login UI and Riverpod gate existed but authentication was mock-only with no persisted tokens.

**Present:** Auth controller now restores sessions from secure storage, collects device/app metadata before login, and exposes `handleUnauthorized()` so API clients can reset cleanly. Metadata payload matches `SM_APP_backend_wiring/MOBILE_BACKEND_INTEGRATION_SPEC.md`.

**Future:** Wire to live Laravel `/api/mobile/login`, add biometric unlock + token expiry reminders, and document logout hooks once backend refresh/blacklist strategy finalizes.

---

### **3. UI Scaffolding**

#### **3.1 Create Placeholder Screens**

Screens to scaffold:

- Login
- Home
- Punch
- Job List
- Timesheet
- Profile
- Use shared typography/colors defined in a `theme.dart` file so later polishing (Phase 1-4) is incremental rather than disruptive.
- Wire basic ViewModel/Controller classes per screen even if they return mock data; this keeps dependency injection ready for when APIs land.

**Present:** Placeholder UI scaffolds now live under `field_app_client/lib/modules/*` with Riverpod providers returning mock data, unified by `AppTheme` and guarded through `AuthGate`. Each screen matches the Phase 1 tab layout so hooking up real services can happen incrementally.

#### **3.2 Navigation Architecture**

- Set up bottom tab navigation:
  - Home
  - Jobs
  - Timesheet
  - Profile
- Add route guards:
  - If not authenticated → Login
  - If authenticated → Main App
- Add deep-link placeholders (e.g., `stormmaster://timesheet/today`) so later notifications or web links can open specific tabs.
- Include analytics hooks for tab changes to understand usage once telemetry is enabled.

**Present:** `NavigationShell` (Riverpod-powered) now handles the Home/Jobs/Punch/Timesheet/Profile stack with a sign-out action and auth guard; deep-link stubs + analytics plumbing remain TODO once routing strategy is finalized.

---

### **4. Backend API Mapping**

#### **4.1 Map Required Endpoints**

Create an API contract document listing the **new** endpoints the Laravel team must build (none of these exist today):

- `/api/mobile/login` — wrap the existing JWT login flow and log device/platform metadata
- `/api/mobile/jobs/{employee_id}` — employee/foreman-centric job feed (today only `/api/get-all-formatted-job` exists for web filters)
- `/api/mobile/punches/batch` — batch insert with UUID duplicate detection, GPS, and offline metadata (today only `/api/rm-check` handles single punches from job clocks)
- `/api/mobile/timesheet/week/{employee_id}` — weekly aggregation leveraging the current payroll repositories
- `/api/mobile/profile/{id}` + `PUT /api/mobile/profile/{id}` — read/update profile data without exposing admin forms
- `/api/mobile/disputes` — create disputes plus threaded comments
- `/api/mobile/crew/status/{foreman_id}` — consolidate crew roster + live punch snapshot for field foremen

> Schema prerequisite: extend `time_cards` with `gps_lat`, `gps_lng`, `gps_accuracy`, `source`, and `device_id` before finalizing the punch and crew endpoints.

#### **4.2 Request/Response Specs**

Document:

- Expected request payloads
- Response JSON
- Error structures
- Status codes
- Sync the written specs with `SM_APP_backend_wiring/MOBILE_BACKEND_INTEGRATION_SPEC.md`; treat that file as the canonical source.
- Include unhappy-path examples (401, 422, 500) so mobile devs can code defensive states before hitting live endpoints.
- Capture Postman examples for every endpoint and store them in `SM_APP_backend_wiring/postman/` once available.

#### **4.3 Create API Service Layer**

Add structure:

- `api/login_service.dart`
- `api/job_service.dart`
- `api/punch_service.dart`
- `api/profile_service.dart`
- Each service should expose both real and mock providers so QA can run the app without backend connectivity during early phases.
- Ensure services accept dependency injection (e.g., via Riverpod/GetIt) to simplify unit testing.

**Status Checklist (2025-11-21):**

- [x] Copilot — Built typed REST + mock services for login, jobs, punch, profile, and weekly timesheet APIs with shared Riverpod providers and HTTP client wiring (`field_app_client/lib/api/*.dart`).
- [x] Copilot — Added parsing/unit coverage (`test/api/job_service_test.dart`, `test/api/timesheet_service_test.dart`) and widget/sync regression guard (`test/widget_test.dart`, `test/offline/sync_manager_test.dart`); evidence logged in `qa/logs/api_sync_layer_tests_2025-11-21.md`.
- [ ] Backend Team — Wire these services to live `/api/mobile/*` endpoints once Laravel routes and payload contracts stabilize.

**Past:** UI controllers returned mock data with no shared HTTP client or DI hooks, so features could not call backend contracts outlined in the wiring spec.

**Present:** `lib/api/*.dart` exposes DI-friendly services honoring `AppConfig` feature flags, funnels punch batches through `PunchSyncTransport`, and centralizes auth/session handling while QA can flip to mock providers instantly.

**Future:** Replace mock flags when `/api/mobile/*` endpoints go live, add dispute/crew service modules, and extend tests for unhappy-path 401/422 responses plus telemetry hooks.

---

### **5. Device Testing Environment**

#### **5.1 Device Matrix**

Prepare for:

- Low-end Android phone
- Modern Android
- iPhone XR or newer
- iPhone SE (small screens)
- Record OS versions (min + target) in a compatibility spreadsheet so QA coverage stays consistent.

#### **5.2 Install Debug Tools**

- Flutter DevTools or React Native DevTools
- Android Studio logs
- iOS Xcode console
- Configure remote logging (e.g., Sentry/Firebase) but keep it disabled until prod credentials are available.

#### **5.3 Test Build**

- Build initial app shell on all devices
- Fix any platform-specific errors early
- Capture build artifacts (APK/IPA) and attach to the sprint handoff so stakeholders can validate progress even before APIs exist.

---

### **6. Final Verification for Phase 1-1**

#### **6.1 Project Compiles on Both Platforms**

- No errors
- Clean scaffolding
- Ready for development
- CI/Nightly scripts compile the shell app (even with mock services) to detect toolchain drift early.

#### **6.2 Offline Architecture Document Completed**

Should include:

- Storage schema
- Sync logic
- Punch structure
- Local cache rules

#### **6.3 API Contract Approved by Storm Master**

- Endpoint list
- Payloads
- Authentication rules
- Versioning strategy
- Obtain written/recorded approval (email or meeting notes) before starting backend/mobile implementation to avoid rework.

---

## **End of Phase 1-1 Detailed Breakdown**

## Storm Master Field App — Phase 1-2 Detailed Breakdown

**Document Version:** 1.1
**Prepared For:** Agentic AI and Copilot
**Prepared By:** Storm Master / Eugene Therrien
**Scope:** Phase 1-2 (formerly Week 2) — Offline Punching System
**Platforms:** Android + iOS
**Backend:** Laravel (API) + MySQL

---

## **Phase 1-2 — Detailed Technical Breakdown**

This document expands **Phase 1-2** into precise, sequential engineering steps required to build the **offline punching + GPS + sync engine** foundation of the Field App.

> **Perspective:** Past incidents with unreliable job clocks drive the offline-first + GPS emphasis. Present work pairs UI/DB changes with exhaustive instrumentation/tests so syncing stays trustworthy. Future modules (jobs, disputes) will reuse these primitives, so keep documentation and QA artifacts current to enable pivots.

---

## ✅ Phase 1-2: Offline Punching System (Detailed Steps)

### **1. Offline Punch UI Implementation**

#### **1.1 Create Punch Screen Layout**

- Build UI elements:
  - Punch In
    - Punch Out
- Break Start
  - Break End
  - Add indicators:
    - “Currently Clocked In”
    - Job/Service selected
- GPS lock status

#### **1.2 Add Job Selection Modal**

- User chooses:
  - Job ID
    - Service
    - Foreman sees assigned crew jobs across ±14 days
    - Ensure selection stored with punch record

#### **1.3 Add Real-time State Indicator**

- Show:
  - Punch status (IN/OUT)
  - Time since last punch
  - Job currently active
  - Warning if offline

---

### **2. GPS Integration**

#### **2.1 Request Permissions**

- Prompt for foreground location on first launch of Punch screen; defer background access until Phase 2+.
- Provide rationale strings that reference job-site verification so users understand why GPS is mandatory.
- Persist the permission state so UI can show call-to-action banners when access is denied/limited.

#### **2.2 Acquire GPS Coordinates**

- Attempt a high-accuracy fix with a 10s timeout, then fall back to the last known coordinate stored locally.
- Capture latitude, longitude, accuracy (meters), and timestamp for every punch.
- If GPS is unavailable, set `gps_unavailable=true` and log the condition for backend review.

#### **2.3 Validate GPS Accuracy**

- If `accuracy > 80m`, flag the punch as "Low Accuracy" but still allow submission (per client guidance).
- Surface UI warnings so employees know to step outside for a better signal when practical.
- Store both accuracy and flag fields locally so disputes can reference them later.

#### **2.4 Create GPS Utility Module**

- Centralize fetch/retry/timeout logic inside `lib/services/gps_service.dart` and expose a stream for UI consumption.
- Include unit tests that mock platform channels to simulate GPS failure, timeout, and success paths.
- Emit structured analytics (accuracy histogram) to help measure real-world quality once telemetry is enabled.

---

### **3. Local Punch Storage System**

#### **3.1 Create Local Table: `punches_local`**

Fields:

- punch_id (UUID)
- employee_id
- job_id
- service_id
- punch_type
- timestamp_device
- gps_lat
- gps_lng
- gps_accuracy
- synced (bool)
- sync_attempts
- source (“mobile_app”)
- Include `gps_unavailable`, `device_id`, and `last_error` columns so troubleshooting data persists offline.
- Define composite indexes (e.g., `employee_id + timestamp_device`) to keep queries snappy when queue grows.

#### **3.2 Insert Punch Records**

- Every punch → instant local write
- Must work offline 100%
- Wrap writes in transactions so partial failures (e.g., GPS missing) don’t corrupt the queue.
- Encrypt queued payloads at rest if device policy requires (document decision in security checklist).

#### **3.3 Add “Pending Sync” Badge**

- UI reflects unsynced punches
- Foreman sees crew’s unsynced count
- Show exact count + oldest pending age to prompt manual sync before end-of-day exports.

---

### **4. Sync Queue Engine**

#### **4.1 Create Local Table: `sync_queue`**

Fields:

- queue_id
- payload (JSON)
- attempt_count
- created_at
- last_attempt_at

#### **4.2 Build Sync Manager Service**

Handles:

- reading queue
- batching punches
- submitting to API
- parsing responses
- clearing queue
- retry with exponential backoff
- Keep batch size configurable (start with 20 punches) so backend can tune throughput versus payload size.
- Emit detailed logs for each outcome (processed/duplicate/error) and persist them for at least 7 days for diagnostics.

#### **4.3 Add Background Sync Trigger**

Triggers:

- App open
- App resume
- Timer (every 5 minutes)
- Manual “Sync Now”
- Include OS-specific handling (Android WorkManager / iOS background fetch) once Phase 2+ work enables background sync.

**Status Checklist (2025-11-21):**

- [x] Copilot — Introduced `SyncLifecycleListener` wrapping `FieldApp` to observe app resume/login events, launch a 5-minute timer, and call `SyncManager.trigger()` when the foreground is available (`lib/offline/sync/sync_lifecycle_listener.dart`).
- [x] Copilot — Added manual sync CTA in `NavigationShell` plus widget test coverage that fakes token storage so onboarding still renders under the new listener; see `qa/logs/api_sync_layer_tests_2025-11-21.md`.
- [ ] Backend Team — Implement platform background fetch/WorkManager tasks and telemetry collection once backend throttling + analytics contracts are ready.

**Past:** SyncManager existed but no lifecycle or UI entry points triggered it, so punch queues remained idle outside of manual test hooks.

**Present:** App launch, login success, manual “Sync now,” resume, and the periodic timer all execute `SyncManager.trigger`, keeping offline punches draining without user guesswork.

**Future:** Layer in OS background workers, offline banners, and analytics once product finalizes scheduling + monitoring requirements.

#### **4.4 Server Conflict Handling**

If server returns:

- Duplicate punch → mark as synced
- Invalid job_id → flag record
- Invalid timestamp → send correction request
- Automatically open dispute draft when server rejects a punch due to job mismatch, so employees can correct quickly.

---

### **5. API Integration for Punches**

#### **5.1 Connect to Batch Punch Endpoint**

`POST /api/mobile/punches/batch`

- Backend status: **Not built yet.** Laravel team must add `MobilePunchController::batchStore`, new routes under `Route::prefix('mobile')`, and the GPS/device/source columns referenced earlier before the app can call this endpoint.
- Provide API contract + sample Postman collection from the mobile team so backend devs can mirror payload/response expectations.

#### **5.2 Build Payload Structure**

Example:

```json
{
  "employee_id": 12,
  "punches": [
    {
      "punch_id": "...",
      "job_id": "...",
      "service_id": "...",
      "type": "IN",
      "timestamp_device": "...",
      "gps_lat": 43.123,
      "gps_lng": -83.552,
      "gps_accuracy": 12
    }
  ]
}
```

- Ensure payload also carries `device_id`, `source`, `mobile_uuid`, and optional `gps_unavailable` just like the schema additions planned for the backend.
- Store payload definitions next to the integration spec so backend developers can copy/paste when writing feature tests.

#### **5.3 Create Response Handler**

Success:

- Mark records as synced
- Remove from queue

Failure:

- Retry
- Mark flagged records
- Parse per-record statuses (`processed`, `duplicate`, `error_code`) and update local tables accordingly to avoid ambiguous UI states.
- Display toast/banner when a batch partially fails so field users know to resync before clocking out.

---

### **6. Error Handling + Reliability**

#### **6.1 Network State Detection**

- If offline → queue only
- If online → attempt sync
- Provide a persistent icon/badge indicating current connectivity so foremen know when data last synced.

#### **6.2 Duplicate Punch Prevention**

- Punch ID based on UUID
- Server checks uniqueness
- Sync manager avoids resending

#### **6.3 Crash Recovery**

On app restart:

- Reload offline queue
- Display unsynced alerts
- Validate integrity of queued JSON; if corruption detected, back up to a `.bad` table and prompt user to contact support before deleting.

#### **6.4 Prevent Double Taps**

- Add tap debounce
- Disable buttons briefly after press

---

### **7. UI Enhancements for Punch Reliability**

#### **7.1 Offline Warning Banner**

- “You are offline. Punches will sync when connection is restored.”

#### **7.2 GPS Quality Indicator**

- Color code: green/yellow/red
- Tooltip: accuracy in meters
- Provide tap-through guidance ("Need better accuracy? Step outside…") based on the integration spec’s thresholds.

#### **7.3 Job/Service Reminder**

- If user hasn’t selected job → require before punch
- Show crew context for foremen so they can confirm they’re punching under the correct job item before submitting.

---

### **8. Testing Requirements**

#### **8.1 Offline Test Scenarios**

- Airplane mode punch
- Airplane mode → travel → reconnect → sync
- Multiple punches offline
- Validate queued data survives device reboot and OS updates.

#### **8.2 GPS Test Cases**

- Indoors (low signal)
- Outdoors (high signal)
- Moving between sites
- Capture screenshots/logs of GPS accuracy so backend stakeholders can review real-world behavior.

#### **8.3 Sync Stress Tests**

- 100 punches in queue
- Random failures
- API returning partial success
- Use the Postman mock server (when available) to simulate throttling/500 responses.

#### **8.4 Multiplatform Tests**

- Low-end Android
- iPhone SE
- Track battery impact while sync runs continuously to ensure devices last a full workday.

---

### **9. Completion Criteria**

- Offline punching fully functional
- GPS captured reliably
- Sync queue stable
- No duplicate punches
- UI stable and clear
- Crash recovery intact
- All Phase 1-2 APIs integrated
- QA sign-off recorded with test matrix (offline, GPS, stress, multi-device) stored alongside sprint artifacts.

---

## 📌 End of Phase 1-2 Detailed Breakdown

---

## Storm Master Field App — Phase 1-3 Detailed Breakdown

**Document Version:** 1.0
**Prepared For:** Agentic AI and Copilot
**Prepared By:** Storm Master / Eugene Therrien
**Scope:** Phase 1-3 (formerly Week 3) — Jobs, Timesheets & Foreman Features
**Platforms:** Android + iOS
**Backend:** Laravel (API) + MySQL

---

## 🚀 Phase 1-3 — Detailed Technical Breakdown

This document expands **Phase 1-3** into precise, sequential engineering tasks needed to implement:

- Job List (Employee + Foreman)
- Timesheet Engine (Local Calculations)
- Estimated Pay Display
- Foreman Crew View & Punch Monitoring

> **Perspective:** Past crew feedback highlighted missing visibility; present tasks connect the punch foundation to jobs/timesheets/foreman dashboards. Future dispute/payroll flows inherit this data, so testing (rollup drift, crew indicator accuracy) and documentation must stay rigorous to support shifting priorities.

---

## ✅ Phase 1-3: Job List, Timesheets, Foreman Visibility (Detailed Steps)

---

## **1. Job List System Implementation**

## **1.1 Create Local Table: `jobs_local`**

Fields:

- job_id
- service_id
- customer_name
- address
- scheduled_date
- foreman_id
- crew_list (JSON)
- last_updated
- synced (bool)
- Add `crew_hash` column to detect when backend crew assignments change so UI can show update badges.
- Index by `scheduled_date` to support fast retrieval for "Today" vs "Upcoming" tabs.

### **1.2 Job API Fetch**

Call:
`GET /api/mobile/jobs/{employee_id}`

Store response in:

- `jobs_local`
- Mark timestamp for refresh
- Persist `api_version` with each response to detect incompatibilities if backend contract changes.
- Handle pagination (if backend adds it later) by storing `next_cursor` metadata even if Phase 1 uses single-page results.

#### **1.3 Build Job List Screen**

Sections:

- Today’s Jobs
- This Week
- Last Week

Sort:

- By date
- By start time
- Provide quick filters (e.g., "Needs Love", "Completed") once backend exposes status codes.
- Show sync/refresh indicator tied to `last_updated` so users know how fresh the list is.

#### **1.4 Job Detail Modal**

Includes:

- Job ID
- Service list
- Customer name
- Address (tap → Google/Apple Maps)
- Crew list
- Scheduled date & time
- Buttons: `View Route`, `Call Customer`, `Copy Job ID` (wired to OS intents once permissions confirmed).

#### **1.5 Foreman Job View**

Foreman sees:

- Jobs ±14 days
- Full crew list per job
- Crew punch statuses (IN/OUT)
- Any unsynced punches for the crew
- Provide drill-down to each crew member’s current job vs assigned job to flag potential mis-punches.
- Display job-clock vs mobile source badges so foremen understand where data originated.

---

### **2. Timesheet Engine**

### **2.1 Local Timesheet Table**

`timesheet_local`
Fields:

- punch_id
- job_id
- day
- hours_calculated
- break_hours
- synced
- adjusted (bool)
- flagged (bool)
- Store `source` and `dispute_status` to keep local view in sync with backend state during Phase 1-4.

#### **2.2 Build Timesheet Aggregator**

Reads from:

- `punches_local`
- `punches_synced`

Calculates:

- Daily totals
- Weekly totals
- Per-job totals
- Regular vs OT (future config)
- Keep calculations pure and unit-tested so backend/ mobile totals can be compared easily during validation.
- Respect payroll settings (8hr vs 40hr NA1) by reading cached config returned from backend.

#### **2.3 Daily Timesheet UI**

Displays:

- Punch pairs (IN → OUT)
- GPS accuracy
- Job names
- Totals per day
- Buttons:
  - Dispute
  - Expand details
- Show GPS icons + accuracy tooltips next to each punch pair.
- Indicate whether the punch originated from job clock or mobile (uses `source`).

#### **2.4 Weekly Timesheet UI**

Displays:

- Weekly regular hours
- Weekly OT hours
- Total hours
- Day-by-day breakdown (tap to jump to detail view)
- Visual progress bar toward 40-hour threshold

#### **2.5 Estimated Pay Display**

Uses local math:

- hours * pay_rate
- pay_rate pulled from profile API

Read-only **for employee transparency**.

- Flag differences between local estimate and backend-provided pay (once `/timesheet/week` endpoint returns final numbers) to avoid confusion.

  ---

  ### **3. Foreman Crew View**

  #### **3.1 Crew Aggregation Pipeline**

  - Source data from the same `/api/mobile/jobs/{employee_id}` payload (crew array) plus the punch stream defined in `SM_APP_backend_wiring/MOBILE_BACKEND_INTEGRATION_SPEC.md`.
  - Persist crew members in `crew_assignments_local` (job_id, employee_id, role, assigned_on, crew_hash, last_seen, last_status_source).
  - Join `crew_assignments_local` with `punches_local` and `punches_synced` to surface real-time status per member even when offline.
  - Cache a `foreman_focus_window` (±14 days) so the screen loads instantly and only refreshes deltas through incremental sync API calls.

  #### **3.2 Punch Status Indicators**

  - Apply consistent badge colors: Green = Clocked In, Red = Clocked Out, Yellow = Unsynced Punches, Grey = No activity today.
  - Display tooltip text showing timestamp, GPS accuracy, and whether the punch originated on mobile or a physical job clock.
  - Blink the Yellow state until the sync queue confirms delivery to `/api/mobile/punches/sync` to train foremen on latency expectations.

  #### **3.3 Crew Detail Modal & Actions**

  - Surface punch history for the current day plus last known job assignment for context when employees drift between sites.
  - Show total hours, dispute flags, and any notes that payroll left on the punch row (field already defined in wiring spec).
  - Add quick actions: `Call Employee`, `Request Location Ping` (phase 1 placeholder), `View Dispute Thread` (navigates to disputes section once built).

  #### **3.4 Foreman Permissions & Data Guards**

  - Foremen cannot edit punches but may acknowledge disputes or add comments that flow to `/api/mobile/disputes/{id}/comments` once backend ships it.
  - Hide crew members outside the foreman’s job list using the same ACL checks as the job list API to avoid data leakage.
  - Log every modal open event locally so product can audit usage once analytics sink is wired.

  #### **3.5 Sync & Offline Behavior**

  - When offline, show last-known status with a "stale" badge if `last_seen` exceeds 15 minutes; suppress the Yellow state to avoid confusion about unsent punches.
  - On reconnection, prioritize crew status refresh before broader job list sync so foremen immediately see accurate headcounts.
  - Write a Detox/E2E test script that force-toggles airplane mode to verify state transitions and indicator colors.

  #### **3.6 Completion Criteria**

  - Crew view loads in <1.5s with cached data, then reconciles with API without blocking UI.
  - Indicators match the punch data returned by the Postman collection in `SM_APP_backend_wiring/FOREMAN_CREW_COLLECTION.json`.
  - Device matrix (iOS/Android) screenshots stored under `qa/device_gallery/phase1/crew_view/` proving status colors, modal data, and permissions behave as expected.

    ---

    ### **4. Sync Between Punches & Timesheets**

    #### **4.1 Automatic Rebuild Engine**

    - Trigger engine after punch sync, job sync, device resume, or manual "refresh" gesture from the timesheet screen.
    - Use a background worker queue so recalculations never block UI threads; persist the last rebuild timestamp in `sync_state_local`.
    - Recompute daily, weekly, and crew totals and write summaries into `timesheet_rollups_local` to avoid recalculating on every render.
    - Compare rollup hashes with backend `/api/mobile/timesheet/week` responses for validation, logging any drift to `qa/rollup_drift.log`.

    #### **4.2 Punch–Job Linking Guardrails**

    - When a punch references a job not cached locally, enqueue a high-priority fetch for that job ID before persisting the punch to ensure detail screens have metadata.
    - Maintain a `missing_job_links` table to prevent repeated fetches and to show a placeholder badge if metadata still unavailable offline.
    - Use the integration spec in `SM_APP_backend_wiring/MOBILE_BACKEND_INTEGRATION_SPEC.md` to keep payload mappings consistent.

    #### **4.3 Timesheet Error Flags & Notifications**

    - Flag entries for missing OUT punch, excessive break, auto-clockout, GPS accuracy >80m, and overlapping jobs; store flags in `timesheet_flags_local` with severity levels.
    - Surface flags inline plus in a "Needs Attention" list on the dashboard so employees see issues early.
    - For foremen, aggregate flagged punches per crew and push summaries into the crew view so conversations can happen before disputes are filed.

---

### **5. UI & UX Enhancements**

#### **5.1 Visual Consistency Pass**

- Establish a token file (`ui/theme/tokens.ts|dart`) that defines colors, typography, spacing, and shadows so widgets stay aligned.
- Update job cards, punch history tiles, timesheet rows, and status icons to consume shared tokens; document before/after in `design/changelog.md`.
- Add accessibility review for contrast ratios ≥ 4.5:1 and hit targets ≥ 44px.

#### **5.2 Loading & Sync States**

- Create skeleton loaders for job list, timesheet, crew view, and disputes; ensure they adapt to light/dark mode.
- Add offline banners at the screen level plus a global toast to reinforce state; tie to the same connectivity observer used by the sync queue.
- Display "Syncing…" indicators whenever `/api/mobile/*` batched requests are running; include a tap target to open the sync detail sheet.

#### **5.3 Empty & Error States**

- Author copy variations for no jobs, no punches, no disputes, and no profile changes; store them in `content/strings.json` for localization later.
- Pair each empty state with an action (e.g., "Pull to refresh" or "Contact dispatcher") so users are not stuck.
- Implement friendly error banners for GPS, network, and auth issues with retry buttons that hook into existing service layer.

#### **5.4 Animation & Motion Guidelines**

- Apply 150–200ms fade/slide transitions when swapping between Today/Week tabs to reduce perceived jank.
- Benchmark on low-end Android devices to ensure frame drops stay below 5%; log results in `qa/perf_notes.md`.

---

### **6. Testing & Validation**

#### **6.1 Job & Sync Tests**

- Unit-test job fetch/storage/retrieval logic with mock API responses covering empty, single, and multi-page results.
- Validate jobs fetch offline → cached view and refresh time <1s using throttled network profiles.
- Exercise pagination stubs even if backend not paginating yet to avoid regressions once enabled.
- Verify map deeplinks open correctly on both platforms with mocked coordinates.

#### **6.2 Timesheet Engine Tests**

- Unit-test overlapping punch resolution, weekly totals, break deductions, and estimated pay math using fixtures from `SM_APP_backend_wiring/TEST_DATA/punches.json`.
- Simulate backend drift by altering cached punches and ensure error flags fire.
- Write snapshot tests for daily/weekly views to guard UI regressions.

#### **6.3 Foreman & Crew Tests**

- Confirm crew list matches joined punch/job tables and that unsynced warnings toggle when sync queue empties.
- Test ±14 day window navigation, offline stale badges, and modal actions.
- Add Detox scenario that triggers a dispute comment notification and verifies it surfaces in crew detail modal.

#### **6.4 Device & Field Matrix**

- Track iOS (SE, XR, 12/13) and Android (Moto G, Pixel 5, Galaxy A-series) coverage in `qa/device_matrix_phase1.csv`.
- Capture screenshots/videos for each core flow and attach to the QA evidence folder.

---

### **7. Phase 1-3 Completion Criteria**

- Job list, detail, and routing actions fully functional with offline cache + refresh SLAs met.
- Timesheet engine local calculations match backend reference totals within ±0.1 hours for provided fixtures.
- Estimated pay displayed correctly and labeled as estimate until backend confirms final numbers.
- Foreman crew view delivers indicator accuracy per Section 3 completion criteria and loads <1.5s from cache.
- UI maintains 55+ FPS on low-end Android during scroll tests; no fatal crashes across 24h soak runs.
- Sync queue drains under 5s after reconnect for 20 punch backlog; all error flags and banners localized via shared strings file.

---

## 📌 End of Phase 1-3 Detailed Breakdown

## Storm Master Field App — Phase 1-4 Detailed Breakdown

**Document Version:** 1.0
**Prepared For:** Agentic AI and Copilot
**Prepared By:** Storm Master / Eugene Therrien
**Scope:** Phase 1-4 (formerly Week 4) — Disputes, Profile Management, UI Polish
**Platforms:** Android + iOS
**Backend:** Laravel (API) + MySQL

---

## 🚀 Phase 1-4 — Detailed Technical Breakdown

Phase 1-4 transforms the app from a “working prototype” into a **field-ready tool** with:

- Full dispute workflow
- Editable employee profile
- Robust UI polish
- Stability improvements
- Offline-safe interactions
- Final user-facing refinements

> **Perspective:** Past issues with disputes and profile edits inform today’s goals of resilient workflows + polished UX. Future releases rely on these touchpoints, so track every test run (offline disputes, profile conflicts) and update docs/decision IDs as priorities evolve.

---

## Phase 1-4: Dispute System, Profile, UX Polish (Detailed Steps)

---

### **1. Dispute System Implementation**

#### **1.1 Create Dispute Table (Local Storage)**

`disputes_local`
Fields:

- dispute_id (UUID)
- punch_id
- employee_id
- reason
- comment
- proposed_time (optional)
- status (pending / reviewed / resolved / rejected)
- thread (JSON for comments)
- synced (bool)
- last_status_source (mobile vs backend) for audit trails.
- Link schema to `SM_APP_backend_wiring/MOBILE_BACKEND_INTEGRATION_SPEC.md#disputes` so payload parity stays intact.

#### **1.2 Dispute Entry Points**

- “Dispute” button visible on punch pairs, auto-clockouts, and missing punch placeholders.
- Long-press on timeline row should also open the dispute modal for accessibility.
- Foreman screens show "Flag for employee" CTA that pre-fills dispute form with foreman notes.

#### **1.3 Dispute Form UI**

Fields:

- Reason dropdown populated from backend-configured list (cached under `settings_local`).
- Required comment box with 500 char limit + counter.
- Optional corrected time selector supporting IN, OUT, break adjustments.
- Attachment slot (Phase 1 placeholder) reserved for future photo evidence.
UI Requirements:
- Offline capable with inline warning when no network.
- Show privacy note explaining disputes go to payroll.

#### **1.4 Local Dispute Queue & Workflow**

- Store submissions offline, mark as `pending_upload`, and display "Awaiting Review" pill inside timesheet rows.
- Queue persists across app restarts; include retry/backoff similar to punch sync.
- If punch edits locally (e.g., new OUT arrives) while dispute pending, prompt user to confirm if dispute still relevant.

#### **1.5 Sync to Backend**

`POST /api/mobile/disputes`
Payload includes dispute metadata, proposed fix, device timestamp, GPS snapshot (if available), and full initial comment thread.

- Use the same auth headers as punch sync; treat HTTP 409 as duplicate submission and collapse local entries accordingly.

#### **1.6 Threaded Comment System & Notifications**

- Append backend-sent comments to `thread` JSON, preserving author metadata.
- When status changes, show toast + badge update.
- Register lightweight notification handler so future push messages route user directly to dispute detail.

#### **1.7 Audit & Export Hooks**

- Log dispute lifecycle events (created, synced, status change) to `qa/logs/disputes_audit.log` for QA traceability.
- Provide export button (Phase 1 placeholder) that dumps dispute JSON for payroll when requested.

---

### **2. Profile Management**

#### **2.1 Profile Local Cache Table**

`profile_local`
Fields:

- name
- phone
- address
- emergency contact
- avatar_url
- hire_date
- pay_rate
- position
- certifications (JSON array)
- last_backend_update
- dirty_fields (JSON) for conflict detection.

#### **2.2 Profile Fetch from Backend**

- `GET /api/mobile/profile/{id}` populates cache and timestamps `last_backend_update`.
- Store backend ETag so we can perform conditional PUTs later.

#### **2.3 Profile Edit UI & Validation**

- Editable: phone, address, emergency contact, avatar.
- Non-editable: name, pay rate, hire date, role, certs.
- Input validation: phone mask, address auto-format, emergency contact required pair (name + phone).
- Show last verified date and provide "Request Change" link for locked fields.

#### **2.4 Photo Upload Flow**

- Open camera/gallery via platform pickers; compress to <1MB JPEG/PNG.
- Encrypt stored photo blob while pending sync; purge after upload success.
- When offline, show queued badge + ability to cancel to free storage.

#### **2.5 Sync & Conflict Handling**

- `PUT /api/mobile/profile/{id}` with only dirty fields + ETag; if backend reports conflict, re-fetch profile and surface diff UI for user to reapply or discard changes.
- Queue updates similar to disputes/punches with exponential backoff.

#### **2.6 Consistency & Audit Checks**

- Validate fields before committing to local DB; highlight invalid entries inline with helper text.
- Log profile changes to `qa/logs/profile_audit.log` so QA can trace edits made during testing.
- Add "Reset to server version" CTA for testers.

---

### **3. UI Polish & UX Enhancements**

#### **3.1 Global Button Style Pass**

- Standardize radius, colors, typography, spacing, and state transitions via shared style guide.
- Document component variants (primary, secondary, ghost, destructive) with usage rules.
- Ensure focus outlines visible for keyboard/assistive nav.

#### **3.2 Loading Indicators**

- Implement shimmer/skeleton loaders per screen; tie loader visibility to data fetch promises so spinners do not flicker.
- Provide top-level sync HUD summarizing pending queues (punches, disputes, profile, jobs) with counts.

#### **3.3 Empty States Library**

- Provide illustrated empty states with consistent iconography and CTAs, e.g., "No jobs scheduled today — pull to refresh or contact dispatcher."
- Store copy + illustration references in `content/empty_states.json`.

#### **3.4 Motion & Micro-interactions**

- Add fade/slide transitions to modals, success toasts, and tab switches; keep durations <250ms.
- Use haptics on punch actions and dispute submissions (if permitted) to reinforce feedback.

#### **3.5 Error States**

- Provide human-readable error text plus error codes (from backend) for support.
- Include retry buttons that call service layer; log occurrences into `qa/logs/error_events.log`.

---

### **4. Offline-Resilient Interactions**

#### **4.1 Unified Offline Banner**

- Display global banner with CTA to open sync detail sheet; persists until connectivity restored for ≥3s.
- Allow user to dismiss temporarily but auto-show if new queued items detected.

#### **4.2 Screen-Level Sync Gating**

- For profile saves/dispute submissions, show inline “Waiting for connection” state and allow queueing without errors.
- Crew view refresh button disabled while offline but offers "View cached" explanation.
- Log offline actions to `qa/logs/offline_actions.log` for QA.

#### **4.3 Crash/Restart Recovery**

- Persist pending actions with metadata (created_at, attempt_count) so upon restart they resume automatically.
- Provide toast "We recovered X pending actions" after cold start to reassure users.
- Add automated test that simulates app kill mid-sync to ensure queue continues.

---

### **5. Foreman Enhancements (Light)**

#### **5.1 Dispute Review UI**

- Foreman can view dispute thread read-only plus add comment/resolution tag if backend grants permission.
- Provide filters (Pending, Reviewed, Needs Info) and badge counts to prioritize attention.
- Link each dispute back to crew member detail modal for context.

#### **5.2 Quick Crew Timesheet Summary**

- Show daily hours, out-of-radius events, and unsynced counts in a collapsible card per crew member.
- Allow export/email summary stub for foreman to share with office (Phase 1 placeholder).
- Align data with timesheet rollups to avoid duplication.

---

### **6. Testing Requirements**

#### **6.1 Dispute Testing**

- Submit disputes offline/online, duplicate submissions, conflicts after punch update.
- Validate threaded comments, status transitions, and notification deep links.
- Confirm audit logs captured in `qa/logs/disputes_audit.log`.

#### **6.2 Profile Testing**

- Update fields offline, resolve conflicts, ensure photo uploads resume after reconnect.
- Attempt invalid values to confirm validation copy.
- Verify audit log entries and "Reset to server version" behavior.

#### **6.3 UI Testing**

- Ensure loaders, empty states, and error banners appear/disappear at correct times.
- Run accessibility audits (TalkBack/VoiceOver) for dispute/profile screens.

#### **6.4 Stability Testing**

- Stress-test with rapid navigation, backgrounding, airplane toggles, and force closes, ensuring queues recover.
- Record findings into `qa/stability/phase1_4_report.md`.

---

### **7. Completion Criteria for Phase 1-4**

- Dispute submission fully working
- Profile updates stable and synced
- All UI polished and consistent
- Error handling implemented
- Offline-resilient flows working
- Foreman mini-review interface live
- No major bugs or crashes

---

## 📌 End of Phase 1-4 Detailed Breakdown

---

## Storm Master Field App — Phase 1-5 Detailed Breakdown

**Document Version:** 1.0
**Prepared For:** Agentic AI and Copilot
**Prepared By:** Storm Master / Eugene Therrien
**Scope:** Phase 1-5 (formerly Week 5) — Testing, Optimization & QA
**Platforms:** Android + iOS
**Backend:** Laravel (API) + MySQL

---

## Phase 1-5 — Detailed Technical Breakdown

Phase 1-5 is where the Storm Master Field App transitions from “feature-complete” to **battle-tested, reliable, field-ready software**.
This phase combines:

- Stress testing
- Performance optimization
- Quality assurance
- Bug fixes
- Field testing preparation

> **Perspective:** Past phases shipped features; present focus is proof via regression, perf, and beta programs. Future deployment confidence comes from the artifacts produced here, so never separate testing from documentation—archive results and reference them in the plan.

---

### **1. Regression & Automation Harness**

#### **1.1 Unit + Integration Test Sweep**

- Audit existing unit tests (jobs, punches, sync, disputes) and raise coverage to ≥80% for core modules; log gaps in `qa/coverage_report.md`.
- Add integration tests that mock backend endpoints defined in `SM_APP_backend_wiring/MOBILE_BACKEND_INTEGRATION_SPEC.md` to validate payload compatibility.

#### **1.2 UI Automation**

- Expand Detox/Appium flows for punch creation, dispute filing, profile edits, crew monitoring, and offline/online toggles.
- Store scripts under `tests/e2e/phase1_5/` with README instructions so QA can run locally or in CI.

#### **1.3 Continuous Regression Runs**

- Configure CI to run the full suite on PR and nightly branches; capture artifacts (screenshots, logs) under `qa/artifacts/<build-id>/`.
- Fail builds if rollup drift, crash logs, or accessibility violations appear.

---

### **2. Performance & Reliability Optimization**

#### **2.1 Instrumentation**

- Embed lightweight telemetry (can be console/file logs if analytics not ready) measuring screen load times, sync durations, DB query counts.
- Write metrics to `logs/perf/<date>.json` for later review.

#### **2.2 Database & Memory Profiling**

- Profile SQLite queries using EXPLAIN to ensure indices on `jobs_local`, `punches_local`, `timesheet_rollups_local`, and `disputes_local` are used.
- Run memory snapshots during stress tests (50 job records, 200 punch events) and document results in `qa/perf_notes.md`.

#### **2.3 Rendering & Animation Tuning**

- Use React Native/Flutter profiling tools to identify dropped frames; address by memoizing heavy components, virtualizing long lists, and deferring non-critical renders.
- Validate improvements on low-end Android hardware.

---

### **3. QA Playbook & Bug Funnel**

#### **3.1 Triage Process**

- Stand up a `qa/bug_funnel.csv` tracking ID, severity, reproduction steps, logs, screenshots, fix owner, and status.
- Define SLA: Critical = 24h, High = 48h, Medium = 4 days, Low = backlog.

#### **3.2 Manual Test Matrix**

- Build scenario-based checklists (Punching, Sync, Disputes, Profile, Crew View, Offline flows) stored in `qa/checklists/phase1_5/*.md`.
- Include device/OS combos and pass/fail columns for sign-off.

#### **3.3 Accessibility & Localization Spot Checks**

- Validate dynamic text sizing, VoiceOver/TalkBack navigation, and ensure strings externalized in `content/strings.json`.
- Capture findings + fixes in `qa/a11y_report.md`.

---

### **4. Field Simulation & Beta Program**

#### **4.1 Simulated Field Days**

- Run scripted “workday” sessions covering morning clock-in, job hopping, breaks, disputes, and EOD sync; record screen + logs.
- Use location spoofing to test out-of-radius handling.

#### **4.2 Controlled Beta Release**

- Promote a signed build to a small crew group; supply onboarding doc stored at `docs/beta_playbook.md`.
- Capture feedback via shared spreadsheet and feed issues into bug funnel.

#### **4.3 Telemetry Review**

- Aggregate crash logs, sync failures, and battery impact metrics from beta devices; annotate anomalies in `qa/beta_findings.md` with proposed fixes.

---

### **5. Stabilization & Hardening**

#### **5.1 Crash & Exception Audits**

- Integrate Crashlytics/Sentry (or local log exporter) to capture stack traces; ensure no uncaught exceptions remain.
- For each crash, add regression tests or guard clauses.

#### **5.2 Security & Auth Review**

- Re-run JWT expiry handling, refresh logic, storage encryption, and logout flows.
- Confirm data wipes on logout and after failed PIN attempts (if implemented).

#### **5.3 Sync Chaos Testing**

- Force-kill app mid-sync, drop network, and simulate duplicate punches to ensure idempotency.
- Record outcomes in `qa/sync_chaos.md` and fix any data corruption paths.

---

### **6. Phase 1-5 Completion Criteria**

- Automated + manual regression suites run clean on CI with artifacts archived.
- Performance budgets met: job list load <1s from cache, sync drain <5s for 20 punches, app memory footprint <350MB during stress test.
- Bug funnel shows zero Critical/High open issues; Medium issues have mitigation plan.
- Beta reports confirm stability with documented feedback addressed or deferred.
- All findings, test evidence, and telemetry summaries uploaded to `qa/reports/phase1_5_summary.md` for leadership review.

---

## 📌 End of Phase 1-5 Detailed Breakdown

---

## Storm Master Field App — Phase 1-6 Detailed Breakdown

**Document Version:** 1.0
**Prepared For:** Agentic AI and Copilot
**Prepared By:** Storm Master / Eugene Therrien
**Scope:** Phase 1-6 (formerly Week 6) — Final Polish, Deployment, and Handoff
**Platforms:** Android + iOS
**Backend:** Laravel (API) + MySQL

---

## 🚀 Phase 1-6 — Detailed Technical Breakdown

Phase 1-6 completes the field app’s first full production cycle.
This phase focuses on:

- Final bug fixes
- Deployment packaging
- Documentation
- Build signing
- Distribution
- Developer handoff
- 30‑day post-launch support plan

> **Perspective:** Past QA/beta learnings drive the final polish. Present deliverables include builds, docs, and support readiness; future teams must inherit this history, so align testing evidence, release notes, and decision entries before calling the phase done.

This is the **release engineering phase**, ensuring the app is production-ready and stable.

---

## ✅ Phase 1-6: Final Polish, Deployment & Handoff (Detailed Steps)

---

### **1. Final Bug Pass & Polish**

#### **1.1 Collect & Triage Outstanding Bugs**

- Aggregate open issues from QA logs, field reports, Crashlytics/Sentry, and `qa/bug_funnel.csv`.
- Categorize Critical/High/Medium/Cosmetic with SLA (Critical 24h, High 48h, etc.).
- Tag each bug with originating module (Jobs, Punch, Timesheet, Profile, Crew) to spot hotspots.

#### **1.2 Fix UI & UX Edge Cases**

- Resolve layout shifts, tap targets <44px, text truncation, missing loaders/empty states, inconsistent themes.
- Audit light/dark parity and accessibility (font scaling) before marking story done.
- Document before/after screenshots in `qa/device_gallery/phase1_6/ui_polish/README.md`.

#### **1.3 Finalize Offline UX & Messaging**

- Confirm offline banner reliability, sync queue transparency, and absence of "stuck" spinners.
- Simulate low-signal, mid-sync drops, app backgrounding, and device restarts; ensure pending actions resume.
- Update troubleshooting section in `docs/support_playbook.md` with any discovered edge cases.

---

### **2. Performance Optimization**

#### **2.1 Optimize Database Access**

- Verify indices on jobs, punches, rollups, disputes; add compound indices for frequent filters (date + employee).
- Cache heavy lists (jobs, crew) with TTL + invalidation strategy documented in `SM_APP_backend_wiring/CACHE_STRATEGY.md` (addendum).
- Profile DB calls with EXPLAIN and log findings in `qa/perf_notes.md`.

#### **2.2 Reduce Re-renders & CPU Usage**

- Memoize expensive components, virtualize long lists, debounce search/filter inputs.
- Use profiling tools (Flipper/React DevTools or Flutter DevTools) to capture before/after frame timings.

#### **2.3 Lower App Startup Time**

- Lazy-load non-critical modules, prefetch auth/profile in parallel, and warm SQLite connections during splash screen.
- Compare cold vs warm start metrics and add to `qa/perf_notes.md`.

---

### **3. Deployment Preparation**

#### **3.1 Android Production Build Checklist**

- Generate release keystore, store in secrets vault, document alias/password rotation in `docs/release/android_keystore.md`.
- Configure `build.gradle` release block, versionCode/Name, proguard rules, and CI signing steps.
- Build AAB/APK via CI, upload to internal Play track, and run smoke tests on low-end Android, Android 10, 13+. Capture results in `qa/device_matrix_phase1_6.csv`.

#### **3.2 iOS Production Build Checklist**

- Set bundle identifier, signing certs, provisioning profiles, version/build numbers; automate via Fastlane where possible.
- Archive in Xcode, distribute to TestFlight (internal + external groups), run smoke tests on iPhone SE, XR, 12/13.
- Document signing assets in `docs/release/ios_signing.md`.

#### **3.3 Release Candidate Sign-off**

- Create RC tag (e.g., `phase1.6-rc1`), attach changelog, and capture QA sign-off checklist before promoting to production tracks.
- Ensure backend migrations (if any) deployed and confirmed before mobile release.

---

### **4. Documentation Package**

#### **4.1 Developer Documentation**

- Cover project structure, module responsibilities, local DB schema, sync engine, API endpoints/payloads, error handling, and feature flags.
- Ship as Markdown + optional PDF exported from `docs/` folder; include diagrams referencing `SM_APP_backend_wiring/ARCHITECTURE_DIAGRAM.drawio`.

#### **4.2 Build & Deploy Instructions**

- Step-by-step Android/iOS build guides (version bumps, signing, CI pipelines, store submission) stored in `docs/release/`.
- Include environment variable tables, keystore management, Fastlane/Firebase instructions, and rollback plan.

#### **4.3 QA Checklists & Evidence**

- Provide test cases, expected results, known edge cases, outage simulations, GPS validation steps in `qa/checklists/phase1_6/*.md`.
- Reference evidence folders (device gallery, logs) so auditors can verify.

---

### **5. Final Integration Review**

#### **5.1 API Contract Validation**

- Verify all `/api/mobile/*` endpoints live, payloads match spec, auth/JWT renewals stable, and sync flows (Punches, Jobs, Disputes, Profile) behave per Postman collections in `SM_APP_backend_wiring`.
- Run automated contract tests or Postman/Newman suite; capture report in `qa/reports/api_contract_phase1_6.json`.

#### **5.2 Data Integrity Check**

- Ensure no orphaned punches, missing job references, lost disputes, or incorrect timestamps through SQL checks (document queries in `SM_APP_backend_wiring/DATA_VALIDATION.sql`).
- Reconcile mobile rollups vs backend payroll for at least two weeks of fixtures.

#### **5.3 Production Trial Run**

- Perform simulated workday with multiple crews, offline/online transitions, GPS validation; log results and screenshots.
- Confirm no critical alerts in backend logs during trial.
- Simulate full workday
- Multiple crews punching
- Foreman using crew view
- Offline/online transitions
- GPS validation

---

### **6. Handoff & Release**

#### **6.1 Deliverables Checklist**

1. Full source code (mobile + backend integration folder) pushed to agreed repo.
2. Documentation package (developer docs, release guides, QA evidence) zipped under `handoff/phase1_6_docs.zip`.
3. Signed Android release build (.aab) + checksum + Play Console upload proof.
4. iOS TestFlight build + invite list + release notes.
5. Architecture + sync diagrams (Draw.io/PDF) including final DB schema snapshots.
6. API integration reference + Postman collections.

#### **6.2 30-Day Support Plan**

- Document support hours, response SLAs, release of hotfix builds, and escalation ladder in `docs/support_playbook.md`.
- Include contact info for backend + mobile leads.

#### **6.3 Ownership Transfer**

- Provide IP assignment statement, repo admin rights, artifact access (S3 buckets, CI pipelines), keystores/signing keys via secure channel.
- Confirm receipt and record in `handoff/ownership_receipt.md`.

---

### **7. Completion Criteria for Phase 1-6**

- App builds successfully on Android & iOS
- No critical or major bugs remain
- All Punch → Sync → Timesheet → Dispute → Profile flows stable
- Offline capability fully reliable
- Full documentation delivered
- Deployment builds signed and tested
- Handoff complete
- Ready for **Phase 2** planning

---

### 📌 End of Phase 1-6 Detailed Breakdown
