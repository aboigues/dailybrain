# DailyBrain 🧠

A daily quiz mobile application with streaks, rankings and gamification. Test your brain in less than 60 seconds!

## Overview

**DailyBrain** is a mobile quiz game where users answer 5 questions daily, compete on leaderboards, and maintain streaks. Built with Flutter and Firebase.

### Key Features

- ⚡ **Quick Sessions**: < 60 seconds per quiz
- 🔥 **Streak System**: Daily challenges to maintain engagement
- 🏆 **Rankings**: Daily and global leaderboards
- 🎯 **Speed Scoring**: Points based on correctness AND speed
- 🌍 **Bilingual**: English and French support (MVP)
- 📱 **Cross-Platform**: iOS 14+ and Android 8+

## Project Structure

This project follows a **feature-based architecture** as defined in the [Constitution](.specify/memory/constitution.md):

```
lib/
├── core/              # Design system, theme, utilities
├── features/          # Feature modules (quiz, streak, ranking, user)
├── shared/            # Shared widgets and providers
├── services/          # Cross-cutting services (ads, analytics)
└── l10n/              # Internationalization files
```

## Constitution & Principles

This project is governed by 7 core principles defined in our [Constitution](.specify/memory/constitution.md):

1. **Mobile-First Performance** - Strict performance targets (< 2s launch, < 1s quiz load)
2. **Offline Resilience** - Graceful degradation without connectivity
3. **Server-Side Validation** (NON-NEGOTIABLE) - Anti-cheat measures
4. **Feature-Based Architecture** - Clear separation of concerns
5. **User Experience Non-Negotiables** - Accessibility and UX standards
6. **Test-Driven for Business Logic** - Unit tests for critical paths
7. **Internationalization-First Design** - English + French from day one

## Development Setup

### Prerequisites

- Flutter 3.16+ with Dart 3.2+
- Firebase CLI
- Android Studio / Xcode (for mobile development)
- Git

### Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/dailybrain.git
cd dailybrain

# Install dependencies
flutter pub get

# Run code generation (for i18n and Riverpod)
flutter pub run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

### Firebase Setup

1. Create a Firebase project for each environment (dev, staging, prod)
2. Add your Firebase configuration files:
   - Android: `android/app/google-services.json`
   - iOS: `ios/Runner/GoogleService-Info.plist`
3. Deploy Firestore security rules:
   ```bash
   firebase deploy --only firestore:rules
   firebase deploy --only storage:rules
   ```

## Testing

Run tests according to Constitution Principle VI:

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test suite
flutter test test/features/quiz/data/models/score_model_test.dart
```

## CI/CD

GitHub Actions workflows are configured for:

- **CI/CD** (.github/workflows/ci.yml) - Build, lint, test
- **Security** (.github/workflows/security.yml) - Dependency scanning, secrets detection
- **UX Quality** (.github/workflows/ux-quality.yml) - i18n checks, accessibility validation

All PRs must pass these quality gates before merging.

## Tech Stack

### Frontend
- **Flutter** 3.16+ (cross-platform framework)
- **Riverpod** 2.4+ (state management)
- **go_router** 12+ (navigation)
- **Hive** 2.2+ (local storage)

### Backend
- **Firebase Firestore** (NoSQL database)
- **Firebase Auth** (anonymous authentication)
- **Cloud Functions** (server-side validation)
- **Firebase Analytics** & **Crashlytics** (monitoring)

### Monetization
- **Google AdMob** (interstitial & rewarded ads)

## Localization

The app supports English and French per Constitution Principle VII:

```bash
# Generate localization code
flutter pub run intl_utils:generate
```

Translation files are located in `lib/l10n/`:
- `app_en.arb` - English translations
- `app_fr.arb` - French translations

## Code Style

Follow the linting rules defined in `analysis_options.yaml`:

```bash
# Run linter
flutter analyze

# Auto-fix formatting
dart format lib/ test/
```

## Architecture Decisions

Key architectural decisions are documented in:
- [Constitution](.specify/memory/constitution.md) - Governance and core principles
- [Plan Template](.specify/templates/plan-template.md) - Feature planning structure
- [Spec Template](.specify/templates/spec-template.md) - Feature specification structure

## Performance Targets

Per Constitution Principle I:

| Metric | Target |
|--------|--------|
| App launch | < 2s to interactive |
| Quiz load | < 1s to first question |
| Score submission | < 2s server response |
| Ranking load | < 1.5s full list |
| App size | < 30MB download |

## Security

Security measures per Constitution Principle III:

- ✅ Server-side score validation
- ✅ Rate limiting on all API endpoints
- ✅ Device fingerprinting for anti-cheat
- ✅ Firestore security rules enforced
- ✅ No sensitive data in code (secrets in environment)
- ✅ HTTPS-only connections

See `firestore.rules` and `storage.rules` for access control policies.

## Contributing

1. Read the [Constitution](.specify/memory/constitution.md)
2. Create a feature branch from `main`
3. Follow the feature-based architecture pattern
4. Ensure all quality gates pass
5. Submit a PR for code review

## License

[To be determined]

## Team

- **Development**: [Your team]
- **Design**: [Designer]
- **Content**: [Quiz creator]
- **Product**: [Product owner]

---

Built with ❤️ using Flutter & Firebase | Constitution v1.1.0
