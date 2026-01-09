<!--
Sync Impact Report:
Version: 1.0.0 → 1.1.0
Rationale: MINOR version bump - Added new principle for internationalization (Principle VII)
Modified principles: None
Added sections:
  - Principle VII: Internationalization-First Design (new principle for multi-language support)
  - Updated Technical Standards with Localization subsection
Removed sections: None
Templates status:
  ✅ .specify/templates/plan-template.md - reviewed, aligns with new i18n principle
  ✅ .specify/templates/spec-template.md - reviewed, requirements structure supports i18n
  ✅ .specify/templates/tasks-template.md - reviewed, task organization accommodates i18n work
Follow-up TODOs: None
-->

# DailyBrain Constitution

## Core Principles

### I. Mobile-First Performance
Every feature MUST meet strict mobile performance standards:
- App launch: < 2s to interactive
- Quiz load: < 1s to first question display
- Score submission: < 2s server response
- Ranking load: < 1.5s full list display
- App size: < 30MB download

**Rationale:** Mobile users abandon apps that feel slow. Performance directly impacts retention and user satisfaction. These targets ensure the app feels instant and lightweight.

### II. Offline Resilience
The app MUST function gracefully without network connectivity:
- Local caching of last played quiz and user stats
- Queue pending operations (score submissions) for sync when online
- Clear visual feedback when offline
- No crashes or blocking errors due to connectivity loss

**Rationale:** Mobile networks are unreliable. Users should be able to view their progress and stats anytime, building habit formation even without connectivity.

### III. Server-Side Validation (NON-NEGOTIABLE)
All user-submitted data MUST be validated and recalculated server-side:
- Score calculations performed on server, never trusted from client
- Quiz timing validated (minimum time per question enforced)
- Duplicate submissions prevented via quiz_id + user_id uniqueness
- Rate limiting applied to all API endpoints

**Rationale:** Client-side data can be manipulated. Gaming systems (rankings, streaks) require server authority to maintain fairness and prevent cheating.

### IV. Feature-Based Architecture
Code MUST be organized by feature domains with clear boundaries:
- Each feature (quiz, streak, ranking, user) has isolated data/presentation/domain layers
- Shared components live in dedicated shared/ directory
- Services are cross-cutting concerns (ads, analytics, notifications)
- No circular dependencies between features

**Rationale:** Feature-based structure enables independent development, testing, and iteration of user stories. Clear boundaries prevent coupling and enable team parallelization.

### V. User Experience Non-Negotiables
Every interaction MUST prioritize user engagement:
- Ads shown only AFTER quiz completion (never during gameplay)
- Animations must respect system accessibility settings (prefers-reduced-motion)
- Touch targets minimum 44x44px for accessibility
- Immediate visual feedback on all user actions (< 100ms)
- Streak recovery always optional via rewarded video (never forced)

**Rationale:** User retention depends on respecting their time and attention. Intrusive monetization or poor UX kills engagement metrics (D1/D7 retention targets).

### VI. Test-Driven for Business Logic
Core business logic MUST have unit test coverage:
- Score calculation algorithms
- Streak validation and recovery logic
- Rate limiting and anti-cheat validation
- Time-based availability rules (daily quiz logic)

**Rationale:** Business logic bugs directly impact fairness, monetization, and user trust. Unit tests prevent regressions in critical scoring, streak, and validation systems.

### VII. Internationalization-First Design
All user-facing content MUST be internationalized from day one:
- Code written in English with externalized string resources
- MVP launches with English and French translations
- UI layouts accommodate text expansion (French typically 20-30% longer than English)
- No hardcoded strings in code (all text via i18n framework)
- Date, time, and number formatting respect locale
- Quiz content stored with language identifiers in database

**Rationale:** Building i18n support after launch requires expensive refactoring. English code with French translation for MVP enables rapid market expansion while maintaining code quality and avoiding technical debt.

## Technical Standards

### Mobile Platforms
- iOS: 14+ minimum deployment target
- Android: API level 26+ (Android 8.0+)
- Flutter: 3.16+ with Dart 3.2+
- Single codebase with platform-specific code only when necessary

### Backend Services
- Firebase as primary backend (Firestore, Auth, Cloud Functions, Crashlytics, Analytics)
- Cloud Functions for server-side validation and business logic
- Anonymous authentication for frictionless onboarding
- Firestore security rules enforced for all data access

### State Management
- Riverpod for state management (version 2.4+)
- Provider pattern for dependency injection
- Immutable state objects with clear update flows
- No global mutable state

### Localization
- Flutter Intl package (flutter_localizations) for i18n framework
- ARB (Application Resource Bundle) files for translation storage
- Locale detection via device settings with manual override option
- Fallback to English if translation missing for any string
- Quiz content schema includes `language: 'en' | 'fr'` field
- Support both locales for MVP: en_US and fr_FR

### Error Handling
- All errors logged to Firebase Crashlytics
- User-facing error messages must be clear, actionable, and localized
- Network errors handled gracefully with retry logic
- No silent failures that leave UI in inconsistent state

## Quality Gates

### Pre-Commit
- Code must build without errors on iOS and Android
- Linting passes (flutter analyze)
- No new critical warnings introduced
- No hardcoded user-facing strings (i18n check)

### Pre-Merge
- All unit tests pass for affected business logic
- Widget tests pass for modified UI components
- Manual testing performed on at least one physical device
- Localization coverage verified (no missing translation keys)

### Pre-Release
- Integration tests pass for complete user flows
- Performance benchmarks met (app launch, quiz load, etc.)
- Crash-free rate > 99% in staging environment
- Security review completed for any API changes
- Ad integration tested (interstitial and rewarded)
- Both English and French versions tested thoroughly

### Post-Release
- Monitor crash rate (must stay < 1%)
- Track D1 retention (target > 40%) per locale
- Monitor API response times (alerts if > targets)
- Review app store ratings and respond to critical issues within 24h
- Track language distribution of user base

## Governance

### Amendment Process
This constitution can be amended when project needs evolve:
1. Proposed changes must be documented with rationale
2. Impact analysis required: what code/practices become non-compliant?
3. Migration plan if existing code violates new principles
4. Version bump follows semantic versioning (see below)

### Version Semantics
- **MAJOR** (X.0.0): Principle removal or redefinition that requires code changes
- **MINOR** (0.X.0): New principle added or existing principle materially expanded
- **PATCH** (0.0.X): Clarifications, wording improvements, typo fixes

### Compliance Verification
- All pull requests must verify compliance with principles
- Plan documents must include Constitution Check section
- Complexity violations must be explicitly justified in plan.md
- Regular architecture reviews to ensure principles are followed

### Development Workflow
- Follow sprint structure from development plan (8 sprints, 8-10 weeks)
- User stories must be independently testable and deliverable
- MVP (Phase 1-2) must be complete before adding Phase 3 features
- No feature additions until core principles are satisfied
- Localization work integrated into each sprint, not deferred to end

**Version**: 1.1.0 | **Ratified**: 2026-01-09 | **Last Amended**: 2026-01-09
