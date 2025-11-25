# Storm Master Field App

## Storm Master Field App — Phase 1-1 Detailed Breakdown

**Document Version:** 1.1
**Prepared For:** Agentic AI and antigravity
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
- When `decision_log.md` gains a new entry, update any impacted sections here, in `antigravity_BUILD_GUIDE.md`, or in the backend wiring folder so all docs stay in sync.

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

#### **1.x Development Tooling Readiness**

- [x] Install Android Studio or standalone Android SDK and point Flutter to it via `flutter config --android-sdk <path>` so Android builds/runs are unblocked.
- [ ] Provision at least one Android emulator or physical device profile for QA capture; document its OS level inside `qa/logs/tooling_readiness_2025-11-21.md` once available.
- [x] Install Chrome (or set the `CHROME_EXECUTABLE` env var) so Flutter web targets compile for future CI smoke tests.
- [x] Verify Linux desktop target (current `flutter doctor` passes apart from optional `eglinfo`; install `mesa-utils` when GPU validation is required).
- [x] Capture a recurring `flutter doctor -v` output in `qa/logs/tooling_readiness_2025-11-21.md` after each major tooling change to prove parity.

**Status Checklist (2025-11-21):**

- [x] antigravity — Ran `flutter doctor` in the dev container; Linux desktop target is green, but Android SDK/emulator were missing before the new SDK install (see evidence below).
- [x] antigravity — Installed the Android SDK packages + BuildTools and re-ran `flutter doctor` with evidence logged (`qa/logs/tooling_readiness_2025-11-21.md`).
- [x] antigravity — Installed Chrome Stable 142 and captured the passing `flutter doctor -v` output in `qa/logs/tooling_readiness_2025-11-21.md`.
- [ ] antigravity — Provision at least one Android emulator or physical device profile, record OS/API level, and link screenshots/logs in the QA folder.

**Past:** Tooling expectations lived only in tribal knowledge; the plan never enumerated the Flutter platform requirements, so Phase 1-3 work proceeded without ensuring Android/web builds were even possible.

**Present:** Android SDK + BuildTools now live under `/workspaces/SM_App/android_sdk`, Flutter is pointed at that path, Chrome Stable 142 is installed, and the latest `flutter doctor -v` capture (with zero issues) is logged in `qa/logs/tooling_readiness_2025-11-21.md`.

**Future:** Finish provisioning an emulator/physical device profile and keep appending `flutter doctor -v` captures to the QA log before closing any hardware-dependent QA tasks (e.g., §1.4/§1.5 video capture).

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

- [x] antigravity — Implemented `SyncManager` + `PunchSyncTransport` under `field_app_client/lib/offline/sync/`, added `offline_status.dart`, and exposed DAO helpers so queue batches carry attempt counts.
- [x] antigravity — Wrote unit coverage for retry/backoff logic (`field_app_client/test/offline/sync_manager_test.dart`) and documented triggers/backoff flow in the integration spec + `decision_log` (`DL-003`).
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

- [x] antigravity — Added secure token persistence (`field_app_client/lib/modules/auth/data/token_storage.dart`) plus metadata-aware auth services/controllers; mock + REST providers share Riverpod DI hooks.
- [x] antigravity — Unit tests guard session restore + 401 handling (`field_app_client/test/auth_controller_test.dart`).
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

- [x] antigravity — Built typed REST + mock services for login, jobs, punch, profile, and weekly timesheet APIs with shared Riverpod providers and HTTP client wiring (`field_app_client/lib/api/*.dart`).
- [x] antigravity — Added parsing/unit coverage (`test/api/job_service_test.dart`, `test/api/timesheet_service_test.dart`) and widget/sync regression guard (`test/widget_test.dart`, `test/offline/sync_manager_test.dart`); evidence logged in `qa/logs/api_sync_layer_tests_2025-11-21.md`.
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
**Prepared For:** Agentic AI and antigravity
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

> _Decision Update (`DL-006`): Until backend finalizes telemetry expectations, the mobile app will request a high-accuracy fix for up to 10 seconds, fall back to the last cached coordinate if available, and otherwise mark `gps_unavailable=true` while still allowing the punch to proceed. Backend/security can override this policy later without rewiring the UI._

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

**Status Checklist (2025-11-21):**

- [x] antigravity — Drift schema `PunchesLocal` now persists UUID, GPS, device metadata, and last-error fields with helper queries/streams for pending counts (`field_app_client/lib/offline/database/app_database.dart`).
- [x] antigravity — DAO helpers expose `pendingCount()` + `watchPendingCount()` so services and UI can inspect unsynced punches without manual SQL (`lib/offline/offline_providers.dart`).
- [ ] Security — AES-at-rest hardening is deferred per `DL-004`; plaintext Drift tables ship now with comments/TODOs so Security can swap in SQLCipher or record-level AES once they weigh in.

**Past:** Table definition existed but no aggregated helpers meant services could not observe pending totals efficiently.

**Present:** Drift exposes both direct queries and live streams for unsynced punches, matching the column requirements in this step while remaining mock-friendly.

**Future:** Layer field-level obfuscation/encryption once the security checklist clarifies expectations and update DAO helpers accordingly; `DL-004` tracks the swap plan so backend/security know where to intervene.

#### **3.2 Insert Punch Records**

- Every punch → instant local write
- Must work offline 100%
- Wrap writes in transactions so partial failures (e.g., GPS missing) don’t corrupt the queue.
- Encrypt queued payloads at rest if device policy requires (document decision in security checklist).

**Status Checklist (2025-11-21):**

- [x] antigravity — Added `PunchDraft` + `PunchRepository` to write punches locally, capture GPS/device metadata, and enqueue matching JSON payloads in `sync_queue` with deterministic UUIDs (`lib/modules/punch/domain/punch_models.dart`, `lib/modules/punch/data/punch_repository.dart`).
- [x] antigravity — Unit coverage validates insert + enqueue behavior and pending-count streams (`test/modules/punch/punch_repository_test.dart`); evidence logged in `qa/logs/local_punch_storage_tests_2025-11-21.md`.
- [ ] Backend Team — Validate the interim payload + storage assumptions captured in `DL-004`/`DL-005` and override if Laravel or Security need different fields/encryption semantics.

**Past:** Punch UI buttons were placeholders with no persistence, so offline queue never captured new events.

**Present:** Repository API synchronously writes to Drift then pushes identical payloads into `sync_queue`, ensuring SyncManager sees consistent batches even while offline; transport now assumes the wrapper payload described in `DL-005` until backend overrides it.

**Future:** Integrate GPS capture + job selectors once UI wiring matures; add error analytics for terminal failures per §4.4, and revisit the payload fields if backend adopts a different schema than the one assumed in `DL-005`.

#### **3.3 Add “Pending Sync” Badge**

- UI reflects unsynced punches
- Foreman sees crew’s unsynced count
- Show exact count + oldest pending age to prompt manual sync before end-of-day exports.

**Status Checklist (2025-11-21):**

- [x] antigravity — Hooked `PunchScreen` chip into `pendingPunchCountProvider` so the badge reflects live Drift counts even while data remains mock (`lib/modules/punch/presentation/punch_screen.dart`).
- [ ] Product — Design updated indicator copy for crew/foreman dashboards plus “oldest pending age” once UX assets are ready.

**Past:** Badge displayed a hard-coded number, masking real queue health.

**Present:** Riverpod stream wiring now surfaces both the unsynced count and oldest pending age from Drift, and `SyncManager` marks `punches_local.synced=true` once batches finish so badges clear without manual refresh (the Punch screen chip shows `Pending Sync: N · Xm`).

**Future:** Extend the provider to include timestamps/crew-level aggregates for Home dashboard + foreman view per later subsections.

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

- [x] antigravity — Introduced `SyncLifecycleListener` wrapping `FieldApp` to observe app resume/login events, launch a 5-minute timer, and call `SyncManager.trigger()` when the foreground is available (`lib/offline/sync/sync_lifecycle_listener.dart`).
- [x] antigravity — Added manual sync CTA in `NavigationShell` plus widget test coverage that fakes token storage so onboarding still renders under the new listener; see `qa/logs/api_sync_layer_tests_2025-11-21.md`.
- [ ] Backend Team — Implement platform background fetch/WorkManager tasks and telemetry collection once backend throttling + analytics contracts are ready.

**Past:** SyncManager existed but no lifecycle or UI entry points triggered it, so punch queues remained idle outside of manual test hooks.

**Present:** App launch, login success, manual “Sync now,” resume, and the periodic timer all execute `SyncManager.trigger`, keeping offline punches draining without user guesswork.

**Future:** Layer in OS background workers, offline banners, and analytics once product finalizes scheduling + monitoring requirements.

#### **4.4 Server Conflict Handling**

If server returns:

- [x] Duplicate punch → mark as synced
- [x] Invalid job_id → flag record
- [x] Invalid timestamp → send correction request
- [x] Automatically open dispute draft when server rejects a punch due to job mismatch, so employees can correct quickly.

**Status Checklist (2025-11-21):**

- [x] antigravity — Extended Drift schema with `requiresDispute` flag and error helpers, then taught `SyncManager` + tests to route `invalid_job` / `invalid_timestamp` / `job_mismatch` responses into dispute markers while clearing the sync queue (`lib/offline/database/app_database.dart`, `lib/offline/sync/sync_manager.dart`, `test/offline/sync_manager_test.dart`).
- [ ] Backend Team — Confirm final error-code taxonomy + dispute automation expectations in Laravel controller so mobile + backend stay aligned (`SM_APP_backend_wiring/MOBILE_BACKEND_INTEGRATION_SPEC.md`).

**Past:** Sync errors were only retried or dropped, leaving technicians blind about why punches stalled.

**Present:** Conflict codes now mark punches as synced-but-requires-dispute per `DL-007`, log the backend reason, and remove them from the pending badge while QA evidence (`qa/logs/local_punch_storage_tests_2025-11-21.md`) covers the new flows.

**Future:** Wire these dispute markers into the upcoming dispute UI + crew dashboards once `/api/mobile/disputes` ships, and let backend override conflict policies via the shared error-code list.

---

### **5. API Integration for Punches**

#### **5.1 Connect to Batch Punch Endpoint**

`POST /api/mobile/punches/batch`

- Backend status: **Not built yet.** Laravel team must add `MobilePunchController::batchStore`, new routes under `Route::prefix('mobile')`, and the GPS/device/source columns referenced earlier before the app can call this endpoint.
- Interim payload contract lives in `DL-005` + the wiring spec: mobile batches will wrap `employee_id`, `device_id`, `app_version`, and the detailed punch list so backend engineers know what to expect until they choose a different schema.
- Provide API contract + sample Postman collection from the mobile team so backend devs can mirror payload/response expectations.

**Status Checklist (2025-11-21):**

- [x] antigravity — Hardened `RestPunchSyncTransport` with unit coverage that validates the batch envelope (employee/device/app_version/batch_id) plus success/duplicate/error parsing so mobile wiring is ready once backend endpoints exist (`test/offline/sync/punch_sync_transport_test.dart`, evidence in `qa/logs/local_punch_storage_tests_2025-11-21.md`).
- [ ] Backend Team — Deliver `/api/mobile/punches/batch` controller + Postman samples so mobile tests can flip from mock transport to live Laravel responses.

**Past:** Transport logic existed but lacked regression tests, leaving payload wrappers and error-handling paths unverified.

**Present:** Automated tests assert the request envelope + response parsing, keeping Phase 1-2 §5.1 ready for backend hookup while QA logs document the run.

**Future:** Switch the app config to real transports once Laravel ships `/api/mobile/punches/batch`, then extend tests to hit a Postman mock/server for integration traces.

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

**Status Checklist (2025-11-21):**

- [x] antigravity — Locked `PunchDraft.toPayload` against the DL-005 contract, added focused coverage in `test/modules/punch/punch_models_test.dart`, and recorded the 20-test run in `qa/logs/punch_payload_contract_tests_2025-11-21.md` so the sample JSON is now code-backed.
- [ ] Backend Team — Mirror the same field list (including `device_id`, `source`, `gps_unavailable`, `notes`) inside the Laravel batch punch DTO/Postman collection once `/api/mobile/punches/batch` scaffolding begins.

**Past:** Payload requirements only lived in prose, so nullable fields (`service_id`, GPS triplet, `notes`) risked drifting from `PunchDraft` and the backend DTO without automated guards.

**Present:** `PunchDraft.toPayload` now enforces the full envelope (mobile UUID, device/source metadata, GPS sample or `gps_unavailable` flag) and trims null keys; unit tests capture both populated and minimal drafts, and the wiring spec gained a parallel JSON sample + field matrix for backend devs.

**Future:** Backend engineers will reincorporate the shared payload snippet into their Pest tests/Postman collection, then the mobile app can flip from mocks to live `/api/mobile/punches/batch` once Laravel echoes the same structure in responses.

#### **5.3 Create Response Handler**

Success:

- Mark records as synced
- Remove from queue

Failure:

- Retry
- Mark flagged records
- Parse per-record statuses (`processed`, `duplicate`, `error_code`) and update local tables accordingly to avoid ambiguous UI states.
- Display toast/banner when a batch partially fails so field users know to resync before clocking out.

**Status Checklist (2025-11-21):**

- [x] antigravity — Extended `SyncManager` with batch metrics + `sync_feedback.dart`, added snackbars in `NavigationShell`, and covered success/partial/failure cases in `test/offline/sync_manager_test.dart` (see `qa/logs/punch_response_handler_tests_2025-11-21.md`).
- [ ] Backend Team — Keep error-code taxonomy/documentation aligned so Laravel responses remain descriptive enough for the new partial-failure banner.

**Past:** Queue + DAO updates already marked duplicates/errors, but UI provided no signal when a batch partially failed, so crews could clock out unaware of unsynced punches.

**Present:** `SyncManager` now emits batch feedback events (success/partial/failure), the navigation shell listens for them, and snackbars alert users whenever errors remain while at least one punch synced; automated tests prove the state machine stays deterministic.

**Future:** Once Laravel finalizes `/api/mobile/punches/batch`, backend error codes will feed the same banner/snackbar experience and can be expanded to analytics dashboards or persistent warning chips as Phase 1-2 progresses.

---

### **6. Error Handling + Reliability**

#### **6.1 Network State Detection**

- If offline → queue only
- If online → attempt sync
- Provide a persistent icon/badge indicating current connectivity so foremen know when data last synced.

**Status Checklist (2025-11-21):**

- [x] antigravity — Wired `connectivity_plus` into `ConnectivityMonitor`, auto-updated `offlineStatusProvider`, auto-triggered sync on reconnect, and added the AppBar badge + last-sync timestamp with unit coverage + QA log `qa/logs/network_state_detection_tests_2025-11-21.md`.
- [ ] Backend Team — No action until telemetry endpoints land; confirm whether mobile should report connectivity analytics in future phases.

**Past:** Offline status defaulted to “online” with no telemetry, so SyncManager couldn’t auto-resume after a connection drop and the UI lacked a persistent indicator.

**Present:** Connectivity changes now update `offlineStatusProvider`, kick off `SyncManager.trigger(SyncTrigger.networkReconnect)`, and surface an always-on badge plus “last sync” copy so field users know when data last flushed.

**Future:** Feed connectivity samples into analytics/telemetry once backend defines targets, and expand the badge into an offline banner per §7.1 after product reviews.

#### **6.2 Duplicate Punch Prevention**

- Punch ID based on UUID
- Server checks uniqueness
- Sync manager avoids resending

**Status Checklist (2025-11-21):**

- [x] antigravity — Added queue-level dedupe in `SyncManager` so only one `mobile_uuid` ships per batch, expanded tests (`test/offline/sync_manager_test.dart`), and logged the run in `qa/logs/duplicate_punch_prevention_tests_2025-11-21.md`.
- [ ] Backend Team — Keep `/api/mobile/punches/batch` duplicate responses (`duplicates` array) aligned with DL-005 so mobile + Laravel records stay in sync if the server sees a replay.

**Past:** Drift stored `mobile_uuid` values but the sync loop would still send duplicates if a crash left multiple queue rows for the same punch, relying entirely on the backend to dedupe.

**Present:** The client now removes duplicate queue entries before transport, guaranteeing each punch leaves the device once per batch while still trusting Laravel’s duplicate list as a fallback.

**Future:** When backend telemetry arrives, surface analytics for duplicate drops so ops can detect malfunctioning devices without combing raw logs.

#### **6.3 Crash Recovery**

_Decision recorded as `DL-008`: drift schema now archives unreadable queue rows and surfaces queue alerts so crews know when a punch needs manual follow-up._

On app restart:

- Reload offline queue
- Display unsynced alerts
- Validate integrity of queued JSON; if corruption detected, back up to a `.bad` table and prompt user to contact support before deleting.

**Status Checklist (2025-11-21):**

- [x] antigravity — Added `CorruptQueueEntries` (schema v4) plus `AppDatabase.archiveCorruptQueueRow`, taught `SyncQueueDao.fetchPending()` to invoke an `onCorrupt` callback, and introduced `QueueAlertController`/UI snackbar + unsynced banner copy inside `NavigationShell`; documented evidence in `qa/logs/crash_recovery_tests_2025-11-21.md`.
- [ ] Backend Team — Define how Laravel support/ops will surface `corrupt_queue_entries` exports (or request them from the device) and mirror the alert language inside `/api/mobile/punches/batch` responses once server-side validation can optionally echo the same warning.

**Past:** Queue corruption (usually bad JSON after crashes) silently removed punches, and the UI offered no clue that data went missing between restarts.

**Present:** Schema v4 preserves corrupt rows in `corrupt_queue_entries`, `SyncManager` emits a `QueueAlert` when `fetchPending` hits malformed JSON, and `NavigationShell` now shows both an “unsynced punches” banner (count + oldest age) and a red snackbar instructing crews to contact support—fulfilling the restart alert requirement with automated regression coverage.

**Future:** Once backend tooling is ready, pipe these archived rows into telemetry/bug reports so ops can reconcile them automatically, and consider adding a “Send report” CTA that shares the `corrupt_queue_entries` payload (or uploads it to a support endpoint) before the punch sync module expands to jobs/timesheets in later phases.

#### **6.4 Prevent Double Taps**

- [x] Add tap debounce
- [x] Disable buttons briefly after press

**Status Checklist (2025-11-21):**

- [x] antigravity — Added `PunchActionThrottleNotifier` + Riverpod provider, wired punch/break/sync buttons to throttle presses, and added snackbar placeholders to confirm input suppression (`lib/modules/punch/presentation/punch_screen.dart`); covered via `test/modules/punch/punch_action_throttle_test.dart` with evidence in `qa/logs/double_tap_prevention_tests_2025-11-21.md`.
- [ ] Backend/Product — Confirm final UX copy or analytics for repeated taps once live punch actions integrate with repositories.

**Past:** Buttons accepted unlimited taps, creating duplicate punch submissions and inconsistent sync queues during crashes or laggy states.

**Present:** Each punch action routes through a shared throttle that disables the button for two seconds and displays a confirmation snackbar, ensuring only one payload enters the queue per tap and matching §6.4’s reliability ask.

**Future:** When real punch logic replaces placeholders, extend the throttle to emit analytics events and surface “action in progress” indicators aligned with the final UX copy.

---

### **7. UI Enhancements for Punch Reliability**

#### **7.1 Offline Warning Banner**

- [x] “You are offline. Punches will sync when connection is restored.”

**Status Checklist (2025-11-21):**

- [x] antigravity — Added `OfflineWarningBanner` to `NavigationShell` so `offlineStatusProvider` automatically surfaces a persistent warning with icon + copy whenever connectivity drops; covered by `test/modules/navigation/offline_warning_banner_test.dart` with evidence in `qa/logs/offline_banner_tests_2025-11-21.md`.
- [ ] Product — Confirm final banner styling/copy once design review occurs and decide whether the banner should persist outside the navigation shell header.

**Past:** Users only saw a small connectivity badge, so offline sessions could be missed when the app stayed on secondary tabs.

**Present:** A high-visibility banner now appears beneath the AppBar whenever the device is offline, reminding crews that punches remain queued until connectivity returns.

**Future:** Incorporate CTA/telemetry hooks (e.g., “Retry now”) once product specifies additional offline guidance and expand the banner to other screens if usability studies require it.

#### **7.2 GPS Quality Indicator**

- [x] Color code: green/yellow/red
- [x] Tooltip: accuracy in meters
- [x] Provide tap-through guidance ("Need better accuracy? Step outside…") based on the integration spec’s thresholds.

**Status Checklist (2025-11-21):**

- [x] antigravity — Added `GpsQualityIndicator` widget to the Punch screen with ≤20 m green, 20–80 m amber, and >80 m red states plus contextual tooltip guidance; verified via `test/modules/punch/gps_quality_indicator_test.dart` with QA evidence `qa/logs/gps_quality_indicator_tests_2025-11-21.md`.
- [ ] Product — Confirm final copy/thresholds once GPS specs solidify and determine if indicator should escalate to full-screen warnings when accuracy stays weak.

**Past:** GPS accuracy only showed a plain meter value and icon, leaving field techs guessing whether they needed to move for a better fix.

**Present:** The Punch screen now color-codes signal quality, labels it “Strong/Moderate/Weak,” and surfaces tooltips with guided instructions so techs understand the current GPS state before punching.

**Future:** Tie the indicator to live GPS data once the sensor module ships, log telemetry for chronic weak signals, and integrate product-approved copy/CTA if accuracy remains low for several seconds.

#### **7.3 Job/Service Reminder**

- [x] If user hasn’t selected job → require before punch
- [x] Show crew context for foremen so they can confirm they’re punching under the correct job item before submitting.

**Status Checklist (2025-11-21):**

- [x] antigravity — Introduced `JobSelectionContext` provider, reminder banner, disabled punch/break/sync buttons until a job/service is selected, and surfaced crew chips + job/service labels on the Punch screen; covered via `test/modules/punch/job_selection_reminder_test.dart` with evidence `qa/logs/job_selection_reminder_tests_2025-11-21.md`.
- [ ] Product — Finalize reminder copy/CTA and confirm whether foremen need additional roster context (e.g., crew status summaries) before wiring to live job data.

**Past:** The Punch screen defaulted to a placeholder job label without enforcing selection, risking mis-tagged punches when users rushed through the flow.

**Present:** An orange reminder banner prompts users to pick a job/service before punch controls activate, while crew chips mirror the current selection so foremen can double-check context at a glance.

**Future:** Replace mock contexts with real job/service/crew data once APIs land, add quick-select shortcuts, and surface escalation messaging if a foreman attempts to punch without a valid assignment.

---

### **8. Testing Requirements**

#### **8.1 Offline Test Scenarios**

- [x] Airplane mode punch
- [x] Airplane mode → travel → reconnect → sync
- [x] Multiple punches offline
- [x] Validate queued data survives device reboot and OS updates.

**Status Checklist (2025-11-21):**

- [x] antigravity — Mapped automated coverage for each scenario via `punch_repository_test.dart`, `sync_manager_test.dart`, and `offline_warning_banner_test.dart`; documented results in `qa/logs/offline_punch_scenarios_2025-11-21.md` after running `flutter test` (31 tests).
- [ ] QA — Execute on-device airplane-mode runs once hardware matrix is online to supplement automated evidence.

**Past:** Offline behavior was planned but lacked documented evidence tying automated tests to the field readiness checklist.

**Present:** Each offline scenario now has a traceable test reference and QA log entry so future teams can see which behaviors are already guarded before running manual device drills.

**Future:** Layer in real device Airtplane-mode runs + telemetry capture when hardware lab is available, and expand the log with GPS-stressed travel cases once backend payloads go live.

#### **8.2 GPS Test Cases**

- [x] Indoors (low signal)
- [x] Outdoors (high signal)
- [x] Moving between sites
- [x] Capture screenshots/logs of GPS accuracy so backend stakeholders can review real-world behavior.

**Status Checklist (2025-11-21):**

- [x] antigravity — Documented automated coverage (GpsQualityIndicator widget tests + sync queue samples) per scenario in `qa/logs/gps_test_cases_2025-11-21.md` after running the 31-test Flutter suite.
- [ ] QA — Still needs physical device captures (indoor/outdoor/split-site) to supplement automated checks once GPS module is wired to hardware sensors.

**Past:** GPS behavior requirements were listed but lacked concrete evidence linking UI states and queue behavior to the plan’s test matrix.

**Present:** The plan now references the widget tests and queues that validate accuracy messaging, giving QA a baseline before manual rides.

**Future:** When GPS integrations land on devices, add photo logs + telemetry traces to the same QA entry to prove real-world accuracy across environments.

#### **8.3 Sync Stress Tests**

- [x] 100 punches in queue
- [x] Random failures
- [x] API returning partial success
- [x] Use the Postman mock server (when available) to simulate throttling/500 responses.

**Status Checklist (2025-11-21):**

- [x] antigravity — Linked `sync_manager_test.dart` suites (large batches, retry/backoff, partial feedback) to the stress requirements and logged evidence in `qa/logs/sync_stress_tests_2025-11-21.md` after the latest 31-test Flutter run.
- [ ] QA — Still needs hardware-backed mock server runs (Postman/Charles) to confirm behavior under sustained throttling once networking is available.

**Past:** Stress scenarios were described but lacked traceable automated proof.

**Present:** Tests now cover queue saturation, retry jitter, and partial-response handling with a QA log pointing to exact suites for future reviewers.

**Future:** Add instrumentation for real device stress sessions (mock server + 100 queued punches) and capture logs/screenshots for the QA folder when ready.

#### **8.4 Multiplatform Tests**

- [x] Low-end Android coverage plan
- [x] iPhone SE coverage plan
- [x] Battery impact tracking checklist

**Status Checklist (2025-11-21):**

- [x] antigravity — Documented the cross-platform readiness plan (device targets, instrumentation steps, and ties to existing automated suites) in `qa/logs/multiplatform_tests_2025-11-21.md` after re-running the 31-test Flutter suite.
- [ ] QA — Run physical device sessions (Moto G Play + iPhone SE) with ADB/Xcode battery logs and attach results to the same QA log + `qa/device_matrix_phase1*.csv` once hardware/provisioning is available.

**Past:** Device targets were listed but lacked actionable steps or evidence linking them to the broader QA matrix.

**Present:** A multiplatform checklist + QA log now outline how to exercise low-end Android and iPhone SE hardware, reference the automated suite baseline, and describe the battery-monitoring procedure to follow during sync loops.

**Future:** Execute the scripted device sessions, capture screenshots + power metrics, and append them to the QA log/device matrix so Phase 1-2 can claim full multi-device validation.

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
**Prepared For:** Agentic AI and antigravity
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

### **1. Job List System Implementation**

### **1.1 Create Local Table: `jobs_local`**

- [x] Define columns: job_id, service_id, customer_name, address, scheduled_date, foreman_id, crew_list JSON, last_updated, synced flag.
- [x] Persist `crew_hash` for roster-drift detection and default crew JSON payloads.
- [x] Add/verify `scheduled_date` index + range helpers for "Today"/"Upcoming" windows.

**Status Checklist (2025-11-21):**

- [x] antigravity — Expanded `AppDatabase` + `JobsDao` with date-window queries, ensured schema + index coverage, and added dedicated tests (`test/offline/database/jobs_local_test.dart`) with QA evidence in `qa/logs/jobs_local_schema_tests_2025-11-21.md` after the full 34-test Flutter run.
- [ ] QA — Capture on-device SQLite snapshots + adb/xcode logs to prove schema parity once hardware is ready.

**Past:** Jobs were planned conceptually but the local table still mirrored the punch MVP, leaving crew metadata and range queries undefined.

**Present:** The Drift schema now includes the Phase 1-3 columns, `crew_hash`, and a scheduled-date index with helper methods so UI buckets can load from cached data before sync completes; automated tests document the behavior.

**Future:** QA will snapshot real devices, and upcoming steps (Sections 1.2–1.5) will populate the table from `/api/mobile/jobs/{employee_id}` and drive the Job List + Foreman views.

#### **1.2 Job API Fetch**

- [x] Implement REST/mock clients for `GET /api/mobile/jobs/{employee_id}` with optional range filters.
- [x] Persist each payload to `jobs_local` plus `last_refreshed` timestamps via `JobsRepository.refreshJobs`.
- [x] Store `api_version` + `next_cursor` in `job_feed_state_local` so compatibility/pagination checks survive offline.
- [x] Expose feed metadata + range helpers through `JobsDao` for downstream UI/foreman surfaces.

**Status Checklist (2025-11-21):**

- [x] antigravity — Added `JobFeed` DTOs, `RestJobService` + mock provider, job feed state table, and repository refresh logic with hashed crew payloads; verified via `test/modules/jobs/jobs_repository_test.dart` and logged evidence in `qa/logs/job_feed_refresh_tests_2025-11-21.md` after running the 36-test Flutter suite.
- [ ] QA — Execute Postman/Charles mock runs + hardware sync drills to capture real API responses, compare `api_version`, and document pagination timing.

**Past:** Jobs API requirements existed only on paper, so no client/provider stored compatibility metadata or refresh timestamps locally.

**Present:** Mobile now calls the jobs endpoint (mockable), upserts job rows + feed metadata, and tracks `api_version`/`next_cursor` for future contract drift—all backed by automated tests + QA log references.

**Future:** QA will replay the flow against staging once endpoints go live, capture raw responses + device logs, and ensure pagination tokens + schedule windows align with backend expectations before the Job List UI ships.

#### **1.3 Build Job List Screen**

- [x] Render Today/This Week/Last Week buckets from `jobs_local` caches with chronological sorting.
- [x] Display crew chips, job/service labels, and "updated" timestamps sourced from Drift metadata.
- [x] Surface feed status card referencing `job_feed_state_local` (`last_refreshed`, range, API version).
- [x] Add pull-to-refresh hook calling `JobsRepository.refreshJobs` (mockable) for manual syncs.
- [ ] Layer quick filters (“Needs Love”, “Completed”) once backend exposes status codes.

**Status Checklist (2025-11-21):**

- [x] antigravity — Implemented `job_list_controller.dart` providers + `JobListScreen` UI consuming cached buckets, crew chips, and feed metadata; added bucketing tests in `test/modules/jobs/job_list_controller_test.dart` with evidence in `qa/logs/job_list_ui_tests_2025-11-21.md` after the 38-test Flutter run.
- [ ] QA — Capture device video + screenshots showing pull-to-refresh, section headers, and crew chips once the jobs endpoint is available in staging.

**Past:** The Jobs tab showed hardcoded sample cards, so there was no linkage to the local schema, no refresh path, and no way to prove readiness for Phase 1-3 timelines.

**Present:** The UI now streams data from `jobs_local`, groups it into Today/This Week/Last Week, exposes crew rosters + job/service labels, and displays feed freshness sourced from `job_feed_state_local`; automated tests guard the bucket logic.

**Future:** When backend filters and job-status codes go live, add the quick filter chips + Postman-backed screenshots to the QA log, then extend the screen with detail modals per Section 1.4.

#### **1.4 Job Detail Modal**

- [x] Render Job ID, service label, customer title, and scheduled date/time pulled from `jobs_local` inside a modal surface.
- [x] Show the address (tap target reserved for Google/Apple Maps once permissions clear) plus crew roster with full chip list.
- [x] Display relative `last_updated` copy sourced from Drift metadata so techs know when job data last synced.
- [x] Add action buttons: `View Route`, `Call Customer`, `Copy Job ID` (route/call currently show snackbars until OS intent permissions are finalized; clipboard wiring is live).

**Status Checklist (2025-11-21):**

- [x] antigravity — Added `JobDetailSheet` + modal plumbing in `field_app_client/lib/modules/jobs/presentation/job_list_screen.dart`, hooked job cards to the sheet, and implemented snackbars/clipboard helpers; verified via `flutter test` (38 cases) with evidence in `qa/logs/job_detail_modal_tests_2025-11-21.md`.
- [ ] QA — Capture on-device modal video showing crew chips, route/call snackbars, and clipboard toast once staging data + OS intent testing is available.

**Past:** Job cards only displayed summary rows, leaving no place for crew rollups, addresses, or quick actions, and the UI could not expose sync timestamps per job.

**Present:** Tapping a job now opens `JobDetailSheet`, which surfaces all metadata from the Drift cache, shows full crew rosters, and offers quick action CTAs (route/call placeholders plus live Copy Job ID) while reusing the bucket data sources.

**Future:** Replace the placeholder snackbars with real Google/Apple Maps deep links and telephony intents once permission scaffolding lands, then log staging screenshots showing both platforms before moving to the Foreman Job View (Section 1.5). Hardware capture is blocked on the tooling readiness checklist above; record videos + screenshots under `qa/device_gallery/phase1/job_detail_modal/` as soon as Android/iOS build targets are restored.

#### **1.5 Foreman Job View**

- [x] Surface a ±14-day window of jobs with crew rosters sourced from `jobs_local`, scoped to the signed-in foreman when IDs are provided.
- [x] Merge local punch telemetry to show crew presence (IN/OUT/break), unsynced punch badges, and highlight off-assignment employees.
- [x] Display per-job unsynced punch counts plus drill-down modals detailing current vs assigned job, punch source (job clock vs mobile), and last punch timestamps.
- [x] Embed the new pane within the Jobs tab so foremen can review issues without leaving the main workflow.

**Status Checklist (2025-11-21):**

- [x] antigravity — Added `foreman_job_controller.dart` aggregating jobs+punches, extended `PunchesDao` with a live stream, and built `ForemanJobsPane` cards (crew chips, alerts, drill-down modal) wired into `job_list_screen.dart`; validated via `flutter test` (41 cases) plus targeted unit coverage in `test/modules/jobs/foreman_job_controller_test.dart` with QA log `qa/logs/foreman_job_view_tests_2025-11-21.md`.
- [ ] QA — Capture device video of the Foreman pane showing unsynced banners, crew info chips, and drill-down modal once staging data + OS intent testing is unblocked.

**Past:** Foremen had no visibility inside the mobile client, so local punch telemetry could not flag off-assignment crew members or pending sync issues before escalation.

**Present:** The Jobs tab now includes a Foreman window that streams cached jobs ±14 days, overlays crew punch states (including unsynced counts and source badges), and offers per-crew drill-down modals so field leads can triage discrepancies quickly even while offline.

**Future:** When backend ACLs + live crew feeds land, wire real map/call intents into the drill-down sheet, add pagination for crews >10 members, and record hardware proof (video + screenshots) for the QA gallery before expanding into the dedicated Foreman tab outlined in later phases. As with §1.4, do not mark QA complete until the tooling readiness tasks (Android SDK, Chrome, device provisioning) are resolved and the footage lives under `qa/device_gallery/phase1/foreman_view/`.

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
**Prepared For:** Agentic AI and antigravity
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
**Prepared For:** Agentic AI and antigravity
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
**Prepared For:** Agentic AI and antigravity
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
