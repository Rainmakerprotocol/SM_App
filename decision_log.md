# Storm Master Field App — Decision Log

Use this log to record significant technical, product, or process decisions made during the build. Each entry should include enough detail for future contributors to understand the context, rationale, and impact.

## Entry Template
| ID | Date | Phase / Section | Decision | Rationale | Impact / Follow-ups | Owner |
|----|------|-----------------|----------|-----------|----------------------|-------|
| DL-001 | 2025-11-20 | Phase 1-1 / 1.1 Choose Tech Stack | Adopt Flutter 3.x with Dart + Riverpod state mgmt | Plan already optimized for Flutter; strong offline plugins (Drift, geolocator), single codebase, existing team familiarity | Initialize Flutter repo, document tooling versions, align onboarding docs | E. Therrien |
| DL-002 | 2025-11-21 | Phase 1-1 / 2.1 Offline-First Strategy | Use Drift + sqlite3_flutter_libs for local storage with encrypted columns via future sqlite extensions | Drift gives typed schema migrations + background isolates needed for punch queue; sqlite3_flutter_libs avoids platform SQLite drift; column-level obfuscation handled via app-layer AES until native FFI encryption plugin approved | Scaffold Drift database, add DAO/repository layer, update phased_plan + backend wiring to reference schema | Copilot |

### Guidelines
1. **Create a new ID** for every major decision (format `DL-###`).
2. **Reference the exact section** of `phased_plan.md` or related specs where the decision applies.
3. **Capture rationale** (constraints, trade-offs, data points) so future changes can be evaluated quickly.
4. **List follow-up actions** (doc updates, code changes, QA tasks) and assign an owner.
5. **Cross-link evidence** (PRs, tickets, QA artifacts) when available.

Maintain this log alongside updates to `phased_plan.md`, `COPILOT_BUILD_GUIDE.md`, and backend wiring specs to keep the entire team aligned.
