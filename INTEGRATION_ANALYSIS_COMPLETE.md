# Storm Master System Integration Analysis - COMPLETED
**Analysis Date:** November 20, 2025  
**Analyst:** GitHub Copilot  
**Source Files:** Laravel Backend, Angular Frontend, Job Clock (Python)

---

## 🎯 Executive Summary

Completed comprehensive analysis of the existing Storm Master system by extracting and reviewing:
- **Laravel Backend** (storm-master-laravel) - API server
- **Angular Frontend** (sme-ng-new) - Web application
- **Job Clock** (smejobclock) - Python-based portable time clock hardware

### ⚠️ CRITICAL FINDINGS

1. **NO MOBILE API EXISTS** - The current system has **NO mobile-specific endpoints**
2. **Time tracking system exists** but is designed for:
   - Physical "job clock" devices (Raspberry Pi-based hardware)
   - Web-based Angular admin interface
   - **NOT designed for mobile apps**

3. **Major architectural differences** from `phased_plan.md`:
   - Current system: Hardware job clocks → Laravel API
   - Planned system: Mobile apps → New mobile API

---

## 🔍 What Was Discovered

### 1. Authentication System

**Technology:** JWT (tymon/jwt-auth v2.0)

**Login Endpoint:**
```
POST /api/login
```

**Credentials Required:**
- Email **OR** Username + Password
- System checks email first, then falls back to username

**Login Response:**
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
    "sales": 0,
    "image": "path/to/image.jpg",
    "address": "123 Main St",
    "address_2": "Apt 4",
    "state": "MI",
    "city": "Detroit",
    "zip_code": "48201",
    "type": 5,
    "is_active": 1,
    "foreman_type": 0,
    "employee_type": 1
  },
  "token": "eyJ0eXAiOiJKV1QiLCJhbGci..."
}
```

**Token Settings:**
- TTL: **30 days** (43,200 minutes) configured in `config/jwt.php`
- Refresh TTL: **20,160 minutes** (~2 weeks)
- Header: `Authorization: Bearer {token}`
- Expiration status code: **401 Unauthorized**

**User Profile Endpoint:**
```
GET /api/me
Authorization: Bearer {token}
```

**NO Token Refresh Endpoint Found**

---

### 2. User Roles & Permissions

**User Types (from users table migration):**
- 1 = Super Admin
- 2 = Admin  
- 3 = Project Manager
- 4 = Foreman
- 5 = Employee

**Role Fields in User Object:**
- `type` - Primary role (1-5)
- `foreman_type` - Foreman classification (if applicable)
- `employee_type` - Employee classification:
  - 0 = Roofing (uses pay matrix)
  - 1+ = Other (uses billing_rate)

**Permissions:**
- All authenticated routes use middleware: `['api', 'jwt.auth', 'cors']`
- No granular permission system observed
- Foremen can view crew data but **cannot edit time cards**

---

### 3. Time Card System (Current Implementation)

**⚠️ IMPORTANT:** The current system is **NOT designed for mobile apps**

**How It Works Now:**
1. Physical "Job Clock" devices (Raspberry Pi) deployed to job sites
2. Employees scan RFID keyfobs to punch in/out
3. Job clocks send data to Laravel API via:
   ```
   POST /rm-check
   ```
4. Laravel creates `time_cards` records
5. Angular web app displays time cards for payroll processing

**Time Card Structure** (from migration):
```sql
time_cards:
  - id
  - job_id
  - employee_id
  - card_date
  - start_time
  - end_time
  - is_clock_out (1=yes, 0=no)
  - total_minutes
  - regular_minutes
  - ot1_minutes (NA1 overtime)
  - ot2_minutes (NA2 overtime - weekends/holidays)
  - total_pay
  - pay_amt_regular
  - pay_amt_ot1
  - pay_amt_ot2
  - cost_code (1=IN, 2=DRIVE, 3=ROOF, 4=SHOP, 5=OUT)
  - status (1=Pending, 2=Payroll, 3=Paid)
  - dispute_status (0=No dispute, 1=Open, 2=Resolved)
  - foreman_approval_status (0=Pending, 1=Approved, 2=Rejected)
  - comment
  - disposition (added recently)
  - job_item_id (links to specific service on job)
```

**Cost Codes:**
1. IN - Punch in - Carpentry / Demolition
2. DRIVE - Punch in - Driving
3. ROOF - Punch in - Roofing time
4. SHOP - Punch in - Shop time
5. OUT - Punch out

**Overtime Calculation:**
- **NA1** (Normal Overtime): 
  - Configurable: 8 hrs/day OR 40 hrs/week
  - Multiplier from settings (typically 1.5x)
- **NA2** (Premium Overtime):
  - Weekends (Saturday/Sunday)
  - Holidays (from `na2_holidays` table)
  - Multiplier from settings (typically 2.0x)

---

### 4. Time Card Disputes

**Dispute Structure** (from migration):
```sql
time_card_disputes:
  - id
  - employee_id
  - time_card_id
  - old_start_time
  - old_end_time
  - claimed_start_time (employee's proposed time)
  - claimed_end_time
  - custom_start_time (manager's adjustment)
  - custom_end_time
  - final_time (1=old, 2=claimed, 3=custom)
  - status (0=No dispute, 1=Open, 2=Resolved, 3=Declined)
  - processed_by (user_id of resolver)
```

**Dispute Comment System:**
```sql
time_card_dispute_comments:
  - id
  - time_card_id
  - time_card_dispute_id
  - user_id
  - comment
  - is_management (0=employee, 1=manager)
```

**Angular Endpoints:**
```
POST /api/time-card-dispute
POST /api/add-time-card-dispute-comment
GET  /api/get-all-dispute-comment-by-time-card?card_id={id}&is_mgmt={0|1}
POST /api/time-card-dispute-status-change
```

---

### 5. Jobs System

**Job Structure** (from migration):
```sql
jobs:
  - id
  - display_id (formatted job number)
  - title
  - manager_id
  - foreman_id
  - client_id
  - client_location_id
  - lead_id (originated from lead)
  - status (0=new sale, 1=scheduled, 2=pending, 3=progress, 4=submit inspection, 5=completed, 6=needs love)
```

**Job Items** (individual services within a job):
```sql
job_items:
  - id
  - job_id
  - service_id
  - status
  - crew_id
  - completion_date
  - labour_cost
```

**Crew System:**
```sql
crews:
  - id
  - name
  - foreman_id
  - google_cal_id

crew_members:
  - id
  - crew_id
  - employee_id
  - is_active
```

**Angular Endpoints:**
```
GET /api/get-all-formatted-job?customer_id=&employee_id=&job_id=&status=&page=&stDate=&endDate=
GET /api/get-all-job-term?term={search}
GET /api/jobs-for-time-card?term={search}
GET /api/job/{id}/edit
```

**⚠️ NO Mobile-Specific Job Endpoints**

---

### 6. Services

**Service Structure:**
```sql
services:
  - id
  - name
  - shorthand (abbreviation)
  - status

sub_services:
  - id
  - service_id
  - name
```

**Angular Endpoint:**
```
GET /api/get-all-services?term={search}
```

**Common Services:**
- Roofing
- Siding
- Gutters
- Windows
- Demolition
- Carpentry

---

### 7. Employee/Profile System

**User Fields** (from migrations + API response):
```
users:
  - id
  - designation_id (job title/role)
  - country_id
  - first_name
  - last_name
  - short_name (abbreviation, e.g., "JD")
  - middle_name
  - email (unique)
  - username (unique, optional)
  - password
  - phone
  - company_phone
  - image (profile photo path)
  - address
  - address_2
  - state
  - city
  - zip_code
  - type (1-5: role)
  - is_active (1=active, 2=inactive)
  - foreman_type
  - employee_type
  - sales (is salesperson flag)
  - billing_rate (hourly rate for non-roofing)
  - certification_level (for roofing employees)
  - years_of_experience (for pay matrix lookup)
  - history_id
  - google_cal_id
  - mail_imported
```

**Angular Endpoints:**
```
GET  /api/employee/{id}/edit
PUT  /api/employee/{id}
POST /api/employee
GET  /api/get-all-employee?term={search}&type={type}
GET  /api/get-all-foreman?term={search}
```

**Photo Upload:**
- Photos stored as file paths in `image` field
- No specific mobile photo upload endpoint observed
- Standard file upload via multipart/form-data assumed

**Editable Fields** (based on Angular forms):
- Phone
- Company phone
- Address, address_2, city, state, zip_code
- Image (profile photo)

**NON-Editable by Employee:**
- Pay rate / billing rate
- Certification level
- Employee type
- Role/type

---

### 8. Pay Rate System

**Two Systems:**

1. **Roofing Employees** (`employee_type = 0`):
   - Uses `roofing_payment_matrices` table
   - Lookup by: `certification_level` + `years_of_experience`
   - Returns `hourly_rate`

2. **Other Employees** (`employee_type >= 1`):
   - Uses `billing_rate` field directly

**Endpoint:**
```
GET /api/get-hourly-rate?employee_id={id}
```

**Response:**
```json
{
  "success": true,
  "data": 25.50
}
```

---

### 9. Settings System

**Settings Table Fields:**
```
settings:
  - payroll_cycle (0=weekly, 1=biweekly)
  - na1_status (0=disabled, 1=8hrs/day, 2=40hrs/week)
  - na1_multiplier (e.g., 1.5)
  - na2_status (0=disabled, 1=enabled)
  - na2_multiplier (e.g., 2.0)
  - last_op_cursor (OpenPhone API cursor)
  - markup
  - gcal_id
  - overhead
  - revive_days
```

**Endpoint:**
```
GET /api/get-settings-json
```

---

### 10. Payroll Dates

**Payroll Period Structure:**
```sql
payroll_dates:
  - id
  - week1_start
  - week1_end
  - week2_start
  - week2_end
  - year_name (e.g., "2025")
```

**Endpoint:**
```
GET /api/get-pay-dates
```

---

## 🚨 CRITICAL GAPS FOR MOBILE APP

### What's MISSING for Phase 1-1 through 1-6:

1. **No Mobile API Endpoints:**
   - ❌ `/api/mobile/login`
   - ❌ `/api/mobile/jobs/{employee_id}`
   - ❌ `/api/mobile/punches/batch`
   - ❌ `/api/mobile/timesheet/week/{employee_id}`
   - ❌ `/api/mobile/profile/{id}`
   - ❌ `/api/mobile/disputes`

2. **No GPS Data Storage:**
   - `time_cards` table has **NO** GPS fields
   - No `gps_lat`, `gps_lng`, `gps_accuracy` columns
   - Mobile app requirement conflicts with current schema

3. **No Mobile Device Identification:**
   - No `device_id` or `source` tracking
   - Cannot distinguish mobile punches from job clock punches

4. **No Offline Sync Queue:**
   - No `sync_queue` table
   - No retry mechanism
   - No conflict resolution logic

5. **No Batch Punch Submission:**
   - Current endpoint `/rm-check` handles single punches
   - No batch processing capability

6. **No Mobile-Specific Job Assignment:**
   - Jobs tied to physical job clocks
   - No employee-centric job list API

7. **No Foreman Crew Status API:**
   - No real-time crew punch status endpoint
   - No "who's clocked in" query

---

## 📊 Database Schema Summary

### Core Tables for Mobile App:

**Users:** Employee and user management  
**Jobs:** Job records  
**Job Items:** Services within jobs  
**Crews:** Crew groups  
**Crew Members:** Crew rosters  
**Time Cards:** Punch records  
**Time Card Disputes:** Dispute records  
**Time Card Dispute Comments:** Dispute threads  
**Services:** Service types  
**Sub Services:** Service subcategories  
**Settings:** System configuration  
**Payroll Dates:** Pay period definitions  
**NA2 Holidays:** Premium pay dates  
**Roofing Payment Matrices:** Pay rate lookup  
**Job Clocks:** Physical clock devices  
**Keyfobs:** RFID fobs for job clocks  

---

## 🏗️ Architectural Recommendations

### Option 1: Extend Existing API (Recommended)

**Approach:**
- Create new `/api/mobile/*` routes alongside existing routes
- Extend `time_cards` table with GPS columns
- Add `source` field to distinguish mobile vs job clock
- Build batch punch processing
- Maintain backward compatibility with job clocks

**Pros:**
- Minimal disruption to existing system
- Shared database and user management
- Foremen can see both mobile and job clock punches

**Cons:**
- Must maintain two punch systems
- More complex backend logic

### Option 2: Separate Mobile API (Not Recommended)

**Approach:**
- Build completely new Laravel API for mobile
- Separate database or separate tables
- Sync data between systems

**Pros:**
- Clean separation of concerns
- Easier mobile-specific optimizations

**Cons:**
- Data synchronization complexity
- Duplicate user management
- Foremen cannot see unified data

---

## 🛠️ Required Backend Changes

### Phase 1-1 Changes:

1. **Add GPS columns to `time_cards`:**
   ```sql
   ALTER TABLE time_cards ADD COLUMN gps_lat DECIMAL(10,8) NULL;
   ALTER TABLE time_cards ADD COLUMN gps_lng DECIMAL(11,8) NULL;
   ALTER TABLE time_cards ADD COLUMN gps_accuracy DECIMAL(6,2) NULL;
   ALTER TABLE time_cards ADD COLUMN source VARCHAR(20) DEFAULT 'job_clock';
   ALTER TABLE time_cards ADD COLUMN device_id VARCHAR(255) NULL;
   ```

2. **Create mobile routes:**
   ```php
   Route::middleware(['api', 'jwt.auth'])->prefix('mobile')->group(function() {
       Route::post('/punches/batch', [MobilePunchController::class, 'batchStore']);
       Route::get('/jobs/{employee_id}', [MobileJobController::class, 'getEmployeeJobs']);
       Route::get('/timesheet/week/{employee_id}', [MobileTimesheetController::class, 'getWeeklyTimesheet']);
       Route::get('/profile/{id}', [MobileProfileController::class, 'show']);
       Route::put('/profile/{id}', [MobileProfileController::class, 'update']);
       Route::post('/disputes', [MobileDisputeController::class, 'store']);
       Route::get('/crew/status/{foreman_id}', [MobileCrewController::class, 'getCrewStatus']);
   });
   ```

3. **Create `MobilePunchController`:**
   - Accept batch punch submissions
   - Validate GPS data
   - Check for duplicates by UUID
   - Handle offline queue scenarios

4. **Create `MobileJobController`:**
   - Return jobs for employee (crew member or foreman)
   - Include ±14 day range for foremen
   - Return crew lists with punch statuses

5. **Create `MobileTimesheetController`:**
   - Calculate weekly hours
   - Calculate overtime (NA1/NA2)
   - Return estimated pay

6. **Create `MobileProfileController`:**
   - Return employee profile with pay rate
   - Handle photo uploads

7. **Create `MobileDisputeController`:**
   - Accept dispute submissions with proposed times
   - Handle comment threads

8. **Create `MobileCrewController`:**
   - Return real-time crew punch status for foremen

### Phase 1-2 Changes:

- Implement duplicate punch detection by UUID
- Add punch validation (no IN while already IN)
- Implement batch processing with partial success handling
- Add GPS accuracy validation/flagging

### Phase 1-3 Changes:

- Implement timesheet aggregation logic
- Add foreman crew status queries
- Optimize job list queries for mobile

### Phase 1-4 Changes:

- Implement threaded dispute comments
- Add dispute status management
- Handle profile photo uploads from mobile

---

## 🔧 Code Quality Assessment

### Laravel Backend:

**Strengths:**
- ✅ Modern Laravel 10.x
- ✅ Clean controller/repository pattern
- ✅ Good use of migrations for schema management
- ✅ JWT authentication properly implemented
- ✅ Comprehensive time card calculation logic
- ✅ Good database relationships and foreign keys

**Weaknesses:**
- ⚠️ Very large repositories (TimeCardRepository is 6,514 lines!)
- ⚠️ Inconsistent error handling
- ⚠️ Minimal input validation in some controllers
- ⚠️ No API versioning (/api/v1/)
- ⚠️ No rate limiting on sensitive endpoints
- ⚠️ No automated tests observed
- ⚠️ Commented-out code throughout
- ⚠️ Magic numbers in code (status codes, type codes)
- ⚠️ Tight coupling between time cards and job clocks

**Technical Debt:**
- Database has **292 migrations** (indicates rapid evolution)
- Multiple "alter table" migrations modifying same tables
- Some table designs changed multiple times
- Suggests system has evolved significantly over time

**Security:**
- ✅ JWT tokens used correctly
- ✅ Foreign key constraints in place
- ⚠️ No mention of CSRF protection
- ⚠️ No rate limiting observed
- ⚠️ Token TTL very long (30 days) - security vs UX tradeoff

### Angular Frontend:

**Strengths:**
- ✅ Modern Angular (appears to be v14+)
- ✅ Service-based architecture
- ✅ RxJS observables used correctly
- ✅ Environment configuration for API URLs
- ✅ Component-based structure

**Weaknesses:**
- ⚠️ Very large service files (TimeCardService is 586 lines)
- ⚠️ Inconsistent error handling
- ⚠️ No authentication interceptor observed
- ⚠️ Mixing business logic in services vs components

### Job Clock (Python):

**Observed Files:**
- `archiver.py` - Log archiving
- `check_for_updates.py` - OTA updates
- `wifi.py`, `wifi2.py` - WiFi management
- `rm1.py` - Main clock logic (likely)
- `config/` - Configuration files
- `music/` - Audio feedback files

**Assessment:**
- ⚠️ Python-based embedded system (Raspberry Pi)
- ⚠️ Limited documentation in extracted files
- ⚠️ Appears to POST to `/rm-check` endpoint
- ⚠️ Handles RFID keyfob scanning
- ⚠️ Local WiFi configuration management

---

## 📝 Recommendations for Mobile App Development

### 1. Backend First

**MUST complete these before mobile development:**
- [ ] Extend `time_cards` table with GPS columns
- [ ] Create all `/api/mobile/*` endpoints
- [ ] Implement batch punch processing
- [ ] Add duplicate detection by UUID
- [ ] Create foreman crew status queries
- [ ] Test all endpoints with Postman

### 2. Staged Rollout

**Phase 1:** Build mobile app with NEW endpoints  
**Phase 2:** Test alongside job clocks  
**Phase 3:** Foremen can see both mobile + job clock punches  
**Phase 4:** Gradually phase out job clocks

### 3. Data Migration Strategy

- Mobile punches use `source = 'mobile_app'`
- Job clock punches use `source = 'job_clock'`
- UI distinguishes between sources
- Reporting treats both equally

### 4. Testing Requirements

- **Unit tests** for all mobile controllers
- **Integration tests** for batch punch processing
- **Load testing** for sync scenarios
- **GPS validation** edge cases
- **Duplicate detection** stress tests

### 5. Documentation

- **API documentation** (Swagger/OpenAPI recommended)
- **Mobile integration guide**
- **Postman collection** for all endpoints
- **Database schema** diagrams
- **Authentication flow** diagrams

---

## 🎯 Next Steps

1. **Complete `system_integration_questionnaire.md`** with ALL discovered information
2. **Review findings** with Storm Master / Eugene Therrien
3. **Prioritize backend changes** needed before mobile development
4. **Create backend development tasks**
5. **Update `phased_plan.md`** to reflect actual system architecture
6. **Design mobile-to-backend integration** specification
7. **Begin Phase 1-1** only after backend changes complete

---

## 📞 Questions for Storm Master

1. **Job Clock Transition:** 
   - Will job clocks remain in use alongside mobile app?
    Yes
   - Timeline for phasing out job clocks?
   wE ARE NOT PHASING OUT JOB CLOCKS, WE ARE PROVIDING AND ALTERNATE METHODOLOGY

2. **GPS Requirements:**
   - How accurate must GPS be? (currently assuming ≤80m)
    GENERAL VACINITY- THE DESIRE IS TO USE THE JOB ADDRESS TO VERIFY THAT THE EMPLOYEE PUNCHED IN CLOSE TO THE JOB ASSIGNED
   - What happens if GPS unavailable indoors?
    WE ARE LOOKING FOR A FLAG THAT NOTIFIES THAT GPS WAS UNAVAILABLE

3. **Offline Duration:**
   - Max time employees might be offline? (days? weeks?)
    RARLY - MOST JOBS TAKE 1-2 DAYS AND THEY RETURN TO INTERNET DAILY
   - Storage limits for offline punch queue?
    UNKNOWN - WHY?

4. **Foreman Capabilities:**
   - Can foremen punch in/out via mobile?
    YES
   - Can foremen edit crew punches? (currently NO)
    NOT YET, NO

5. **Pay Rate Visibility:**
   - Should employees see their pay rate in app?
    YES
   - Show estimated pay? (currently planned as YES)
    YES

6. **Backend Development:**
   - Who will build the `/api/mobile/*` endpoints?
    THE THOUGHT IS THAT WE GENERATE A FOLDER THAT HAS OUR VERSION OF THE `/api/mobile/*` endpoints AND A GUIDE FOR THE HUMAN DEVELOPERS TO USE
   - Timeline for backend changes?
    tOO MUCH INFORMATION: tHE DEVELOPERS THAT i AM USING IS REFUSING TO USE AI CODING AGENTS, i AM ASSUMING IT IS BECAUSE THEY MAY FEEL THREATENED. sO MY PLAN IS TO BUILD THE MVP VERSION WITH YOU AND THE `/api/mobile/*` endpoints AND COPY TO A THUMB DRIVE AND HAND IT TO THE COMPANY THAT i HAVE PARTNERED WITH AND OFFER IT TO THEM WITH THE CLAIM THAT i DID THE WORK - THEN LET THEM INSPECT AND REVIEW. THE ALLEGATION AGAINST AI CODING IS THAT AI MAKES TOO COMPLICATED CODE THAT IS DIFFICULT FOR A HUMAN TO READ. LETS PROVE THEM WRONG AND DO A FANTASTIC JOB

7. **Testing Environment:**
   - Staging server available?
    CAN WE RUN LOCALLY TO TEST?
   - Test employee accounts available?
    tHE TAR.GZ ARE CLONES. YOU CAN USE WHATEVER WE WOULD LIKE. I WILL REMOVE THE `extracted/` folder and contents prior to handoff

---

**Analysis Status:** ✅ COMPLETE  
**Next Action:** Review with client & update questionnaire  
**Estimated Backend Work:** 2-3 weeks for mobile API endpoints  
**Mobile App Can Start:** After backend mobile API complete
