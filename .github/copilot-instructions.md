# antigravity Instructions

## Big Picture

- You are working on the Storm Master Field App, a Flutter mobile client for field technicians to log work and sync with a backend.
- `phased_plan.md` is the canonical build plan and now uses a Past/Present/Future narrative. Always read the relevant section, note which perspective you are affecting, and update the plan (plus cite decision IDs) whenever scope or priority shifts.
- The workspace has three pillars: Flutter client (`field_app_client/`), backend wiring specs (`SM_APP_backend_wiring/`), and QA evidence (`qa/`). Keep changes aligned across all three.
- Major decisions must be logged in `decision_log.md` (ID, rationale, impact). Reference those IDs inside code or docs you touch.

## Mobile Client Workflow (Flutter)

- Flutter SDK lives locally under `/workspaces/SM_App/flutter/`; run commands with the full path (e.g., `/workspaces/SM_App/flutter/bin/flutter pub get`). `flutter doctor` currently reports missing Android SDK/Chrome—note blockers in PRs.
- The generated app is in `field_app_client/`. Keep modules organized under `lib/` (`modules`, `services`, `offline`, `screens`, etc.) per Phase 1-1 guidance. Shared theme + DI scaffolding are expected even for placeholder screens.
- When creating features, follow the offline-first tables + sync rules defined in the plan (e.g., `punches_local`, `sync_queue`). Document schema or sync tweaks in both the code and `phased_plan.md` / `SM_APP_backend_wiring`.

## Backend Integration Expectations

- All `/api/mobile/*` endpoints are defined conceptually in `SM_APP_backend_wiring/MOBILE_BACKEND_INTEGRATION_SPEC.md`. If you touch networking code, confirm payloads there or update the spec first.
- Do **not** modify contents of `external/`; new backend samples, Postman collections, or SQL scripts belong in `SM_APP_backend_wiring/`.
- When adding API services (e.g., `api/job_service.dart`), provide both real + mock providers so QA can operate without a live backend.

## Documentation & QA Alignment

- Treat documentation as code: update `phased_plan.md`, `antigravity_BUILD_GUIDE.md`, QA templates, and decision log whenever behavior or workflow changes. Note which Past/Present/Future statements you revised.
- Testing evidence is mandatory. Store results in `qa/` (device gallery, logs, reports, checklists) and link them from the relevant plan sections so future readers see both narrative and proof.
- Use `manage_todo_list` to track multi-step work (mirroring phase checklists) so future agents can resume mid-task with full historical context.

## Build/Test Workflow

- Typical commands:
  - `cd field_app_client && /workspaces/SM_App/flutter/bin/flutter pub get`
  - `cd field_app_client && /workspaces/SM_App/flutter/bin/flutter analyze`
  - `cd field_app_client && /workspaces/SM_App/flutter/bin/flutter test`
  - `cd field_app_client && /workspaces/SM_App/flutter/bin/flutter run -d <device>`
- Capture APK/IPA artifacts and attach them under `qa/artifacts/<build-id>/` when builds succeed.
- Document CI/nightly build expectations in `phased_plan.md` Section 6 once automation scripts are added.

## Conventions & Reminders

- Keep files ASCII unless the target already uses Unicode. Add concise comments only when logic isn’t obvious.
- Preserve user-managed changes; never revert unrelated edits.
- Before implementing changes, scan `phased_plan.md` for “Decision Hook” notes—they often require corresponding entries in `decision_log.md`.
- Always double-check for cross-document alignment: plan ↔ backend spec ↔ QA evidence. If unsure, ask for clarification in the plan before coding.

## Additional Instructions

*Follow instructions outlined in .github/dart-instructions.md for more details.
- When generating code, follow Effective Dart and Flutter’s official architecture and performance best practices.
- Keep widgets small and composable.
- Separate UI from business logic (follow unidirectional data flow).
- Use const widgets and avoid heavy work in build().
*Follow instructions outlined in .github/dart-instructions.md for more details.
