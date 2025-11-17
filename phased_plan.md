# Storm Master Field App — Phase 1-1 Detailed Breakdown
**Document Version:** 1.1
**Prepared For:** DR Development Team
**Prepared By:** Storm Master / Eugene Therrien
**Scope:** Phase 1-1 (formerly Week 1) — Detailed Technical Steps
**Platforms:** Android + iOS
**Backend:** Laravel (API) + MySQL

---

# 🚀 Phase 1-1 — Detailed Technical Breakdown
This section expands Phase 1-1 (formerly Week 1) into precise, sequential engineering tasks.
These are the micro-steps developers must complete to properly initialize the project.

---

# ✅ Phase 1-1: Project Setup & Foundations (Detailed Steps)

## **1. Project Initialization (Mobile App Base Setup)**
### **1.1 Choose Tech Stack**
- Decide between **Flutter** (preferred) or **React Native**.
- Confirm dev team proficiency.
- Create initial tech stack document.

### **1.2 Initialize Project Repository**
- Create new project folder.
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

### **1.3 Add Platform Builds**
- Configure **Android build.gradle**
- Configure **iOS Podfile**
- Ensure app builds cleanly on both platforms before any logic added.

---

## **2. Core Architectural Decisions**

### **2.1 Offline-First Strategy**
- Decide on **SQLite** (preferred) or **secure storage + JSON file** hybrid.
- Create local database schema with tables:
  - `punches_local`
  - `jobs_local`
  - `profile_local`
  - `sync_queue`

### **2.2 Sync Engine Blueprint**
- Define:
  - Queue architecture
  - Retry logic
  - Data precedence (server wins or client wins?)
  - Conflict detection (duplicate punches)
- Write sync diagram:
  ```
  Local Punch → Queue → Retry Loop → API POST Batch → Server Response → Purge Queue
  ```

### **2.3 Authentication Flow**
- Define login system:
  - Username + password
  - Token-based auth
  - Token refresh rules
- Create basic login screen (placeholder UI).

---

## **3. UI Scaffolding**

### **3.1 Create Placeholder Screens**
Screens to scaffold:
- Login
- Home
- Punch
- Job List
- Timesheet
- Profile

### **3.2 Navigation Architecture**
- Set up bottom tab navigation:
  - Home
  - Jobs
  - Timesheet
  - Profile
- Add route guards:
  - If not authenticated → Login
  - If authenticated → Main App

---

## **4. Backend API Mapping**

### **4.1 Map Required Endpoints**
Create an API contract document listing endpoints:

- `/api/mobile/login`
- `/api/mobile/jobs/{employee_id}`
- `/api/mobile/punches/batch`
- `/api/mobile/timesheet/week/{employee_id}`
- `/api/mobile/profile/{id}`

### **4.2 Request/Response Specs**
Document:
- Expected request payloads
- Response JSON
- Error structures
- Status codes

### **4.3 Create API Service Layer**
Add structure:
- `api/login_service.dart`
- `api/job_service.dart`
- `api/punch_service.dart`
- `api/profile_service.dart`

---

## **5. Device Testing Environment**

### **5.1 Device Matrix**
Prepare for:
- Low-end Android phone
- Modern Android
- iPhone XR or newer
- iPhone SE (small screens)

### **5.2 Install Debug Tools**
- Flutter DevTools or React Native DevTools
- Android Studio logs
- iOS Xcode console

### **5.3 Test Build**
- Build initial app shell on all devices
- Fix any platform-specific errors early

---

## **6. Final Verification for Phase 1-1**

### **6.1 Project Compiles on Both Platforms**
- No errors
- Clean scaffolding
- Ready for development

### **6.2 Offline Architecture Document Completed**
Should include:
- Storage schema
- Sync logic
- Punch structure
- Local cache rules

### **6.3 API Contract Approved by Storm Master**
- Endpoint list
- Payloads
- Authentication rules
- Versioning strategy

---

# 📌 End of Phase 1-1 Detailed Breakdown

# Storm Master Field App — Phase 1-2 Detailed Breakdown
**Document Version:** 1.1
**Prepared For:** DR Development Team
**Prepared By:** Storm Master / Eugene Therrien
**Scope:** Phase 1-2 (formerly Week 2) — Offline Punching System
**Platforms:** Android + iOS
**Backend:** Laravel (API) + MySQL

---

# 🚀 Phase 1-2 — Detailed Technical Breakdown
This document expands **Phase 1-2** into precise, sequential engineering steps required to build the **offline punching + GPS + sync engine** foundation of the Field App.

---

# ✅ Phase 1-2: Offline Punching System (Detailed Steps)

## **1. Offline Punch UI Implementation**

### **1.1 Create Punch Screen Layout**
- Build UI elements:
  - Punch In
    - Punch Out
- Break Start
  - Break End
  - Add indicators:
    - “Currently Clocked In”
    - Job/Service selected
- GPS lock status

### **1.2 Add Job Selection Modal**
- User chooses:
  - Job ID
    - Service
    - Foreman sees assigned crew jobs across ±14 days
    - Ensure selection stored with punch record

### **1.3 Add Real-time State Indicator**
- Show:
  - Punch status (IN/OUT)
  - Time since last punch
  - Job currently active
  - Warning if offline

---

## **2. GPS Integration**

### **2.1 Request Permissions**
- Ask for:
  - Foreground location
    - Background (optional future)
    - Handle “denied” status

    ### **2.2 Acquire GPS Coordinates**
    - Latitude, longitude, accuracy
    - Timeout rules for poor signal
    - Cache last known coordinate for fallback

    ### **2.3 Validate GPS Accuracy**
    - If accuracy > 80–100m:
- Tag punch as “Low Accuracy”
- Store accuracy in punch record

### **2.4 Create GPS Utility Module**
- Standardize:
  - Fetch
  - Re-fetch
  - Timeout
  - Error handling
- Expose results to Punch Screen

---

## **3. Local Punch Storage System**

### **3.1 Create Local Table: `punches_local`**
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

### **3.2 Insert Punch Records**
- Every punch → instant local write
- Must work offline 100%

### **3.3 Add “Pending Sync” Badge**
- UI reflects unsynced punches
- Foreman sees crew’s unsynced count

---

## **4. Sync Queue Engine**

### **4.1 Create Local Table: `sync_queue`**
Fields:
- queue_id
- payload (JSON)
- attempt_count
- created_at
- last_attempt_at

### **4.2 Build Sync Manager Service**
Handles:
- reading queue
- batching punches
- submitting to API
- parsing responses
- clearing queue
- retry with exponential backoff

### **4.3 Add Background Sync Trigger**
Triggers:
- App open
- App resume
- Timer (every 5 minutes)
- Manual “Sync Now”

### **4.4 Server Conflict Handling**
If server returns:
- Duplicate punch → mark as synced
- Invalid job_id → flag record
- Invalid timestamp → send correction request

---

## **5. API Integration for Punches**

### **5.1 Connect to Batch Punch Endpoint**
`POST /api/mobile/punches/batch`

### **5.2 Build Payload Structure**
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

### **5.3 Create Response Handler**
Success:
- Mark records as synced
- Remove from queue

Failure:
- Retry
- Mark flagged records

---

## **6. Error Handling + Reliability**

### **6.1 Network State Detection**
- If offline → queue only
- If online → attempt sync

### **6.2 Duplicate Punch Prevention**
- Punch ID based on UUID
- Server checks uniqueness
- Sync manager avoids resending

### **6.3 Crash Recovery**
      On app restart:
- Reload offline queue
- Display unsynced alerts

### **6.4 Prevent Double Taps**
- Add tap debounce
- Disable buttons briefly after press

---

## **7. UI Enhancements for Punch Reliability**

### **7.1 Offline Warning Banner**
- “You are offline. Punches will sync when connection is restored.”

### **7.2 GPS Quality Indicator**
- Color code: green/yellow/red
- Tooltip: accuracy in meters

### **7.3 Job/Service Reminder**
- If user hasn’t selected job → require before punch

---

## **8. Testing Requirements**

### **8.1 Offline Test Scenarios**
- Airplane mode punch
- Airplane mode → travel → reconnect → sync
- Multiple punches offline

### **8.2 GPS Test Cases**
- Indoors (low signal)
- Outdoors (high signal)
- Moving between sites

### **8.3 Sync Stress Tests**
- 100 punches in queue
- Random failures
- API returning partial success

### **8.4 Multiplatform Tests**
- Low-end Android
- iPhone SE

---

## **9. Completion Criteria**

- Offline punching fully functional
- GPS captured reliably
- Sync queue stable
- No duplicate punches
- UI stable and clear
- Crash recovery intact
- All Phase 1-2 APIs integrated

---

# 📌 End of Phase 1-2 Detailed Breakdown

---

# Storm Master Field App — Phase 1-3 Detailed Breakdown
**Document Version:** 1.0
**Prepared For:** DR Development Team
**Prepared By:** Storm Master / Eugene Therrien
**Scope:** Phase 1-3 (formerly Week 3) — Jobs, Timesheets & Foreman Features
**Platforms:** Android + iOS
**Backend:** Laravel (API) + MySQL

---

# 🚀 Phase 1-3 — Detailed Technical Breakdown
This document expands **Phase 1-3** into precise, sequential engineering tasks needed to implement:
- Job List (Employee + Foreman)
- Timesheet Engine (Local Calculations)
- Estimated Pay Display
- Foreman Crew View & Punch Monitoring

---

# ✅ Phase 1-3: Job List, Timesheets, Foreman Visibility (Detailed Steps)

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

### **1.2 Job API Fetch**
Call:
`GET /api/mobile/jobs/{employee_id}`

Store response in:
- `jobs_local`
- Mark timestamp for refresh

### **1.3 Build Job List Screen**
Sections:
- Today’s Jobs
- This Week
- Last Week

Sort:
- By date
- By start time

### **1.4 Job Detail Modal**
Includes:
- Job ID
- Service list
- Customer name
- Address (tap → Google/Apple Maps)
- Crew list
- Scheduled date & time

### **1.5 Foreman Job View**
Foreman sees:
- Jobs ±14 days
- Full crew list per job
- Crew punch statuses (IN/OUT)
- Any unsynced punches for the crew

---

## **2. Timesheet Engine**

## **2.1 Local Timesheet Table**
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

### **2.2 Build Timesheet Aggregator**
Reads from:
- `punches_local`
- `punches_synced`

Calculates:
- Daily totals
- Weekly totals
- Per-job totals
- Regular vs OT (future config)

### **2.3 Daily Timesheet UI**
Displays:
- Punch pairs (IN → OUT)
- GPS accuracy
- Job names
- Totals per day
- Buttons:
  - Dispute
  - Expand details

### **2.4 Weekly Timesheet UI**
    Displays:
    - Weekly regular hours
    - Weekly OT hours
    - Total hours
    - Day-by-day breakdown

    - Day-by-day breakdown

### **2.5 Estimated Pay Display**
    Uses local math:
    - hours * pay_rate
    - pay_rate pulled from profile API

    Read-only **for employee transparency**.

    ---

    # 3. Foreman Crew View

    ## **3.1 Crew Aggregation**
    Foreman sees crew assigned to each job:
    - Name
    - Role
    - Punch status (IN/OUT)
    - Hours today
    - Last punch type

    ## **3.2 Punch Status Indicators**
    Color coding:
    - Green = Clocked In
    - Red = Clocked Out
    - Yellow = Unsynced Punches
    - Grey = No activity today

    ## **3.3 Crew Detail Modal**
    Shows:
    - Punch history for day
    - Total hours
    - Job assignment
    - Dispute flags

    ## **3.4 Foreman Permissions**
    Foreman:
    - Cannot edit punches
    - Can view disputes
    - Can respond/comment on disputes
    - Can see unsynced punch warnings

    ---

    # 4. Sync Between Punches & Timesheets

    ## **4.1 Automatic Rebuild Engine**
    Whenever:
    - Punch sync completes
    - Jobs sync completes
    - Or app resumes

    Recalculate:
    - Timesheet
    - Daily totals
    - Weekly totals
    - Crew totals (Foreman only)

    ## **4.2 Punch–Job Linking**
    If:
    - Punch references a job not yet cached →
      force job fetch

## **4.3 Timesheet Error Flags**
      Flag entries when:
- Missing OUT punch
- Excessive break
- Auto-clockout
- GPS accuracy > 80m
- Multi-job overlap

---

## **5. UI & UX Enhancements**

## **5.1 Visual Consistency**
- Job cards
- Punch history
- Timesheet rows
- Icons for statuses

## **5.2 Loading States**
      Add:
- Skeleton loaders
- Offline banners
- “Syncing…” indicators

## **5.3 Empty States**
      If no jobs:
- “You have no scheduled jobs for today.”

      If no punches:
- “No punch activity recorded.”

---

## **6. Testing & Validation**

## **6.1 Job Tests**
- Fetch jobs offline → cached view
- Full job list load time < 1s
- Maps link opens correctly

## **6.2 Timesheet Tests**
- Overlapping punches flagged
- Weekly totals accurate
- Break logic correct
- Estimated pay calculates consistently

## **6.3 Foreman Tests**
- Crew list displays correctly
- Punch statuses match punch table
- Unsynced warnings shown correctly

---

## **7. Phase 1-3 Completion Criteria**

- Job List fully functional
- Timesheet engine local calculations accurate
- Estimated pay displayed correctly
- Foreman crew view operational
- UI stable on low-end devices
- Sync interactions reliable
- No crashes under normal use

---

# 📌 End of Phase 1-3 Detailed Breakdown

# Storm Master Field App — Phase 1-4 Detailed Breakdown
**Document Version:** 1.0
**Prepared For:** DR Development Team
**Prepared By:** Storm Master / Eugene Therrien
**Scope:** Phase 1-4 (formerly Week 4) — Disputes, Profile Management, UI Polish
**Platforms:** Android + iOS
**Backend:** Laravel (API) + MySQL

---

# 🚀 Phase 1-4 — Detailed Technical Breakdown
Phase 1-4 transforms the app from a “working prototype” into a **field-ready tool** with:
- Full dispute workflow
- Editable employee profile
- Robust UI polish
- Stability improvements
- Offline-safe interactions
- Final user-facing refinements

---

# ✅ Phase 1-4: Dispute System, Profile, UX Polish (Detailed Steps)

---

## **1. Dispute System Implementation**

## **1.1 Create Dispute Table (Local Storage)**
`disputes_local`
Fields:
- dispute_id (UUID)
- punch_id
- employee_id
- reason
- comment
- proposed_time (optional)
- status (pending / reviewed / resolved)
- thread (JSON for comments)
- synced (bool)

## **1.2 Add “Dispute” Button to Timesheet Rows**
Visible when:
- A punch pair is shown (IN/OUT)
- Or when entry is auto-clockout
- Or missing punch (IN/OUT)

## **1.3 Dispute Form UI**
Fields:
- Reason dropdown
- Comment box (required)
- Optional corrected time selector
- Submit button
UI Requirements:
- Offline capable
- Clear messaging

## **1.4 Local Dispute Queue**
All submissions stored offline:
- Add to local queue
- Mark as pending
- Sync when online
- Display “Awaiting Review” tag

## **1.5 Sync to Backend**
`POST /api/mobile/disputes`
Payload includes:
- Dispute metadata
- Proposed fix
- Full comment thread (initial)

## **1.6 Threaded Comment System**
When server sends updated dispute:
- Append new comment(s)
- Change status
- Mark as synced

---

## **2. Profile Management**

## **2.1 Profile Local Cache Table**
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

## **2.2 Profile Fetch from Backend**
Call:
`GET /api/mobile/profile/{id}`

Cache locally:
- Overwrite local profile
- Mark timestamp

## **2.3 Profile Edit UI**
Editable fields:
- Phone
- Address
- Emergency contact
- Avatar photo

Non-editable:
- Name
- Pay rate
- Hire date
- Role

## **2.4 Photo Upload Flow**
- Open camera/gallery
- Compress photo
- Store offline if needed
- Upload on next sync

## **2.5 Sync to Backend**
`PUT /api/mobile/profile/{id}`
Payload includes:
- Updated fields
- Offline updates queued if no connection

## **2.6 Profile Consistency Checks**
- Ensure no regressions during offline edits
- Validate fields before submitting

---

## **3. UI Polish & UX Enhancements**

## **3.1 Global Button Style Pass**
- Standardize:
  - Radius
  - Colors
  - Text size
  - States (disabled, pressed, normal)

## **3.2 Add Loading Indicators**
Elements needing loaders:
  - Job list
  - Timesheet
  - Profile
  - Disputes
  - Map link
  - Sync operations

## **3.3 Add Empty States**
Examples:
  - “No jobs scheduled today.”
  - “No punches recorded this week.”
  - “No disputes submitted.”

## **3.4 Animation & Smoothness**
  - Add fade-ins
  - Add scrolling smoothness
  - Reduce layout shifts

## **3.5 Error States**
Show readable messages:
  - GPS error
  - Network error
  - Sync failure
  - API failure

---

## **4. Offline-Resilient Interactions**

## **4.1 Unified Offline Banner**
Top banner:
  - “You are offline — changes will sync later.”

## **4.2 Screen-Level Sync Check**
Required for:
  - Profile updates
  - Dispute submissions
  - Crew view refresh

## **4.3 Crash Recovery**
On restart:
  - Disputes queued restored
  - Profile edits restored
  - UI corrects itself based on local tables

---

## **5. Foreman Enhancements (Light)**

## **5.1 Dispute Review UI**
Foreman can:
  - Read disputes
  - Add comments
  - Tag as “Reviewed”

## **5.2 Quick Crew Timesheet Summary**
Small enhancements to:
  - Daily hours
  - Out-of-radius flags
  - Unsynced warnings

---

## **6. Testing Requirements**

## **6.1 Dispute Testing**
  - Submit disputes offline
  - Submit multiple disputes
  - Sync dispute + punch updates
  - Test threaded comments

## **6.2 Profile Testing**
  - Update profile offline → sync
  - Change avatar photo → offline → sync
  - Reject invalid fields

## **6.3 UI Testing**
  - Screen transitions
  - Loaders show correctly
  - Empty states displaying
  - GPS warnings visible

## **6.4 Stability Testing**
  - Rapid UI usage
  - App backgrounding
  - Airplane mode transitions
  - Force close recovery

---

## **7. Completion Criteria for Phase 1-4**

  - Dispute submission fully working
  - Profile updates stable and synced
  - All UI polished and consistent
  - Error handling implemented
  - Offline-resilient flows working
  - Foreman mini-review interface live
  - No major bugs or crashes

---

# 📌 End of Phase 1-4 Detailed Breakdown


---

# Storm Master Field App — Phase 1-5 Detailed Breakdown
**Document Version:** 1.0
**Prepared For:** DR Development Team
**Prepared By:** Storm Master / Eugene Therrien
**Scope:** Phase 1-5 (formerly Week 5) — Testing, Optimization & QA
**Platforms:** Android + iOS
**Backend:** Laravel (API) + MySQL

---

# 🚀 Phase 1-5 — Detailed Technical Breakdown
Phase 1-5 is where the Storm Master Field App transitions from “feature-complete” to **battle-tested, reliable, field-ready software**.
This phase combines:
- Stress testing
- Performance optimization
- Quality assurance
- Bug fixes
- Field testing preparation

*(Note: Detailed steps for Phase 1-5 to be completed)*

---

# 📌 End of Phase 1-5 Detailed Breakdown

---

# Storm Master Field App — Phase 1-6 Detailed Breakdown
**Document Version:** 1.0
**Prepared For:** DR Development Team
**Prepared By:** Storm Master / Eugene Therrien
**Scope:** Phase 1-6 (formerly Week 6) — Final Polish, Deployment, and Handoff
**Platforms:** Android + iOS
**Backend:** Laravel (API) + MySQL

---

# 🚀 Phase 1-6 — Detailed Technical Breakdown
Phase 1-6 completes the field app’s first full production cycle.
This phase focuses on:
- Final bug fixes
- Deployment packaging
- Documentation
- Build signing
- Distribution
- Developer handoff
- 30‑day post-launch support plan

This is the **release engineering phase**, ensuring the app is production-ready and stable.

---

# ✅ Phase 1-6: Final Polish, Deployment & Handoff (Detailed Steps)

---

## **1. Final Bug Pass & Polish**

## **1.1 Collect All Outstanding Bugs**
Sources:
- QA logs
- Internal testing
- Field test reports
- Device logs
- Crash analytics (if used)

Categorize:
- Critical
- High
- Medium
- Cosmetic

Fix order:
1. Critical
2. High
3. Medium
4. Cosmetic (only if time allows)

---

## **1.2 Fix UI Edge Cases**
Examples:
- Layout shifts
- Button tap area too small
- Text truncation
- Inconsistent font sizes
- Missing loaders
- Missing empty-state placeholders

---

## **1.3 Finalize Offline UX**
Ensure:
- Offline banner triggers reliably
- Sync queue messages are clear
- No “hanging states”
- App gracefully handles:
  - low-signal
    - signal-loss mid-sync
- app backgrounding
  - device restarts

---

## **2. Performance Optimization**

## **2.1 Optimize Database Access**
- Index local tables
- Reduce repeated queries
- Cache heavy lists (jobs, crew)

## **2.2 Reduce Re-renders**
- Memoize components
- Remove unnecessary state updates
- Improve scrolling performance

## **2.3 Lower App Startup Time**
- Lazy-load heavy components
- Pre-load critical tables
- Optimize initial API calls

---

## **3. Deployment Preparation**

## **3.1 Android Production Build**
Steps:
- Generate **release keystore**
- Add keystore to CI/CD or secure vault
- Configure:
  - build.gradle (release)
  - versionCode + versionName
- Create **release APK** (or AAB)
- Test on:
  - low-end Android
  - Android 13+
  - Android 10                  ---

          ## **3.2 iOS Production Build**
          Steps:
    - Set bundle identifier
    - Configure signing certificates
    - Configure provisioning profiles
    - Set version + build numbers
    - Archive build in Xcode
    - Distribute via TestFlight

          Test on:
    - iPhone SE (small screen)
    - iPhone XR
    - iPhone 12/13 (modern devices)

    ---

          # 4. Documentation Package

          ## **4.1 Developer Documentation**
          Includes:
    - Project structure
    - Local DB schema
    - Sync engine architecture
    - API endpoints + payloads
    - Error handling patterns
    - Module overview (Punch, Jobs, Timesheet, Profile)

          Format:
    - Markdown
    - PDF

    ---

          ## **4.2 Build & Deploy Instructions**
          Step-by-step instructions for:
    - Creating builds
    - Updating version numbers
    - Generating release keys
    - Publishing to:
            - TestFlight
              - Android APK/AAB

              ---

              ## **4.3 QA Checklist Documentation**
              Includes:
              - Test cases
              - Expected results
              - Known edge cases
              - How to simulate outages
              - GPS test instructions

              ---

              # 5. Final Integration Review

              ## **5.1 API Contract Validation**
              Check:
              - All endpoints live
              - All payloads correct
              - Authentication stable
              - Sync works across:
                - Punches
- Jobs
  - Disputes
    - Profile

    ---

## **5.2 Data Integrity Check**
- No orphaned punches
- No missing job references
- No lost disputes
- No incorrect timestamps

---

## **5.3 Production Trial Run**
- Simulate full workday
- Multiple crews punching
- Foreman using crew view
- Offline/online transitions
- GPS validation

---

## **6. Handoff & Release**

## **6.1 Deliverables Provided**
Developer must deliver:

1. **Full Source Code** (mobile + backend integrations)
2. **Documentation Package**
3. **Signed Android Release Build** (.apk / .aab)
4. **iOS TestFlight Build**
5. **Architecture Diagrams**
6. **Sync Logic Diagram**
7. **Local DB Schema**
8. **API Integration Reference**

---

## **6.2 30-Day Support Plan**
Developer agrees to:
- Fix any critical/high bugs
- Respond within 24 hours
- Provide patches as needed
- Assist with launch troubleshooting

---

## **6.3 Ownership Transfer**
Storm Master receives:
- Full IP rights
- Full source control access
- Build credentials
- Keystores & signing keys

---

## **7. Completion Criteria for Phase 1-6**

- App builds successfully on Android & iOS
- No critical or major bugs remain
- All Punch → Sync → Timesheet → Dispute → Profile flows stable
- Offline capability fully reliable
- Full documentation delivered
- Deployment builds signed and tested
- Handoff complete
- Ready for **Phase 2** planning

---

# 📌 End of Phase 1-6 Detailed Breakdown