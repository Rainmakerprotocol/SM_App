# Storm Master Field App — antigravity Build Guide

**How to Use Your Phased Plan with GitHub antigravity in VS Code**

---

## 🎯 Overview

You have an **excellent foundation** for building with AI assistance! Your `phased_plan.md` is already structured perfectly for incremental, AI-guided development. This guide explains:

1. **What you have** (your current plan)
2. **How to convert it** to antigravity-ready tasks
3. **Best practices** for working with antigravity
4. **The integration questionnaire** you'll need to complete

---

## 📊 What You Have: Project Analysis

### **Project:** Storm Master Field App

**Type:** Mobile workforce management application  
**Platforms:** Android + iOS  
**Stack Options:** Flutter (preferred) or React Native  
**Backend:** Laravel API + MySQL (existing system)  

### **Core Features:**

- ✅ Offline-first time punching with GPS tracking
- ✅ Job management (employees see their jobs, foremen see crew ±14 days)
- ✅ Automatic timesheet calculations with estimated pay
- ✅ Dispute workflow for punch corrections
- ✅ Profile management with photo uploads
- ✅ Foreman crew monitoring dashboard
- ✅ Background sync engine with retry logic

### **Your Plan Structure:**

```
Phase 1-1 (Week 1): Project Setup & Foundations
Phase 1-2 (Week 2): Offline Punching System + GPS + Sync
Phase 1-3 (Week 3): Jobs, Timesheets & Foreman Features
Phase 1-4 (Week 4): Disputes, Profile Management, UI Polish
Phase 1-5 (Week 5): Testing, Optimization & QA
Phase 1-6 (Week 6): Final Polish, Deployment & Handoff
```

---

## ✅ Why Your Plan is Already antigravity-Ready

Your `phased_plan.md` has these **critical success factors**:

### 1️⃣ **Micro-Task Breakdown**

✅ Each phase is divided into specific, sequential steps  
✅ Tasks are small enough to implement individually  
✅ Clear "what to build" descriptions at each step

**Example from Phase 1-2:**

```markdown
### 1.1 Create Punch Screen Layout
- Build UI elements:
  - Punch In button
  - Punch Out button
  - Break Start
  - Break End
```

This is **perfect** for antigravity because:

- It's specific ("Create Punch Screen Layout")
- It lists exact components needed
- It can be built and tested incrementally

---

### 2️⃣ **Clear Completion Criteria**

✅ Each phase ends with measurable outcomes  
✅ No ambiguity about "done"

**Example from Phase 1-1:**

```markdown
### 6.1 Project Compiles on Both Platforms
- No errors
- Clean scaffolding
- Ready for development
```

---

### 3️⃣ **Technology Decisions Documented**

✅ Stack choices explicit (Flutter/React Native)  
✅ Database choice clear (SQLite for offline)  
✅ Auth method defined (token-based)

This eliminates antigravity "guessing" at architecture.

---

### 4️⃣ **API Contract Requirements**

✅ Endpoints listed with expected payloads  
✅ Request/response examples provided

**Example from Phase 1-1:**

```markdown
### 4.1 Map Required Endpoints
- /api/mobile/login
- /api/mobile/jobs/{employee_id}
- /api/mobile/punches/batch
```

---

### 5️⃣ **Built-in Testing Requirements**

✅ Each phase includes test scenarios  
✅ Edge cases documented

**Example from Phase 1-2:**

```markdown
### 8.1 Offline Test Scenarios
- Airplane mode punch
- Airplane mode → travel → reconnect → sync
```

---

## 🔄 Converting Your Plan to antigravity Workflow

### **Step 1: Complete the Integration Questionnaire**

Before starting development, you **MUST** complete:

```
system_integration_questionnaire.md
```

This document asks critical questions about your **existing Laravel backend**:

- What are the actual API endpoints?
- What authentication method is used?
- What do the request/response payloads look like?
- How should the mobile app handle conflicts?
- What error codes does the API return?

**Why this matters:**

- Prevents rework (building against the wrong API structure)
- Ensures compatibility (mobile app matches backend expectations)
- Clarifies unknowns (database schemas, timezone handling, etc.)

**How to complete it:**

1. Open `system_integration_questionnaire.md`
2. Review each section with your backend team
3. Fill in ALL checkboxes and code examples
4. Get technical sign-off before Phase 1-1

---

### **Step 2: Use antigravity's Task Tracking**

As you work through each phase, use antigravity's `manage_todo_list` feature:

**Example for Phase 1-1:**

```
Tell antigravity:
"I want to start Phase 1-1. Create a todo list from the phased_plan.md Phase 1-1 tasks."
```

antigravity will create trackable tasks like:

```
[ ] 1.1 Choose tech stack (Flutter vs React Native)
[ ] 1.2 Initialize project repository
[ ] 1.3 Add platform builds
[ ] 2.1 Define offline-first strategy
...
```

**As you complete each task:**

```
Tell antigravity:
"Mark task 1.2 as complete and start task 1.3"
```

This ensures:

- ✅ No steps are forgotten
- ✅ Progress is visible
- ✅ You can resume from where you left off

---

### **Step 3: Work Incrementally**

**DON'T** ask antigravity to build the entire app at once.  
**DO** work through phases sequentially.

**Good antigravity prompt:**

```
"Let's implement Phase 1-2, Section 1.1: Create Punch Screen Layout.
Build a Flutter screen with Punch In, Punch Out, Break Start, and Break End buttons.
Include a status indicator showing if user is currently clocked in."
```

**Why this works:**

- Focused request
- References specific section
- Clear deliverable
- Can be tested immediately

**Bad prompt:**

```
"Build the entire Storm Master Field App"
```

**Why this fails:**

- Too broad
- Can't validate in pieces
- Harder to debug
- Overwhelms context

---

### **Step 4: Validate After Each Sub-Phase**

After implementing each section, **test it** before moving on:

**Example workflow for Phase 1-2:**

```
1. Build offline punch UI → Test buttons render correctly
2. Add GPS integration → Test GPS permissions and coordinates
3. Create local storage → Test data persists offline
4. Build sync queue → Test batch upload when online
5. Full integration test → Test complete offline→online flow
```

**Tell antigravity:**

```
"I've completed Phase 1-2, Section 2 (GPS Integration).
Run the app and verify GPS coordinates are captured when I tap Punch In."
```

---

### **Step 5: Reference the Integration Questionnaire**

When building API integrations, reference the completed questionnaire:

**Example:**

```
"Based on system_integration_questionnaire.md Section 4.2,
build the punch submission API call.
Use the endpoint and payload structure documented there."
```

This ensures:

- ✅ API calls match backend expectations
- ✅ Error handling uses correct status codes
- ✅ Authentication headers are correct

---

## 🛠️ Best Practices for Working with antigravity

### **1. Be Specific About File Context**

❌ **Vague:** "Add a login screen"  
✅ **Specific:** "In `lib/screens/login_screen.dart`, create a login form with email and password fields matching the API in `system_integration_questionnaire.md` Section 1.1"

---

### **2. Reference Your Own Documentation**

✅ "Following `phased_plan.md` Phase 1-1, Section 1.2..."  
✅ "According to `system_integration_questionnaire.md` Section 4.2..."

This keeps antigravity aligned with YOUR requirements, not generic patterns.

---

### **3. Request Explanations**

```
"Explain the sync queue architecture you're implementing for Phase 1-2, Section 4.2"
```

This helps you:

- Understand what's being built
- Catch mistakes early
- Learn the codebase structure

---

### **4. Ask for Testing Guidance**

```
"What test cases should I run for Phase 1-2's offline punch feature?"
```

antigravity can generate:

- Unit tests
- Integration tests
- Manual test scenarios

---

### **5. Request Refactoring When Needed**

```
"The punch submission code is getting messy.
Refactor it following Phase 1-2's sync queue architecture."
```

---

### **6. Parallelize Independent Tasks**

Some tasks have no dependencies:

**Example:**

```
"I want to work on these simultaneously:
1. Build the Job List UI (Phase 1-3, Section 1.3)
2. Create the Profile Edit UI (Phase 1-4, Section 2.3)

These don't depend on each other. Create both screens in parallel."
```

---

## 📋 Recommended Phase-by-Phase Workflow

### **Phase 1-1: Foundation (Week 1)**

```
antigravity Prompts:
1. "Help me choose between Flutter and React Native based on team experience"
2. "Initialize a new Flutter project called stormmaster_field_app"
3. "Set up the folder structure from phased_plan.md Section 1.2"
4. "Create placeholder screens for Login, Home, Punch, Jobs, Timesheet, Profile"
5. "Set up bottom tab navigation"
6. "Create API service files for login, jobs, punches, profile"
7. "Build the SQLite schema from phased_plan.md Section 2.1"
```

**Completion Check:**

- App runs on Android emulator
- App runs on iOS simulator
- All placeholder screens navigate correctly
- No build errors

---

### **Phase 1-2: Offline Punching (Week 2)**

```
antigravity Prompts:
1. "Build the Punch Screen UI from Phase 1-2, Section 1.1"
2. "Add GPS permissions and location fetching (Section 2)"
3. "Implement local punch storage to SQLite (Section 3)"
4. "Build the sync queue engine (Section 4)"
5. "Connect to the punch batch API from system_integration_questionnaire.md"
6. "Add offline banner and GPS accuracy indicator"
7. "Implement duplicate punch prevention"
```

**Completion Check:**

- Punch works in airplane mode
- GPS coordinates captured
- Punches sync when back online
- No duplicate punches created

---

### **Phase 1-3: Jobs & Timesheets (Week 3)**

```
antigravity Prompts:
1. "Implement job list fetching and local storage (Section 1)"
2. "Build the Job List Screen with today/this week/last week sections"
3. "Create the timesheet calculation engine (Section 2)"
4. "Build daily and weekly timesheet UI"
5. "Add estimated pay display"
6. "Implement Foreman crew view (Section 3)"
```

**Completion Check:**

- Jobs load and display correctly
- Timesheets calculate accurately
- Estimated pay matches expected logic
- Foremen see crew status

---

### **Phase 1-4: Disputes & Polish (Week 4)**

```
antigravity Prompts:
1. "Implement dispute submission (Section 1)"
2. "Build dispute form UI with reason and comments"
3. "Add profile editing (Section 2)"
4. "Implement photo upload for profile"
5. "Polish all UI elements (Section 3)"
6. "Add loading states and empty states"
7. "Implement error handling"
```

**Completion Check:**

- Disputes submit offline and sync
- Profile updates work
- UI is consistent and polished
- All error cases handled

---

### **Phase 1-5: Testing & QA (Week 5)**

```
antigravity Prompts:
1. "Generate test cases for Phase 1-2's offline punch feature"
2. "Run stress tests: 100 punches in queue"
3. "Test GPS accuracy in various conditions"
4. "Test rapid UI interactions and app backgrounding"
5. "Profile all screens for performance bottlenecks"
6. "Optimize database queries"
```

**Completion Check:**

- All test scenarios pass
- No crashes under stress
- Performance acceptable on low-end devices

---

### **Phase 1-6: Deployment (Week 6)**

```
antigravity Prompts:
1. "Create Android release build with signing"
2. "Create iOS release build for TestFlight"
3. "Generate developer documentation"
4. "Create build and deploy instructions"
5. "Generate QA test checklist"
6. "Prepare handoff package"
```

**Completion Check:**

- Signed builds created
- Documentation complete
- Ready for production

---

## 🚀 Getting Started Checklist

Before you ask antigravity to start building:

- [ ] **Read through** `phased_plan.md` completely
- [ ] **Complete** `system_integration_questionnaire.md`
- [ ] **Get technical sign-off** on questionnaire answers
- [ ] **Decide:** Flutter or React Native?
- [ ] **Confirm** you have:
  - [ ] Android emulator or device
  - [ ] iOS simulator or device
  - [ ] Access to staging/test API
  - [ ] Test employee accounts
- [ ] **Have antigravity create** Phase 1-1 todo list
- [ ] **Begin** with Phase 1-1, Section 1.1

---

## 💡 Pro Tips

### **1. Save antigravity Context**

After completing each phase, ask antigravity to summarize:

```
"Summarize what we've built in Phase 1-2 and what challenges we encountered"
```

Save these summaries for:

- Onboarding new developers
- Debugging future issues
- Understanding architectural decisions

---

### **2. Use antigravity for Code Review**

```
"Review the punch submission code in lib/services/punch_service.dart.
Are there any edge cases we're missing?"
```

---

### **3. Ask About Alternative Approaches**

```
"We're using SQLite for offline storage.
Are there any downsides to this approach for our sync queue?"
```

---

### **4. Request Documentation as You Build**

```
"Add inline comments explaining the sync queue retry logic"
```

---

### **5. Keep antigravity Updated on Changes**

If backend requirements change:

```
"The backend team changed the punch batch endpoint.
Update the API call in punch_service.dart based on the new structure in system_integration_questionnaire.md"
```

---

## 🎓 What You've Learned

### **Your `phased_plan.md` is excellent because:**

1. ✅ Tasks are small and specific
2. ✅ Phases build on each other sequentially
3. ✅ Completion criteria are clear
4. ✅ Testing is built into each phase
5. ✅ Architecture is well-documented

### **The missing piece was:**

- **System integration details** (now captured in `system_integration_questionnaire.md`)

### **Now you have a complete AI-assisted development plan:**

```
phased_plan.md (WHAT to build)
    +
system_integration_questionnaire.md (HOW to connect to existing backend)
    +
antigravity_BUILD_GUIDE.md (HOW to work with antigravity)
    =
🚀 Ready to Build!
```

---

## 📞 Next Steps

1. **Complete** `system_integration_questionnaire.md`
2. **Review** questionnaire with backend team
3. **Get approval** on API contracts
4. **Tell antigravity:** "Let's start Phase 1-1. Create a todo list from phased_plan.md Phase 1-1."
5. **Build incrementally** through each phase
6. **Test thoroughly** at each milestone
7. **Deploy** with confidence!

---

## 🎉 You're Ready

Your planning work was already 90% of the way there. The questionnaire fills the final 10% (backend integration details).

**When you're ready to start:**

```
"antigravity, I've completed system_integration_questionnaire.md and I'm ready to begin Phase 1-1.
Let's start by choosing our tech stack and initializing the project."
```

Good luck with your Storm Master Field App! 🌩️📱

---

**Document Version:** 1.0  
**Last Updated:** November 20, 2025  
**Next Review:** After Phase 1-1 completion
