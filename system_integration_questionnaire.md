# Storm Master Field App — System Integration Questionnaire

**Document Version:** 1.0  
**Purpose:** Gather complete information about the existing Laravel backend system to ensure seamless mobile app integration  
**Prepared For:** Storm Master / Eugene Therrien  
**Prepared By:** GitHub antigravity  
**Date:** November 20, 2025

---

## 📋 Overview

This questionnaire helps map the **existing Storm Master backend system** to the mobile app requirements outlined in `phased_plan.md`. Complete answers ensure:

- API compatibility
- Data structure alignment
- Authentication integration
- Sync logic correctness
- Minimal rework during development

---

## 🔐 Section 1: Authentication & Security

### 1.1 Authentication Method

**Q:** What authentication system does the Laravel backend currently use?

- [ ] Laravel Sanctum (token-based)
- [ ] Laravel Passport (OAuth2)
- [x] JWT (JSON Web Tokens)
- [ ] Custom session-based auth
- [ ] Other: _______________

**Q:** What is the login endpoint?

```
POST /api/login
```

**Q:** What credentials are required for login?

- [x] Username + Password *(fallback when email not found)*
- [x] Email + Password *(primary lookup)*
- [ ] Employee ID + PIN
- [ ] Other: _______________

**Q:** What does a successful login response look like?

```json
{
  "success": true,
  "message": "User logged in successfully",
  "user": {
    "id": 12,
    "designation_id": 2,
    "country_id": 1,
    "first_name": "John",
    "last_name": "Doe",
    "email": "john@example.com",
    "username": "jdoe",
    "phone": "5551234567",
    "image": "storage/profile/jdoe.jpg",
    "address": "123 Main St",
    "address_2": "Apt 4",
    "state": "MI",
    "city": "Detroit",
    "zip_code": "48201",
    "type": 5,
    "foreman_type": 0,
    "employee_type": 1,
    "is_active": 1
  },
  "token": "eyJ0eXAiOiJKV1QiLCJhbGci..."
}
```

---

### 1.2 Token Management

**Q:** How long are authentication tokens valid?

- [ ] 1 hour
- [ ] 24 hours
- [ ] 7 days
- [x] 30 days *(43,200-minute TTL configured in `config/jwt.php`)*
- [ ] No expiration
- [ ] Other: _______________

**Q:** Does the system support token refresh?

- [ ] Yes (provide endpoint: `/api/______________`)
- [x] No (user must re-login) *(Refresh TTL exists but no refresh endpoint exposed)*

**Q:** How should the mobile app send the token?

- [x] Authorization: Bearer {token}
- [ ] Cookie
- [ ] Custom header: _______________
- [ ] Query parameter (not recommended)

**Q:** What HTTP status code indicates token expiration?

- [x] 401 Unauthorized
- [ ] 403 Forbidden
- [ ] 419 Token Expired
- [ ] Other: _______________

---

### 1.3 User Roles & Permissions

**Q:** What user roles exist in the system?

- [x] Employee *(type = 5)*
- [x] Foreman *(type = 4 with optional `foreman_type`)*
- [x] Manager *(Project Manager, type = 3)*
- [x] Admin *(type = 2)*
- [x] Other: Super Admin *(type = 1)*

**Q:** How is the user's role indicated in the API response?

```json
{
  "type": 5,            // 1=Super Admin, 2=Admin, 3=PM, 4=Foreman, 5=Employee
  "foreman_type": 0,    // sub classification for foremen
  "employee_type": 1    // 0=roofing, 1+=other trades (controls pay logic)
}
```

**Q:** Do foremen have different API permissions than employees?

- [x] Yes (describe differences: Foremen can view crew assignments/time data via web, but current API still shares the same guarded routes; no granular RBAC yet.)
- [ ] No (same endpoints for all)

---

## 🏢 Section 2: Employee & Profile Data

### 2.1 Employee Profile Endpoint

**Q:** What is the endpoint to fetch an employee's profile?

```
GET /api/me  // returns currently authenticated user profile
```

*(No `/api/mobile/profile/{id}` yet; new mobile endpoint must wrap existing logic.)*

**Q:** What fields are returned in the profile response?

```json
{
  "id": 12,
  "first_name": "John",
  "last_name": "Doe",
  "short_name": "JD",
  "email": "john@example.com",
  "username": "jdoe",
  "phone": "5551234567",
  "company_phone": "",
  "address": "123 Main St",
  "address_2": "Apt 4",
  "city": "Detroit",
  "state": "MI",
  "zip_code": "48201",
  "image": "storage/profile/jdoe.jpg",
  "designation_id": 2,
  "type": 5,
  "employee_type": 1,
  "foreman_type": 0,
  "billing_rate": 25.5,
  "certification_level": null,
  "years_of_experience": 4,
  "is_active": 1
}
```

**Q:** Which profile fields are editable by the employee?

- [x] Phone
- [x] Address (address, address_2, city, state, zip)
- [ ] Emergency contact *(not tracked in current schema)*
- [x] Avatar/photo *(via `image` field upload)*
- [x] Other: Company phone

**Q:** What is the endpoint to update profile information?

```
PUT /api/employee/{id}   // used today via Angular admin, requires auth + permissions
```

*(Employee self-service update endpoint does not exist yet; mobile API will need a dedicated controller.)*

**Q:** Does the system support profile photo uploads?

- [x] Yes (endpoint: `/api/employee/{id}` multipart upload handled server-side)
- [ ] No
- [ ] Planned for future

**Q:** If yes, what are the photo requirements?

- Max file size: Not enforced beyond PHP upload limits *(2 MB default)*
- Accepted formats: [x] JPG [x] PNG [ ] HEIC [ ] Other: _______________
- Storage location: [ ] S3 [x] Local server [ ] CDN [ ] Other: _______________

---

## 🛠️ Section 3: Jobs & Service Data

### 3.1 Job List Endpoint

**Q:** What is the endpoint to fetch jobs for an employee?

```
GET /api/get-all-formatted-job?employee_id={id}&status=&page=1
```

*Current web endpoint returns paginated jobs with filters; a purpose-built `/api/mobile/jobs/{employee_id}` does **not** exist yet and must be created for the app.*

**Q:** What does a job object look like?

```json
{
  "id": 245,
  "display_id": "JOB-2025-0010",
  "title": "123 Main - Tear-off & Re-roof",
  "manager_id": 7,
  "foreman_id": 14,
  "client_id": 33,
  "client_location_id": 52,
  "status": 3,           // 0=new sale,1=scheduled,2=pending,3=progress,4=inspection,5=completed,6=needs love
  "scheduled_date": "2025-11-21",
  "scheduled_time": "08:00",
  "address": "123 Main St",
  "city": "Flint",
  "state": "MI",
  "zip": "48502",
  "services": [
    {
      "job_item_id": 611,
      "service_id": 4,
      "service_name": "Roofing",
      "crew_id": 9,
      "status": 3,
      "completion_date": null
    }
  ],
  "crew": [ /* populated from crew_members join */ ]
}
```

**Q:** How far into the future can employees see their jobs?

- [ ] Today only
- [ ] Next 7 days
- [ ] Next 14 days
- [x] All future jobs *(current web filters allow arbitrary date ranges; mobile range still TBD, recommend ±14 days for caching)*
- [ ] Other: _______________

**Q:** Can foremen see jobs assigned to their crew members?

- [x] Yes (same endpoint, filtered by foreman_id via existing query params)
- [ ] Yes (different endpoint: `/api/______________`)
- [ ] No

**Q:** What is the date range for foreman job visibility?

- [ ] ±7 days
- [ ] ±14 days
- [ ] ±30 days
- [ ] Other: _______________

---

### 3.2 Services

**Q:** How are "services" defined in the system?

- [x] Predefined list (e.g., roofing, siding, gutters)
- [ ] Custom per job
- [x] Pulled from separate endpoint *(job items reference `services` table)*
- [ ] Other: _______________

**Q:** If services are pulled separately, what is the endpoint?

```
GET /api/get-all-services?term={search}
```

**Q:** What does a service object look like?

```json
{
  "id": 4,
  "name": "Roofing",
  "shorthand": "ROOF",
  "status": 1,
  "sub_services": [
    { "id": 11, "name": "Tear-off" },
    { "id": 12, "name": "Install" }
  ]
}
```

---

### 3.3 Crew Information

**Q:** How is crew information structured?

```json
{
  "crew": [
    {
      "crew_member_id": 301,
      "crew_id": 9,
      "employee_id": 12,
      "name": "John Doe",
      "role": "Installer",
      "is_active": true
    }
  ],
  "foreman_id": 14,
  "google_cal_id": "crew-9@calendar.google.com"
}
```

**Q:** Can crew assignments change dynamically?

- [x] Yes (crew can be reassigned via admin tools; changes sync to jobs)
- [ ] No (crew is fixed once assigned)
- [ ] Foreman can modify crew in the field *(not supported yet; web-only management)*

---

## ⏱️ Section 4: Time Punches

### 4.1 Punch Types

**Q:** What punch types does the system support?

- [x] IN *(cost_code 1=IN, 2=DRIVE, 3=ROOF, 4=SHOP all treated as IN)*
- [x] OUT *(cost_code 5)*
- [ ] BREAK_START
- [ ] BREAK_END
- [ ] LUNCH_START
- [ ] LUNCH_END
- [x] Other: Maintenance (code 6) & Write Mode (code 7) toggles for hardware

**Q:** Does the system differentiate between break types?

- [ ] Yes (paid break vs unpaid lunch)
- [x] No (all breaks treated the same; drive/shop tracked via cost codes)
- [ ] Other: _______________

---

### 4.2 Punch Submission Endpoint

**Q:** What is the endpoint for submitting punches?

```
POST /api/rm-check          // job clock hardware → backend (single punch)
```

*(Mobile-specific `POST /api/mobile/punches/batch` is required but not implemented yet.)*

**Q:** Does the endpoint support batch submissions?

- [ ] Yes (multiple punches in one request)
- [x] No (one punch per request; each RFID tap posts individually)

**Q:** What is the expected punch payload structure?

```json
{
  "jobclock_id": "RM-00045",   // physical device id or numeric id
  "keyfob_id": "F0123",
  "timestamp": "2025-11-20 08:30:00"
}
```

*Mobile payload will expand to include `punch_id`, job/service selection, GPS, and source tracking.*

**Q:** What timezone should timestamps use?

- [ ] UTC
- [x] Device local time *(job clocks send local timestamp string parsed server-side)*
- [ ] Server timezone: _______________
- [ ] Other: _______________

**Q:** What is the expected response format?

```json
{
  "success": true,
  "message": "timestamp recorded"
}
```

---

### 4.3 Duplicate Punch Handling

**Q:** How does the system detect duplicate punches?

- [ ] By punch_id (UUID from mobile)
- [x] By timestamp + employee_id + job_id + cost_code *(matching start/end record within same minute)*
- [ ] By job_id + timestamp + type
- [x] Other: Rejects if previous start/end already set to same time

**Q:** What happens when a duplicate is detected?

- [ ] Returns 200 with "already_exists" flag
- [ ] Returns 409 Conflict
- [ ] Returns 400 Bad Request
- [ ] Silently ignores and returns success
- [x] Other: Returns `{success:false,msg:"This entry is already present"}` (or "Ignoring duplicate punch in <5 minutes")

**Q:** What response indicates a duplicate?

```json
{
  "success": false,
  "msg": "This entry is already present"
}
```

---

### 4.4 Punch Validation Rules

**Q:** Does the backend validate punch logic?

- [x] Yes (checks for missing OUT before new IN)
- [ ] No (mobile app must validate)
- [x] Partial validation (describe: closes prior open punch if new IN arrives >5 min later or with diff cost code)

**Q:** What happens if an employee tries to punch IN while already clocked in?

- [ ] Returns error: _______________
- [x] Auto-clocks out previous punch *(updates last open record's end_time before inserting new IN)*
- [ ] Allows duplicate IN
- [x] Other: Ignores duplicate if within 5 minutes and same cost code, returning success=true message

**Q:** Are there GPS accuracy requirements?

- [x] No GPS required *(current schema lacks GPS columns; Phase 1 requires ≤80m accuracy flagging)*
- [ ] GPS required but no accuracy check
- [ ] GPS accuracy must be ≤ 80m
- [ ] GPS accuracy must be ≤ 100m
- [ ] Other: _______________

**Q:** What happens if GPS data is missing or low accuracy?

- [ ] Punch rejected
- [ ] Punch flagged for review
- [ ] Punch accepted with warning
- [x] Other: GPS not collected today. Client requested future flag "GPS unavailable" when app cannot capture location.

---

### 4.5 Auto-Clockout Rules

**Q:** Does the system auto-clockout employees?

- [ ] Yes (after X hours: _______________)
- [ ] Yes (at midnight device time)
- [ ] Yes (at midnight server time)
- [x] No (manual clockout only; foremen must resolve missed OUTs)

**Q:** If auto-clockout occurs, is the punch flagged?

- [ ] Yes (flagged: "auto_clockout")
- [ ] No (treated as normal punch)
- [x] Not applicable (feature not implemented)

---

## 📊 Section 5: Timesheets

### 5.1 Timesheet Endpoint

**Q:** What is the endpoint to fetch timesheet data?

```
GET /api/get-employee-timecards?employee_id={id}&start_date=YYYY-MM-DD&end_date=YYYY-MM-DD
```

*Used by Angular admin grids; no `/api/mobile/timesheet/week/{employee_id}` yet. Mobile endpoint must aggregate the same repository data for weekly summaries.*

**Q:** What parameters are accepted?

- [x] employee_id (required)
- [x] start_date (required)
- [x] end_date (required)
- [ ] week_number (optional)
- [x] Other: status filters (pending/payroll/paid)

**Q:** What does the timesheet response look like?

```json
{
  "success": true,
  "employee_id": 12,
  "timeCards": [
    {
      "id": 8810,
      "card_date": "2025-11-20",
      "job_id": 245,
      "job_item_id": 611,
      "start_time": "08:00",
      "end_time": "15:30",
      "total_minutes": 450,
      "regular_minutes": 420,
      "ot1_minutes": 30,
      "cost_code": 3,
      "status": 1,
      "dispute_status": 0,
      "foreman_approval_status": 0
    }
  ],
  "period": {
    "start": "2025-11-17",
    "end": "2025-11-23"
  }
}
```

---

### 5.2 Timesheet Calculations

**Q:** Are hours calculated on the backend or mobile app?

- [x] Backend calculates (mobile displays only)
- [ ] Mobile calculates locally
- [x] Both (mobile for quick view, backend for accuracy) *(mobile may show cached math, but payroll uses backend NA1/NA2 logic)*

**Q:** What is the overtime threshold?

- [x] 40 hours per week *(NA1 option 2)*
- [x] 8 hours per day *(NA1 option 1; configurable in settings)*
- [ ] Other: _______________

**Q:** Are breaks automatically deducted?

- [ ] Yes (breaks tracked and deducted)
- [x] No (gross hours only; breaks need explicit OUT/IN punches or cost codes)
- [ ] Depends on job/contract

**Q:** Does the system support estimated pay calculations?

- [x] Yes (pay_rate is included in profile and payroll logic already computes `total_pay`)
- [ ] No (pay info is confidential)
- [ ] Only for certain roles

---

## 🚨 Section 6: Dispute System

### 6.1 Dispute Submission

**Q:** What is the endpoint for submitting disputes?

```
POST /api/time-card-dispute
```

*(Mobile-friendly `/api/mobile/disputes` endpoint is still pending.)*

**Q:** What does a dispute payload look like?

```json
{
  "time_card_id": 8810,
  "employee_id": 12,
  "old_start_time": "08:00",
  "old_end_time": "15:30",
  "claimed_start_time": "07:30",
  "claimed_end_time": "16:00",
  "reason": "Missing drive time",
  "comment": "Forgot to scan keyfob",
  "attachments": []
}
```

**Q:** What dispute reasons are supported?

- [x] Missing punch
- [x] Wrong time
- [x] Wrong job (select correct job_item)
- [x] GPS error *(future flag when mobile launches)
- [x] Auto-clockout issue *(manual note today)
- [x] Other: Pay discrepancy / drive vs roof coding

**Q:** Can employees suggest a corrected timestamp?

- [ ] Yes (required)
- [x] Yes (optional via `claimed_start/end_time`)
- [ ] No

---

### 6.2 Dispute Status & Comments

**Q:** What is the endpoint to fetch dispute updates?

```
GET /api/time-card-dispute?employee_id={id}
```

*Comments pulled via `GET /api/get-all-dispute-comment-by-time-card?card_id={id}&is_mgmt={0|1}`. Mobile endpoints TBD.*

**Q:** What statuses can a dispute have?

- [x] pending *(status = 1)*
- [x] under_review *(treated as status 1 until manager resolves)*
- [ ] approved
- [x] rejected *(status = 3)*
- [x] resolved *(status = 2)*
- [x] Other: 0 = no dispute (default)

**Q:** Does the system support threaded comments?

- [x] Yes (back-and-forth conversation via `time_card_dispute_comments` with `is_management` flag)
- [ ] No (single submission only)
- [ ] Partial (manager can respond once)

**Q:** What does a dispute with comments look like?

```json
{
  "time_card_id": 8810,
  "status": 1,
  "thread": [
    {
      "author": "employee",
      "comment": "Forgot to punch drive time",
      "timestamp": "2025-11-20T18:15:00Z"
    },
    {
      "author": "manager",
      "comment": "Please confirm GPS",
      "timestamp": "2025-11-20T19:02:00Z"
    }
  ]
}
```

---

### 6.3 Foreman Dispute Permissions

**Q:** Can foremen review and respond to disputes?

- [ ] Yes (via mobile app)
- [x] Yes (via web dashboard only) *(Angular modal allows comments but requires admin permissions)*
- [ ] No (only managers/admins)

**Q:** Can foremen approve/reject disputes?

- [ ] Yes
- [x] No (only payroll/admin can change status via `/api/time-card-dispute-status-change`)

**Q:** What is the endpoint for foremen to respond to disputes?

```
POST /api/add-time-card-dispute-comment  // requires auth via web app today
```

---

## 👥 Section 7: Foreman Features

### 7.1 Crew Monitoring

**Q:** What is the endpoint for foremen to view crew punch status?

```
GET /api/crew-members?foreman_id={id}  // current web view to list crew assignments only
```

*No endpoint returns live punch status; `/api/mobile/crew/status/{foreman_id}` must be created for Phase 1-3.*

**Q:** What does the crew status response include?

```json
{
  "foreman_id": 14,
  "date": "2025-11-20",
  "crew": [
    {
      "employee_id": 12,
      "name": "John Doe",
      "current_status": "IN",
      "last_punch_time": "2025-11-20T13:15:00Z",
      "last_punch_type": "ROOF",
      "job_id": 245,
      "hours_today": 5.5,
      "unsynced_punches": 0
    }
  ]
}
```

*Structure above reflects desired mobile response; existing system cannot provide this yet.*

**Q:** Can foremen see punch history for crew members?

- [x] Yes (full detail via Angular grids; requires desktop access)
- [ ] Yes (summary only)
- [ ] No

**Q:** Can foremen see unsynced punches for crew members?

- [ ] Yes
- [x] No *(unsynced queue does not exist yet; foremen only see records after API save)*
- [ ] Only their own unsynced punches

---

### 7.2 Foreman Job Assignment

**Q:** Can foremen assign crew to jobs via mobile app?

- [ ] Yes (endpoint: `/api/______________`)
- [x] No (managed via web dashboard today)
- [x] Planned for Phase 2 *(after mobile app adoption)*

---

## 🌐 Section 8: API Technical Details

### 8.1 Base URL & Versioning

**Q:** What is the base URL for the API?

```
Production: https://smeapp.hiero.dev/api
Local dev: http://localhost/sm-laravel/public/api
```

**Q:** Is the API versioned?

- [ ] Yes (e.g., /api/v1/...)
- [x] No *(single `/api/*` namespace managed by Laravel routes)*

**Q:** What version should the mobile app target?

```
/api/* (same routes as web until `/api/mobile/*` segment is added)
```

---

### 8.2 Rate Limiting

**Q:** Does the API have rate limiting?

- [ ] Yes (limit: _______________ requests per _______________)
- [x] No *(default Laravel throttle middleware not enabled for JWT group)*

**Q:** What happens when rate limit is exceeded?

- [ ] Returns 429 Too Many Requests
- [ ] Returns 403 Forbidden
- [x] Other: Not applicable (no throttling configured)

---

### 8.3 Error Response Format

**Q:** What is the standard error response structure?

```json
{
  "success": false,
  "msg": "Human-readable message",
  "errors": { /* optional validation messages */ }
}
```

**Q:** What HTTP status codes are used?

- [x] 200 OK
- [x] 201 Created
- [x] 400 Bad Request *(validation failures also return 422 sometimes)*
- [x] 401 Unauthorized
- [ ] 403 Forbidden
- [x] 404 Not Found
- [ ] 409 Conflict
- [x] 422 Unprocessable Entity
- [ ] 429 Too Many Requests
- [x] 500 Internal Server Error
- [x] Other: 419 (JWT expiration handled by middleware)

---

### 8.4 Data Formats

**Q:** What date/time format does the API use?

- [ ] ISO 8601 (2025-11-20T08:30:00Z)
- [ ] Unix timestamp (1700472600)
- [x] Other: `Y-m-d` for dates, `H:i:s` for times, combined `Y-m-d H:i:s` strings (no timezone offset)

**Q:** What numeric format is used for GPS coordinates?

- [x] Decimal degrees (planned `DECIMAL` columns)
- [ ] Degrees/minutes/seconds
- [ ] Other: _______________

**Q:** Are there any special data validation rules?

- [x] Phone number format: 10-digit US numbers stored as strings (no formatting enforced)
- [x] Address format: Free-form text; zip expects 5 digits
- [x] GPS accuracy units: [x] meters [ ] feet *(planned requirement ≤80m; flag if unavailable)*
- [x] Other: Cost codes limited to predefined integers 1–7

---

### 8.5 Pagination

**Q:** Do list endpoints support pagination?

- [x] Yes (all list endpoints)
- [ ] Yes (only for: _______________)
- [ ] No

**Q:** If yes, what pagination format is used?

- [ ] Limit + offset (`?limit=20&offset=40`)
- [x] Page + per_page (`?page=2` uses Laravel paginator; `per_page` optional)
- [ ] Cursor-based
- [ ] Other: _______________

**Q:** What is the default page size?

- [x] 10 *(Laravel default)*
- [ ] 20
- [ ] 50
- [ ] 100
- [x] Other: configurable via `per_page` query

---

## 🔄 Section 9: Data Synchronization

### 9.1 Sync Strategy

**Q:** Should the mobile app use real-time sync or batch sync?

- [ ] Real-time (immediate API calls)
- [ ] Batch sync (queue + periodic upload)
- [x] Hybrid (critical data real-time, bulk data batched)
  - Punch submissions queued offline and flushed ASAP
  - Job/timesheet fetches can refresh on demand or scheduled intervals

**Q:** What is the preferred sync interval?

- [ ] Every 1 minute
- [x] Every 5 minutes *(punch queue flush + data refresh target)*
- [ ] Every 15 minutes
- [ ] Manual sync only
- [x] Other: Immediate sync when connectivity restored; manual "Sync Now" button allowed

**Q:** Should the app sync on app resume/foreground?

- [x] Yes
- [ ] No
- [x] Only if data is stale (> 5 minutes old)

---

### 9.2 Conflict Resolution

**Q:** If mobile and server data conflict, which takes precedence?

- [x] Server always wins *(payroll source of truth; disputes handle corrections)*
- [ ] Client always wins
- [ ] Most recent timestamp wins
- [x] Manual review required *(create dispute if conflict detected post-sync)
- [ ] Other: _______________

**Q:** How should the mobile app handle partial sync failures?

- [x] Retry failed items only (store failed punch IDs + error)
- [ ] Retry entire batch
- [x] Flag failed items for manual review (prompt employee/foreman to fix metadata)
- [ ] Other: _______________

---

### 9.3 Data Staleness

**Q:** How often should the app refresh cached data?

- **Jobs:** Every 15 minutes or on manual pull-to-refresh
- **Profile:** Once per day or when user returns to profile screen
- **Timesheet:** On demand + auto refresh when viewing new week
- **Crew status (foreman):** Every 1 minute while screen is active

**Q:** Should the app show stale data warnings?

- [x] Yes (if data is > 1 hour old for jobs/crew, >24h for profile)
- [ ] No (always show cached data)

---

## 🧪 Section 10: Testing & Staging

### 10.1 Test Environment

**Q:** Is there a staging/test API environment?

- [ ] Yes
  - Base URL: `https://____________________________`
  - Test accounts available: [ ] Yes [ ] No
- [x] No (must test against production)
  - *Current workflow is to run Laravel + Angular locally using the extracted tar archives.*

**Q:** Are there test employee accounts we can use?

- [x] Yes
  - Employee test account: username: `employee@example.com` password: `password` *(seed data from dump; can reset locally)*
  - Foreman test account: username: `foreman@example.com` password: `password`
- [ ] No

**Q:** Are there test jobs and punch data available?

- [x] Yes (pre-populated in database seeds and latest SQL dumps)
- [ ] No (must create test data)

---

### 10.2 API Documentation

**Q:** Is there existing API documentation?

- [ ] Yes (Swagger/OpenAPI)
- [ ] Yes (Postman collection)
- [ ] Yes (written docs)
- [x] No (needs to be created)

**Q:** If yes, where can it be accessed?

```
URL: N/A – must generate new API contract + Postman collection during Phase 1
```

---

## 📱 Section 11: Mobile-Specific Requirements

### 11.1 App Store Information

**Q:** What should the app be named?

- Official name: Storm Master Field App
- Bundle ID (iOS): com.stormmaster.fieldapp *(placeholder – finalize before submission)*
- Package name (Android): com.stormmaster.fieldapp *(placeholder)*

**Q:** Are there branding assets available?

- [x] Logo (provide: Storm Master Exteriors branding from web site)
- [x] Color scheme (primary: #C8102E red, secondary: #00263A navy)
- [x] Fonts (Montserrat per marketing site)
- [x] Other: Use existing Storm Master Exteriors imagery for splash/login

---

### 11.2 Push Notifications (Future)

**Q:** Will push notifications be needed in Phase 2+?

- [x] Yes (for: dispute updates, punch reminders, job reassignment alerts)
- [ ] No
- [ ] Undecided

---

### 11.3 Background Location (Future)

**Q:** Will background GPS tracking be required?

- [x] Yes (Phase 2+) *(for job verification when app minimized)*
- [ ] No (foreground only is sufficient)
- [ ] Undecided

---

## ✅ Section 12: Sign-Off

**Q:** Who is the technical contact for backend/API questions?

- Name: Eugene Therrien
- Email: TBD (client to provide preferred address)
- Availability: Weekdays 9a–5p ET; prefers scheduled working sessions

**Q:** Who has authority to approve API changes?

- Name: Eugene Therrien
- Role: Owner / Project Sponsor

**Q:** What is the preferred communication channel?

- [x] Email
- [ ] Slack/Teams
- [ ] GitHub Issues
- [x] Phone *(for urgent field issues)*
- [x] Other: In-person review when handing deliverables to partner team

---

## 📝 Additional Notes

Use this section for any additional information about the existing system:

```
- Legacy Raspberry Pi job clocks will continue operating alongside the mobile app; backend must differentiate via `time_cards.source`.
- GPS capture is a brand-new requirement; add nullable `gps_lat`, `gps_lng`, `gps_accuracy`, and `gps_unavailable_flag` fields.
- Offline queue must encrypt locally stored punches because devices may be shared.
- Duplicate detection currently uses timestamp + employee; mobile must also send client-generated UUID to prevent double posts.
- Foremen need real-time crew visibility but cannot edit punches yet—mobile UX should reflect read-only status until policy changes.
- Developers receiving this plan prefer concise, human-readable Laravel code; avoid overly abstract patterns when implementing `/api/mobile/*`.
```

---

## 🎯 Next Steps After Questionnaire Completion

1. **API Contract Finalization** — Document all endpoints with sample requests/responses
2. **Test Account Setup** — Create staging environment access for mobile development
3. **Data Schema Alignment** — Map Laravel database schema to mobile local storage
4. **Integration Planning** — Identify any gaps or required backend changes
5. **Phase 1-1 Kickoff** — Begin project setup with full system knowledge

---

**Document Status:** 🟢 Complete  
**Last Updated:** November 20, 2025  
**Completed By:** GitHub antigravity  
**Review Date:** Pending client sign-off
