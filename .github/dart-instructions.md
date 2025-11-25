# Copliot & Dart/Flutter Best Practices

> This document summarizes widely accepted best practices for Dart and Flutter development, based primarily on official documentation and well-regarded ecosystem guides. It is intended as guidance for both humans and AI tools (e.g., GitHub antigravity).

---

## 1. Language & Style (Dart)

### 1.1 Follow “Effective Dart”

- Use the official **Effective Dart** guides for:
  - **Style** – formatting, naming, and layout rules. :contentReference[oaicite:0]{index=0}  
  - **Design** – API design, naming, and consistency guidelines. :contentReference[oaicite:1]{index=1}  
  - **Documentation** – how to write clear doc comments. :contentReference[oaicite:2]{index=2}  

**Key points:**

- Let `dart format` handle code formatting.
- Prefer clear, descriptive names (camelCase for members, PascalCase for types).
- Keep functions and classes small and focused.

### 1.2 Enforce Style Automatically

- Always run `dart format` on commit (pre-commit hook or CI). :contentReference[oaicite:3]{index=3}  
- Use `analysis_options.yaml` to enable lints (e.g., `flutter_lints` package).

---

## 2. Project & Architecture

### 2.1 Separate Layers

Follow Flutter’s architecture recommendations:

- Separate **UI (presentation)** from **data/domain layers**.
- Use **unidirectional data flow**: data flows from data layer → UI; events go UI → data. :contentReference[oaicite:4]{index=4}  
- Prefer **immutable data models** (e.g., `freezed`, `built_value`). :contentReference[oaicite:5]{index=5}  

### 2.2 Choose a Clear Architecture Pattern

Common patterns:

- MVVM, Clean Architecture, or similar layered approaches.
- Keep domain logic in pure Dart (no Flutter imports) where possible. :contentReference[oaicite:6]{index=6}  

**Guidelines:**

- Avoid putting business logic directly in widgets.
- Use dependency injection (e.g., `get_it`, `riverpod`, `provider`) instead of global singletons. :contentReference[oaicite:7]{index=7}  

---

## 3. Widgets & UI Design

### 3.1 Keep Widgets Small & Composable

- Break large widgets into smaller, focused widgets.
- Prefer `StatelessWidget` when possible; only use `StatefulWidget` when local mutable state is required. :contentReference[oaicite:8]{index=8}  

### 3.2 Adaptive & Responsive Best Practices

- Design for multiple form factors (mobile, tablet, web).
- Don’t hard-lock orientation unless absolutely necessary.
- Avoid device-type checks; design for capabilities instead.
- Restore list and navigation state appropriately. :contentReference[oaicite:9]{index=9}  

---

## 4. Performance Best Practices

### 4.1 General Performance

- Use Flutter’s performance best-practices docs as baseline. :contentReference[oaicite:10]{index=10}  
- Measure first: use the DevTools performance view and profile mode on **real devices**. :contentReference[oaicite:11]{index=11}  

### 4.2 Rendering & Build Optimization

- Minimize rebuilds:
  - Use `const` constructors where appropriate.
  - Lift expensive work out of `build()` methods.
- Split complex widgets into smaller widgets to let Flutter rebuild only what changed.
- Use lazy lists (`ListView.builder`, `GridView.builder`) for large or unbounded collections. :contentReference[oaicite:12]{index=12}  

### 4.3 App Size & Loading

- Enable **tree shaking** and deferred loading for web. :contentReference[oaicite:13]{index=13}  
- Avoid unnecessarily large assets; compress images where appropriate.

---

## 5. State Management

### 5.1 Principles

- Prefer predictable, testable state management:
  - Unidirectional data flow.
  - Clear separation between state and UI.
- Use a single source of truth for each piece of state.

### 5.2 Common Approaches

- For simple apps: `setState`, `InheritedWidget`, or `provider`.
- For larger apps: `riverpod`, `Bloc`, `Cubit`, Redux-style, or other well-known libraries.

Use official architecture recommendations as a north star and adapt to project needs. :contentReference[oaicite:14]{index=14}  

---

## 6. Testing

### 6.1 Testing Levels

Flutter officially supports: :contentReference[oaicite:15]{index=15}  

- **Unit tests** – test a single function/class.
- **Widget tests** – test a single widget in isolation.
- **Integration tests** – test the full app on a device/emulator.

A healthy app has:

- Many **unit** and **widget** tests,
- A smaller number of **integration** tests that cover critical paths. :contentReference[oaicite:16]{index=16}  

### 6.2 Best Practices

- Place tests in `test/` directory; files should end with `_test.dart`. :contentReference[oaicite:17]{index=17}  
- Use descriptive test names and group related tests.
- Consider TDD/BDD or at least write tests alongside features. :contentReference[oaicite:18]{index=18}  

---

## 7. Documentation & Comments

- Use Dart doc comments (`///`) for public APIs.
- Start doc comments with a **single-sentence summary** in user-centric language. :contentReference[oaicite:19]{index=19}  
- Document:
  - What a class/function does.
  - Parameters, return values, and side effects.
- Avoid redundant comments; let code + good naming carry most of the meaning.

---

## 8. Packages & Dependencies

- Prefer well-maintained, popular packages with good documentation.
- Keep dependencies minimal to avoid bloated binaries and conflicts.
- Regularly run `flutter pub outdated` and upgrade thoughtfully.

---

## 9. Security & Privacy (High-Level)

- Do not store secrets (API keys, tokens) directly in code; use secure storage or environment configuration.
- Be mindful of logging; avoid logging sensitive user data.
- Validate all data from external sources (APIs, user input).

---

## 10. How to Use This with GitHub antigravity

When prompting antigravity in a Dart/Flutter repo:

- Remind it to follow **Effective Dart** and these best practices.
- Ask it to:
  - Keep widgets small and composable.
  - Separate UI from business logic.
  - Provide tests (`_test.dart`) for new logic.
  - Add appropriate `///` doc comments for public APIs.

You are helping in a Dart/Flutter project that follows Effective Dart and Flutter’s official architecture and performance best practices.
When generating code:

- Keep widgets small and composable.
- Separate UI from business logic (follow unidirectional data flow).
- Use const widgets and avoid heavy work in build().
- Add unit or widget tests in the test/ folder with *_test.dart filenames.
- Add Dart doc comments (///) for public classes and methods.
