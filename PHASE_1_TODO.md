# Phase 1 TODO List

**Last Updated**: November 25, 2025  
**Status**: Tracking pending items from Phase 1-1 through 1-3

---

## 🎯 Critical Blockers

### Missing Database Table

- [ ] **Create `TimesheetLocal` table** in Drift schema
  - Required for Phase 1-3 Section 2 (Timesheet Engine)
  - Should include: employee_id, week_start, week_end, daily aggregations, totals
  - Reference: `punches_local` table structure for pattern
  - **Impact**: Blocks entire Timesheet feature

---

## 📱 Mobile App TODOs

### Phase 1-1: Project Setup & Foundations

#### Section 2.3: Authentication

- [ ] Wire to live Laravel `/api/mobile/login` endpoint (currently using mock)
- [ ] Add biometric unlock support
- [ ] Implement token expiry reminders
- [ ] Document logout hooks once backend refresh/blacklist strategy finalizes

#### Section 3.2: Navigation

- [ ] Add deep-link placeholders (e.g., `stormmaster://timesheet/today`)
- [ ] Include analytics hooks for tab changes
- [ ] Wire telemetry once routing strategy is finalized

#### Section 4.2: API Specs

- [ ] Create Postman collection for all `/api/mobile/*` endpoints
- [ ] Store in `SM_APP_backend_wiring/postman/`
- [ ] Add unhappy-path test cases (401, 422, 500)

#### Section 4.3: API Services

- [ ] Replace mock flags when `/api/mobile/*` endpoints go live
- [ ] Add dispute service module
- [ ] Add crew service module
- [ ] Extend tests for unhappy-path 401/422 responses
- [ ] Add telemetry hooks

### Phase 1-2: Offline Punching System

#### GPS Integration

- [x] ~~GPS service implementation~~ ✅ COMPLETE (Android only)
- [ ] **iOS GPS permissions** - Add to `ios/Runner/Info.plist`:

  ```xml
  <key>NSLocationWhenInUseUsageDescription</key>
  <string>Storm Master needs your location to verify job site punches.</string>
  ```

  - **Note**: Requires Apple Developer account (Eugene has no Apple devices)
  - **Priority**: LOW (Android-first deployment)

#### Sync Engine

- [ ] Wire triggers to real lifecycle hooks (background services)
- [ ] Emit analytics for permanently dropped punches
- [ ] Expand engine to jobs/timesheets in later phases

### Phase 1-1: Device Testing & Verification

#### Section 5.1: Device Matrix

- [x] ~~Modern Android emulator~~ ✅ COMPLETE (API 36 running)
- [ ] Low-end Android physical device (for performance testing)
- [ ] iPhone XR or newer (when iOS development starts)
- [ ] iPhone SE for small screen testing
- [ ] Create compatibility spreadsheet with OS versions (min + target)

#### Section 5.2: Debug Tools

- [x] ~~Flutter DevTools~~ ✅ Available
- [x] ~~Android Studio logs~~ ✅ Working
- [ ] Configure remote logging (Sentry/Firebase) with prod credentials
- [ ] iOS Xcode console (when iOS development starts)

#### Section 5.3: Test Build

- [x] ~~Android APK build~~ ✅ COMPLETE
- [ ] Capture build artifacts (APK) for stakeholder validation
- [ ] Set up automated build process
- [ ] iOS IPA build (when iOS development starts)

#### Section 6.1: Platform Compilation

- [x] ~~Android build working~~ ✅ COMPLETE
- [x] ~~Web build working~~ ✅ COMPLETE
- [ ] Fix Linux GTK deprecation issue (low priority)
- [ ] Configure CI/Nightly scripts for automated builds
- [ ] iOS build (when iOS development starts)

#### Section 6.3: API Contract Approval

- [ ] **Obtain written approval from Eugene** for:
  - Endpoint list in `MOBILE_BACKEND_INTEGRATION_SPEC.md`
  - Payload structures
  - Authentication rules
  - Versioning strategy
- [ ] Document approval in email or meeting notes
- [ ] Share with vendor team once approved

---

## 🖥️ Backend TODOs (Vendor Team)

### Database Schema Changes

- [ ] Extend `time_cards` table with:
  - `gps_lat` (decimal)
  - `gps_lng` (decimal)
  - `gps_accuracy` (decimal)
  - `source` (varchar: 'mobile_app', 'job_clock')
  - `device_id` (varchar)
  - `gps_unavailable` (boolean)

### API Endpoints to Implement

- [ ] `POST /api/mobile/login` - Wrap existing JWT flow + log device metadata
- [ ] `GET /api/mobile/jobs/{employee_id}` - Employee/foreman job feed
- [ ] `POST /api/mobile/punches/batch` - Batch insert with UUID deduplication
- [ ] `GET /api/mobile/timesheet/week/{employee_id}` - Weekly aggregation
- [ ] `GET /api/mobile/profile/{id}` - Read profile data
- [ ] `PUT /api/mobile/profile/{id}` - Update profile (whitelist: phone, address, image)
- [ ] `POST /api/mobile/disputes` - Create disputes
- [ ] `GET /api/mobile/disputes/{employee}` - Dispute history + comments
- [ ] `GET /api/mobile/crew/status/{foreman_id}` - Crew roster + live punch snapshot

### Backend Implementation Details

- [ ] Mirror exponential backoff + duplicate handling rules in Laravel
- [ ] Surface `processed`, `duplicates`, `errors` arrays in batch response
- [ ] Log every rejected punch with mobile UUID, employee ID, and reason
- [ ] Honor `Authorization: Bearer` headers with immediate 401 on failure
- [ ] Implement per-record status in batch punch engine
- [ ] Add logging + monitoring for `mobile_uuid`, `device_id`, GPS accuracy

### Testing & Documentation

- [ ] Create Pest/PHPUnit tests in `tests/Feature/Mobile`
- [ ] Publish Postman collection
- [ ] Add README to `SM_APP_backend_wiring/`
- [ ] Run automated tests and share results with mobile team

---

## 🧪 QA & Testing TODOs

### Device Testing Environment (Section 5)

- [ ] Provision device matrix:
  - [ ] Low-end Android phone
  - [ ] Modern Android (Pixel 6 or equivalent)
  - [ ] iPhone XR or newer (when iOS development starts)
  - [ ] iPhone SE (small screens)
- [ ] Record OS versions in compatibility spreadsheet
- [ ] Configure remote logging (Sentry/Firebase) with prod credentials

### Android Emulator

- [x] ~~Android SDK configured~~ ✅ COMPLETE
- [x] ~~Emulator created and running~~ ✅ COMPLETE
- [ ] Set mock GPS locations for testing
- [ ] Test GPS accuracy indicators (Good/Fair/Poor)
- [ ] Verify offline punch recording
- [ ] Test sync queue with network toggle

---

## 🔧 Environment & Tooling

### Known Issues

- [ ] **Flutter 3.24.3 Linux Runner** - Deprecated GTK function
  - Error: `fl_view_set_background_color` deprecated
  - Workaround: Use Web/Android builds
  - Fix: Update Flutter or patch runner code
  - **Priority**: LOW (not blocking development)

### Build Configuration

- [x] ~~JAVA_HOME environment variable~~ ✅ Set to `/opt/android-studio/jbr`
- [x] ~~Android SDK permissions~~ ✅ Fixed ownership issues
- [x] ~~Gradle build working~~ ✅ COMPLETE

---

## 📋 Phase 1-3 Verification (In Progress)

### Completed Sections

- [x] Section 1: Jobs List ✅
- [ ] Section 2: Timesheet Engine ❌ BLOCKED (missing `TimesheetLocal` table)
- [ ] Section 3-7: Not yet verified

---

## 🎉 Recent Wins (November 25, 2025)

- ✅ Android SDK fully configured
- ✅ Android emulator running
- ✅ GPS service implemented (Android)
- ✅ App successfully running on emulator
- ✅ Login flow verified
- ✅ Navigation working
- ✅ Punch screen displaying live data

---

## 📝 Notes

- **iOS Development**: Deferred until Eugene has Apple resources
- **Backend Integration**: Vendor team responsible for `/api/mobile/*` endpoints
- **Mock Data**: All services currently use mock providers for development
- **Testing**: Can flip to REST providers via `AppConfig` feature flags once endpoints are live

---

**Next Steps**:

1. Continue Phase 1-3 verification (Sections 3-7)
2. Build `TimesheetLocal` table to unblock Section 2
3. Coordinate with vendor team on backend endpoint timeline
