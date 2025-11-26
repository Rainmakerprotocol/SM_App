# Timesheet Calculation Reference - Mobile vs Backend

**Purpose**: Quick reference for troubleshooting discrepancies between mobile app calculations and backend/web app calculations.

**Last Updated**: November 26, 2025

---

## 🎯 Quick Troubleshooting Guide

When mobile and backend timesheet totals don't match, check these locations in order:

### 1. **Mobile Calculation Logic**

- **Location**: `field_app_client/lib/modules/timesheet/application/timesheet_aggregator.dart`
- **What to check**: Daily hours, weekly totals, OT calculations
- **Key methods**: `calculateDailyHours()`, `calculateWeeklyTotals()`, `applyOvertimeRules()`

### 2. **Backend Calculation Logic**

- **Location**: `extracted/storm-master-laravel/app/Services/MobileTimesheetService.php`
- **What to check**: NA1/NA2 logic, payroll rules
- **Key methods**: `calculateWeeklyTimesheet()`, `applyOvertimeRules()`

### 3. **Data Source (Punches)**

- **Mobile**: `field_app_client/lib/offline/database/app_database.dart` → `PunchesLocal` table
- **Backend**: `extracted/storm-master-laravel/database/` → `time_cards` table
- **What to check**: Punch timestamps, job IDs, punch types (IN/OUT)

### 4. **API Contract**

- **Spec**: `SM_APP_backend_wiring/MOBILE_BACKEND_INTEGRATION_SPEC.md` lines 129-157
- **Sample**: `SM_APP_backend_wiring/mock_external/payloads/timesheet_week_sample.json`
- **What to check**: Field mappings, data types, calculation results

---

## 📍 Mobile App Calculation Locations

### Core Calculation Files

| Component | File Path | Purpose |
|-----------|-----------|---------|
| **Timesheet Aggregator** | `lib/modules/timesheet/application/timesheet_aggregator.dart` | Main calculation engine |
| **Timesheet Repository** | `lib/modules/timesheet/data/timesheet_repository.dart` | Data access layer |
| **Local Database** | `lib/offline/database/app_database.dart` | `TimesheetLocal` table schema |
| **Business Rules** | `lib/modules/timesheet/domain/timesheet_rules.dart` | OT rules, break deductions |
| **Punch Source** | `lib/offline/database/app_database.dart` | `PunchesLocal` table (lines 11-35) |

### Key Calculation Methods

```dart
// lib/modules/timesheet/application/timesheet_aggregator.dart

// Daily hours calculation
double calculateDailyHours(List<Punch> punches) {
  // Logic: Sum (OUT - IN) for each punch pair
  // Subtract break hours
  // Round to nearest 0.25 hour
}

// Weekly totals
WeeklyTotals calculateWeeklyTotals(List<DailyTimesheet> days) {
  // Logic: Sum all daily hours
  // Apply NA1 or NA2 overtime rules
  // Calculate estimated pay
}

// Overtime rules (NA1 vs NA2)
OvertimeBreakdown applyOvertimeRules(double totalHours, String ruleType) {
  // NA1: Daily OT after 8 hours
  // NA2: Weekly OT after 40 hours
}
```

### Test Files

| Test File | What It Validates |
|-----------|-------------------|
| `test/modules/timesheet/timesheet_aggregator_test.dart` | Calculation logic accuracy |
| `test/modules/timesheet/timesheet_repository_test.dart` | Data persistence |
| `test/modules/timesheet/overtime_rules_test.dart` | NA1/NA2 rule application |

---

## 📍 Backend Calculation Locations

### Laravel Files (Estimated - To Be Confirmed)

| Component | File Path | Purpose |
|-----------|-----------|---------|
| **Timesheet Service** | `app/Services/MobileTimesheetService.php` | Main calculation engine |
| **Timesheet Controller** | `app/Http/Controllers/MobileTimesheetController.php` | API endpoint |
| **Database Model** | `app/Models/TimeCard.php` | Punch data model |
| **Payroll Rules** | `app/Services/PayrollCalculationService.php` | NA1/NA2 logic (existing) |

### Expected Backend Methods

```php
// app/Services/MobileTimesheetService.php

public function calculateWeeklyTimesheet($employeeId, $weekStart, $weekEnd) {
    // 1. Fetch punches from time_cards table
    // 2. Group by day
    // 3. Calculate daily hours
    // 4. Apply overtime rules (NA1/NA2)
    // 5. Calculate estimated pay
    // 6. Return formatted response
}

public function applyOvertimeRules($totalHours, $ruleType) {
    // NA1: Daily OT after 8 hours
    // NA2: Weekly OT after 40 hours
    // Match existing payroll logic
}
```

---

## 🔍 Common Discrepancy Scenarios

### Scenario 1: Total Hours Don't Match

**Check:**

1. **Punch data sync**: Are all punches synced to backend?
   - Mobile: `SELECT * FROM punches_local WHERE synced = false`
   - Backend: Check `time_cards` table for same employee/week
2. **Timezone handling**: Are timestamps in same timezone?
   - Mobile: `timestampDevice` field (local time)
   - Backend: Should convert to same timezone
3. **Rounding differences**: How are hours rounded?
   - Mobile: Check `timesheet_aggregator.dart` rounding logic
   - Backend: Check `MobileTimesheetService.php` rounding logic

### Scenario 2: Overtime Calculation Differs

**Check:**

1. **OT Rule Type**: Is employee using NA1 or NA2?
   - Mobile: Check `profile_local` table → `overtime_rule` field
   - Backend: Check `users` table → `overtime_rule` field
2. **Daily vs Weekly**: Are both using same rule?
   - NA1 = Daily OT after 8 hours
   - NA2 = Weekly OT after 40 hours
3. **Break deductions**: Are breaks handled consistently?
   - Mobile: Check break hour calculations
   - Backend: Check break hour calculations

### Scenario 3: Missing Punches

**Check:**

1. **Sync status**: Has mobile synced all punches?
   - Mobile: `SELECT COUNT(*) FROM punches_local WHERE synced = false`
2. **Date range**: Are both using same week boundaries?
   - Mobile: `weekStart` and `weekEnd` in `TimesheetLocal`
   - Backend: Week calculation in API
3. **Deleted punches**: Were any punches deleted?
   - Check `deleted_at` timestamps

### Scenario 4: Estimated Pay Differs

**Check:**

1. **Pay rate**: Is pay rate same in both systems?
   - Mobile: `profile_local` table → `pay_rate` field
   - Backend: `users` table → `pay_rate` field
2. **OT multiplier**: Are OT rates same?
   - Standard: 1.5x for OT
   - Check both mobile and backend multipliers
3. **Calculation order**: Are calculations in same order?
   - Regular hours × rate + OT hours × (rate × 1.5)

---

## 📊 Data Flow Diagram

```
Mobile Punches → Sync Queue → Backend API → Backend Database
       ↓                                            ↓
  TimesheetLocal                              time_cards
       ↓                                            ↓
Mobile Aggregator                        Backend Service
       ↓                                            ↓
Mobile Timesheet UI  ←  Compare  →  Backend Timesheet API
```

---

## 🛠️ Debugging Commands

### Mobile (Flutter)

```bash
# View local punches
flutter run --debug
# Then in Dart DevTools:
# SELECT * FROM punches_local WHERE employee_id = 12;

# View timesheet calculations
# Add breakpoint in timesheet_aggregator.dart
# Inspect variables during calculation

# Export local database
adb exec-out run-as com.stormmaster.field_app cat databases/app_database.db > local.db
sqlite3 local.db "SELECT * FROM timesheet_local;"
```

### Backend (Laravel)

```bash
# View time_cards for employee
php artisan tinker
>>> TimeCard::where('employee_id', 12)->get();

# Test timesheet calculation
>>> $service = app(MobileTimesheetService::class);
>>> $result = $service->calculateWeeklyTimesheet(12, '2025-11-17', '2025-11-23');
>>> dd($result);

# Check API response
curl -H "Authorization: Bearer {token}" \
  http://localhost/api/mobile/timesheet/week/12
```

---

## 📋 Validation Checklist

When investigating discrepancies, verify:

- [ ] Same punch data in both systems (count, timestamps, job IDs)
- [ ] Same week boundaries (start/end dates)
- [ ] Same OT rule (NA1 vs NA2)
- [ ] Same pay rate
- [ ] Same break hour deductions
- [ ] Same rounding rules (0.25 hour increments?)
- [ ] Same timezone handling
- [ ] All punches synced (no pending in mobile queue)
- [ ] No deleted/disputed punches affecting totals
- [ ] Mobile and backend using same calculation order

---

## 🔗 Related Documentation

- **Integration Spec**: `SM_APP_backend_wiring/MOBILE_BACKEND_INTEGRATION_SPEC.md`
- **API Contract**: Lines 129-157 (Timesheet Response)
- **Sample Payload**: `SM_APP_backend_wiring/mock_external/payloads/timesheet_week_sample.json`
- **Backend Tasks**: `SM_APP_backend_wiring/BACKEND_TASKS_BOARD.md` (Task B-07)
- **Phased Plan**: `phased_plan.md` Section 1-3 §2 (Timesheet Engine)

---

## 📞 Escalation Path

If discrepancy cannot be resolved:

1. **Document the issue**:
   - Employee ID
   - Week dates
   - Mobile total vs Backend total
   - Specific punch data
   - Screenshots from both systems

2. **Create comparison report**:
   - Export mobile `timesheet_local` data
   - Export backend `time_cards` data
   - Side-by-side comparison

3. **Contact teams**:
   - Mobile team: Review calculation logic
   - Backend team: Review API/service logic
   - QA team: Validate test scenarios

4. **Log in tracking**:
   - Create issue in project tracker
   - Tag: `timesheet-discrepancy`
   - Include all comparison data

---

**Note**: This document will be updated as mobile timesheet implementation progresses. File paths are estimates and should be confirmed during implementation.
