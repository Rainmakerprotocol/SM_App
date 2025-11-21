# Storm Master Field App Client

Flutter 3.x application for the Storm Master field workforce pilot. This repo is managed via the master build plan in `../phased_plan.md` and inherits backend wiring requirements from `../SM_APP_backend_wiring/`.

## Project Structure
- `lib/` — feature modules, services, offline adapters, view models.
- `test/` — unit/widget tests.
- `assets/` — fonts, icons, Lottie files (to be added per phase).

## Development Quick Start
```bash
cd field_app_client
/workspaces/SM_App/flutter/bin/flutter pub get
/workspaces/SM_App/flutter/bin/flutter run
```

Additional setup steps (Android/iOS signing, dev tooling, CI) are tracked in Phase 1-1 of `phased_plan.md`.
