# Walkthrough - Timesheet Sync & Rebuild Engine (Phase 1-3 Section 4)

## Overview

This feature implements the critical "glue" between raw punches and the aggregated timesheet view. It ensures that timesheets are always up-to-date with the latest punch data and automatically flags potential issues like missing punches or GPS inaccuracies.

## Changes

### 1. Database Schema

Added 4 new tables to `app_database.dart` (Schema Version 8):

- **`SyncStateLocal`**: Tracks rebuild timestamps and sync status.
- **`TimesheetRollupsLocal`**: Stores cached calculation summaries.
- **`MissingJobLinks`**: Tracks punches referencing unknown jobs.
- **`TimesheetFlagsLocal`**: Stores validation errors (missing OUT, excessive break, etc.).

### 2. Domain Logic

- **`TimesheetRebuildEngine`**: Orchestrates the rebuild process.
  - Triggers on punch sync, job sync, and manual refresh.
  - Debounces requests (2-second window) to prevent thrashing.
  - Updates `TimesheetRollupsLocal` and `SyncStateLocal`.
- **`TimesheetValidator`**: Runs validation rules on daily punches.
  - **Missing OUT**: Flags IN punches without a matching OUT.
  - **Missing IN**: Flags orphan OUT punches.
  - **Excessive Duration**: Flags shifts > 16 hours.
  - **GPS Accuracy**: Flags punches with accuracy > 80m.

### 3. Integration

- **`TimesheetRepository`**: Now depends on `TimesheetRebuildEngine`. Exposes `watchTimesheetFlags` stream.
- **`PunchRepository`**: Triggers a rebuild whenever a punch is recorded.
- **`TimesheetScreen`**: Displays a warning banner and inline error indicators when flags are present.

## Verification Results

### Automated Tests

✅ **All 8 Unit Tests Passed**

- `TimesheetValidator`: 5 tests covering all flag types.
- `TimesheetRebuildEngine`: 3 tests verifying debounce logic and state updates.

### Manual Verification Steps

1. **Automatic Rebuild**:
   - Record a punch.
   - Verify `TimesheetRebuildEngine` logs "Rebuilding timesheet...".
   - Verify `TimesheetScreen` updates automatically.
2. **Validation Flags**:
   - Create an orphan OUT punch.
   - Verify "Missing IN" flag appears on the daily card.
   - Verify warning banner appears at the top of the screen.

## Next Steps

- Implement **Section 5: UI/UX Enhancements** (Design tokens, skeleton loaders).
- Proceed to **Phase 1-4: Backend Integration**.
