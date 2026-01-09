---
description: Create or update the project constitution from interactive or provided principle inputs, ensuring all dependent templates stay in sync.
handoffs: 
  - label: Build Specification
    agent: speckit.specify
    prompt: Implement the feature specification based on the updated constitution. I want to build...
---

## User Input

```text
# 📋 SPEC KIT - DailyBrain

## TABLE DES MATIÈRES

1. [Vue d'ensemble](#1-vue-densemble)
2. [Spécifications fonctionnelles](#2-spécifications-fonctionnelles)
3. [Spécifications techniques](#3-spécifications-techniques)
4. [Spécifications UX/UI](#4-spécifications-uxui)
5. [Plan de développement](#5-plan-de-développement)
6. [Plan de test](#6-plan-de-test)
7. [Plan de lancement](#7-plan-de-lancement)

---

## 1. VUE D'ENSEMBLE

### 1.1 Résumé Exécutif

**Produit** : Application mobile de quiz quotidien rapide  
**Durée cible** : < 60 secondes par session  
**Modèle économique** : Publicité (Interstitial + Rewarded)  
**Plateformes** : iOS 14+ & Android 8+  
**Timeline MVP** : 8-10 semaines

### 1.2 Objectifs Stratégiques

| Objectif | Métrique | Target MVP | Target 3 mois |
|----------|----------|------------|---------------|
| Acquisition | Téléchargements | 10K | 100K |
| Engagement | D1 Retention | 40% | 45% |
| Monétisation | ARPDAU | $0.05 | $0.10 |
| Viral | Organic rate | 20% | 35% |

### 1.3 Contraintes & Hypothèses

**Contraintes**
- Budget dev : Limité (justifie le choix cross-platform)
- Pas de backend custom (Firebase/Supabase)
- Contenu manuel au lancement
- Pas de modération nécessaire (quiz pré-validés)

**Hypothèses**
- Les utilisateurs acceptent 1 pub par session
- Le format "1 quiz/jour" crée la rareté
- Le streak est un levier de rétention fort

---

## 2. SPÉCIFICATIONS FONCTIONNELLES

### 2.1 User Stories Détaillées

#### Epic 1 : Onboarding
```
US-001 : Premier Lancement
EN TANT QU'utilisateur nouveau
JE VEUX voir un écran d'accueil simple
AFIN DE comprendre le concept en < 5 secondes

Critères d'acceptation :
- Affichage du slogan "Teste ton cerveau en 1 minute"
- Bouton CTA clair "Commencer"
- Animation engageante (< 2s)
- Skip possible
- Pas de formulaire d'inscription
```

```
US-002 : Compte Invité Automatique
EN TANT QU'utilisateur
JE VEUX jouer immédiatement sans créer de compte
AFIN DE réduire la friction

Critères d'acceptation :
- Génération automatique d'un ID utilisateur
- Username aléatoire (ex: "Brain_4532")
- Possibilité de personnaliser plus tard
- Sauvegarde locale + cloud
```

#### Epic 2 : Quiz Quotidien

```
US-003 : Affichage du Quiz du Jour
EN TANT QU'utilisateur récurrent
JE VEUX voir immédiatement si j'ai déjà joué aujourd'hui
AFIN DE ne pas perdre de temps

Critères d'acceptation :
- État "Disponible" ou "Complété" visible
- Si complété : affichage du score + CTA vers ranking
- Si disponible : bouton "Jouer" prominent
- Affichage du streak actuel
- Countdown jusqu'au prochain quiz
```

```
US-004 : Déroulement d'une Question
EN TANT QU'utilisateur en jeu
JE VEUX répondre rapidement et voir le résultat immédiat
AFIN DE maintenir l'engagement

Critères d'acceptation :
- Question affichée en grand
- 4 choix clairs et distincts
- Timer visuel (barre ou cercle)
- Feedback immédiat (vert=bon, rouge=erreur)
- Animation de transition (< 0.5s)
- Pas de retour en arrière possible
- Son optionnel (activé par défaut)
```

```
US-005 : Calcul du Score
EN TANT QU'utilisateur
JE VEUX comprendre comment mon score est calculé
AFIN DE m'améliorer

Formule :
Score = Σ (PointsCorrects × MultiplierTemps)

Détails :
- Bonne réponse = 100 points base
- Multiplier temps = (TempsRestant / TempsTotal)
- Réponse fausse = 0 point
- Score max par quiz = 500 points
- Affichage du breakdown sur l'écran résultat
```

#### Epic 3 : Système de Streak

```
US-006 : Suivi du Streak
EN TANT QU'utilisateur régulier
JE VEUX voir ma série de jours consécutifs
AFIN DE rester motivé

Critères d'acceptation :
- Badge visible sur l'écran principal
- Animation célébration sur nouveau record personnel
- Notification push à 20h si pas joué
- Message d'avertissement à 23h
```

```
US-007 : Récupération de Streak
EN TANT QU'utilisateur ayant manqué un jour
JE VEUX pouvoir sauver ma série
AFIN DE ne pas perdre ma progression

Critères d'acceptation :
- Proposition automatique le lendemain
- Message clair : "Regarde une vidéo pour sauver ton streak"
- Vidéo rewarded (30s max)
- Cooldown de 7 jours affiché
- Impossible si > 24h de retard
```

#### Epic 4 : Classements

```
US-008 : Classement Quotidien
EN TANT QU'utilisateur compétitif
JE VEUX voir mon rang du jour
AFIN DE me comparer

Critères d'acceptation :
- Top 100 affiché
- Position de l'utilisateur toujours visible (épinglée)
- Mise à jour en temps réel
- Données : Rang | Nom | Score | Badge streak
- Possibilité de rafraîchir
```

```
US-009 : Classement Global
EN TANT QU'utilisateur
JE VEUX voir les meilleurs joueurs de tous les temps
AFIN DE m'inspirer

Critères d'acceptation :
- Basé sur le total de points
- Top 100
- Filtres : Semaine / Mois / All-time
- Icônes spéciales pour Top 3
```

#### Epic 5 : Monétisation

```
US-010 : Publicité Interstitielle
EN TANT QUE business
JE VEUX monétiser chaque session
SANS ruiner l'expérience

Règles :
- Affichage APRÈS l'écran de résultat
- Jamais pendant le quiz
- Skippable après 5 secondes
- 1 seule par session
- Message de transition : "Chargement du classement..."
```

```
US-011 : Publicité Rewarded
EN TANT QU'utilisateur
JE VEUX avoir des options pour débloquer des avantages
EN échange de mon attention

Use cases :
- Sauver le streak (priorité 1)
- Rejouer le quiz (bonus, v1.1)
- Débloquer thème (v1.2)

Critères :
- Toujours optionnel
- Valeur claire affichée avant
- Compteur de récompenses disponibles
```

### 2.2 Règles Métier Détaillées

#### Règle 1 : Disponibilité du Quiz
```
IF heure_serveur >= 00:00 UTC AND < 23:59 UTC
  AND user.last_quiz_date != date_du_jour
THEN
  quiz_disponible = TRUE
ELSE
  quiz_disponible = FALSE
```

#### Règle 2 : Validation Streak
```
Streak valide SI :
- Dernier quiz complété = J-1 OU J
- OU recovery utilisée dans les 24h

Streak reset SI :
- Aucun quiz depuis > 48h
- ET aucune recovery disponible
```

#### Règle 3 : Anti-Triche
```
Score validé SI :
- Temps total >= (nb_questions × 2 secondes)
- Score <= score_maximum théorique
- Soumission unique par quiz_id + user_id
- Timestamp cohérent (pas de clock manipulation)
```

### 2.3 Matrice de Permissions

| Action | Compte Invité | Compte Authentifié |
|--------|---------------|-------------------|
| Jouer au quiz | ✅ | ✅ |
| Voir classement | ✅ | ✅ |
| Sauver streak | ✅ | ✅ |
| Changer username | ❌ | ✅ |
| Sync multi-device | ❌ | ✅ |
| Récupérer compte | ❌ | ✅ |

---

## 3. SPÉCIFICATIONS TECHNIQUES

### 3.1 Architecture Système

```
┌─────────────────────────────────────────┐
│          COUCHE PRÉSENTATION            │
│  Flutter / React Native (à décider)     │
│  - UI Components                        │
│  - State Management (Riverpod/Redux)    │
│  - Navigation                           │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│         COUCHE LOGIQUE MÉTIER           │
│  - Quiz Controller                      │
│  - Score Calculator                     │
│  - Streak Manager                       │
│  - Ranking Service                      │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│          COUCHE DONNÉES                 │
│  Local:                                 │
│  - SQLite / Hive                        │
│  - Shared Preferences                   │
│                                         │
│  Remote:                                │
│  - Firebase Firestore                   │
│  - Firebase Auth (Anonymous)            │
│  - Firebase Cloud Functions             │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│         SERVICES EXTERNES               │
│  - AdMob (Ads)                          │
│  - Firebase Analytics                   │
│  - Firebase Crashlytics                 │
└─────────────────────────────────────────┘
```

### 3.2 Modèles de Données Détaillés

#### Collection : `users`
```typescript
interface User {
  id: string;                    // Auto-generated
  username: string;              // Editable, unique
  createdAt: Timestamp;
  lastPlayedDate: string;        // YYYY-MM-DD
  currentStreak: number;
  longestStreak: number;
  totalScore: number;
  quizzesCompleted: number;
  recoveryAvailableAt: Timestamp | null;
  deviceId: string;              // Hashed
  platform: 'ios' | 'android';
  appVersion: string;
}
```

#### Collection : `quizzes`
```typescript
interface Quiz {
  id: string;                    // Format: YYYY-MM-DD
  publishedAt: Timestamp;
  questions: Question[];
  difficulty: 'easy' | 'medium' | 'hard' | 'mixed';
  category: string;              // v1.1
  language: string;              // 'fr' pour MVP
  active: boolean;
}

interface Question {
  id: string;
  text: string;
  choices: string[];             // Exactly 4
  correctIndex: number;          // 0-3
  timeLimit: number;             // Secondes
  explanation?: string;          // v1.1
  difficulty: number;            // 1-5
}
```

#### Collection : `scores`
```typescript
interface Score {
  id: string;
  userId: string;
  quizId: string;                // YYYY-MM-DD
  score: number;
  answers: Answer[];
  completedAt: Timestamp;
  duration: number;              // Total seconds
}

interface Answer {
  questionId: string;
  selectedIndex: number;
  correct: boolean;
  timeSpent: number;
  points: number;
}
```

#### Collection : `rankings_daily`
```typescript
interface DailyRanking {
  id: string;                    // YYYY-MM-DD
  entries: RankingEntry[];
  updatedAt: Timestamp;
}

interface RankingEntry {
  userId: string;
  username: string;
  score: number;
  rank: number;
  streakBadge: number;
}
```

#### Collection : `rankings_global`
```typescript
interface GlobalRanking {
  userId: string;
  username: string;
  totalScore: number;
  rank: number;
  quizzesCompleted: number;
  updatedAt: Timestamp;
}
```

### 3.3 APIs & Endpoints

#### Cloud Functions

**1. `getQuizOfTheDay`**
```typescript
// GET /quiz/daily
Request: {
  userId: string;
  timezone: string;
}

Response: {
  quiz: Quiz;
  alreadyPlayed: boolean;
  userScore?: number;
}
```

**2. `submitScore`**
```typescript
// POST /score/submit
Request: {
  userId: string;
  quizId: string;
  answers: Answer[];
  deviceFingerprint: string;
}

Response: {
  validated: boolean;
  finalScore: number;
  rank: number;
  streakUpdated: number;
}

// Validations serveur :
// - Temps cohérent
// - Pas de double soumission
// - Calcul score refait côté serveur
```

**3. `getRankings`**
```typescript
// GET /rankings
Request: {
  type: 'daily' | 'global';
  date?: string;           // Si daily
  limit: number;           // Default 100
}

Response: {
  rankings: RankingEntry[];
  userRank: number;
  userEntry: RankingEntry;
}
```

**4. `recoverStreak`**
```typescript
// POST /streak/recover
Request: {
  userId: string;
  adCompleted: boolean;
}

Response: {
  success: boolean;
  newStreak: number;
  recoveryAvailableAt: Timestamp;
}

// Validations :
// - Cooldown vérifié
// - Date cohérente
// - Ad completion token validé
```

### 3.4 Stack Technique Recommandé

#### Frontend
```yaml
Framework: Flutter
Justification:
  - Performance native
  - Single codebase
  - Rich animations
  - Forte communauté

Packages clés:
  - flutter_riverpod: State management
  - go_router: Navigation
  - flutter_animate: Animations
  - hive: Local storage
  - firebase_core: Backend
  - google_mobile_ads: Monetization
```

#### Backend
```yaml
Platform: Firebase
Services:
  - Firestore: Database NoSQL
  - Authentication: Anonymous auth
  - Cloud Functions: Business logic
  - Hosting: Quiz content CDN
  - Analytics: Usage tracking
  - Crashlytics: Error monitoring

Alternative (si budget limité):
  - Supabase (PostgreSQL + Auth + Realtime)
```

#### Ads
```yaml
Primary: Google AdMob
  - Interstitial ads
  - Rewarded video ads
  - Native ads (v1.1)

Mediation (v1.2):
  - Unity Ads
  - AppLovin
```

### 3.5 Sécurité

#### Mesures Implémentées

**1. Validation des Scores**
```dart
// Client envoie seulement les réponses
// Serveur recalcule le score
class ScoreValidator {
  static validate(answers, quiz) {
    // Check timing
    totalTime = answers.sum(a => a.timeSpent);
    if (totalTime < quiz.questions.length * 2) {
      return INVALID;
    }
    
    // Recalculate score
    serverScore = calculateScore(answers, quiz);
    
    // Check duplicate
    if (scoreExists(userId, quizId)) {
      return DUPLICATE;
    }
    
    return serverScore;
  }
}
```

**2. Rate Limiting**
```yaml
Rules:
  - 1 quiz submission / jour / user
  - 10 API calls / minute / IP
  - 100 ranking fetches / heure / user
```

**3. Device Fingerprinting**
```dart
String generateFingerprint() {
  return sha256(
    deviceId + 
    platform + 
    appVersion + 
    salt
  );
}
```

**4. Content Security**
```yaml
Firestore Rules:
  - Quizzes: Read only
  - Scores: Create only (validated by function)
  - Rankings: Read only
  - User: Own data only
```

### 3.6 Performance

#### Objectifs

| Métrique | Target | Mesure |
|----------|--------|--------|
| App launch | < 2s | Time to interactive |
| Quiz load | < 1s | First question display |
| Score submit | < 2s | Server response |
| Ranking load | < 1.5s | Full list display |
| App size | < 30MB | Download size |

#### Optimisations

**1. Caching**
```dart
// Quiz en cache local
class QuizCache {
  Future<Quiz> getQuiz(date) async {
    // 1. Check local cache
    local = await hive.get(date);
    if (local != null && !isExpired(local)) {
      return local;
    }
    
    // 2. Fetch from server
    remote = await api.getQuiz(date);
    
    // 3. Cache locally
    await hive.put(date, remote);
    
    return remote;
  }
}
```

**2. Lazy Loading**
```dart
// Rankings chargés par batch
class RankingLoader {
  loadInBatches(limit = 25) async {
    batch1 = await api.getRankings(0, 25);
    displayImmediately(batch1);
    
    // Load more on scroll
    if (userScrolls) {
      batch2 = await api.getRankings(25, 50);
    }
  }
}
```

**3. Image Optimization**
- Formats: WebP
- Sizes: 1x, 2x, 3x
- Lazy loading
- Placeholders

### 3.7 Offline Mode (v1.1)

```yaml
Capacités offline:
  - Voir le dernier quiz joué
  - Consulter ses stats
  - Voir le ranking en cache

Limitations:
  - Pas de nouveau quiz
  - Pas de soumission de score
  - Pas de classement temps réel

Sync:
  - Automatique au retour en ligne
  - Queue de soumissions pending
```

---

## 4. SPÉCIFICATIONS UX/UI

### 4.1 Design System

#### Palette de Couleurs
```css
/* Primary - Bleu Cerveau */
--primary-500: #4A90E2;
--primary-600: #357ABD;
--primary-700: #2868A8;

/* Secondary - Jaune Énergie */
--secondary-500: #F5A623;
--secondary-600: #E09612;

/* Semantic */
--success: #7ED321;
--error: #D0021B;
--warning: #F8E71C;

/* Neutrals */
--gray-50: #F9FAFB;
--gray-100: #F3F4F6;
--gray-500: #6B7280;
--gray-900: #111827;

/* Background */
--bg-primary: #FFFFFF;
--bg-secondary: #F9FAFB;
--bg-dark: #1F2937;
```

#### Typographie
```css
/* Headings */
--font-family-heading: 'Poppins', sans-serif;
--h1: 32px / 40px / 700;
--h2: 24px / 32px / 600;
--h3: 20px / 28px / 600;

/* Body */
--font-family-body: 'Inter', sans-serif;
--body-large: 18px / 28px / 400;
--body: 16px / 24px / 400;
--body-small: 14px / 20px / 400;

/* Monospace (scores) */
--font-family-mono: 'JetBrains Mono', monospace;
```

#### Spacing
```css
--space-xs: 4px;
--space-sm: 8px;
--space-md: 16px;
--space-lg: 24px;
--space-xl: 32px;
--space-2xl: 48px;
```

#### Border Radius
```css
--radius-sm: 8px;
--radius-md: 12px;
--radius-lg: 16px;
--radius-full: 9999px;
```

### 4.2 Wireframes & Flows

#### Écran 1 : Home / Quiz Ready
```
┌─────────────────────────────┐
│  ☰                    🔔    │
│                             │
│      ┌─────────────┐        │
│      │   🧠 Logo   │        │
│      │  DailyBrain │        │
│      └─────────────┘        │
│                             │
│   🔥 Streak: 12 jours       │
│                             │
│  ┌───────────────────────┐  │
│  │                       │  │
│  │  Quiz du 15 Jan 2024  │  │
│  │                       │  │
│  │  ⏱️  5 questions       │  │
│  │  🎯  60 secondes       │  │
│  │                       │  │
│  │   [  COMMENCER  ]     │  │
│  │                       │  │
│  └───────────────────────┘  │
│                             │
│  Prochain quiz dans: 18h32  │
│                             │
│  [  Voir le classement  ]   │
│                             │
└─────────────────────────────┘
```

#### Écran 2 : Question
```
┌─────────────────────────────┐
│  Question 3/5    ⏱️ [████  ] │
│                             │
│  Quelle est la capitale     │
│  du Japon ?                 │
│                             │
│  ┌───────────────────────┐  │
│  │  A. Seoul             │  │
│  └───────────────────────┘  │
│                             │
│  ┌───────────────────────┐  │
│  │  B. Tokyo  ← selected │  │
│  └───────────────────────┘  │
│                             │
│  ┌───────────────────────┐  │
│  │  C. Beijing           │  │
│  └───────────────────────┘  │
│                             │
│  ┌───────────────────────┐  │
│  │  D. Bangkok           │  │
│  └───────────────────────┘  │
│                             │
│         [VALIDER]           │
└─────────────────────────────┘
```

#### Écran 3 : Résultat Question (Feedback)
```
┌─────────────────────────────┐
│  Question 3/5        ✅       │
│                             │
│  Quelle est la capitale     │
│  du Japon ?                 │
│                             │
│  ┌───────────────────────┐  │
│  │  A. Seoul             │  │
│  └───────────────────────┘  │
│                             │
│  ┌───────────────────────┐  │
│  │  B. Tokyo  ✅ +95 pts │  │
│  └───────────────────────┘  │
│                             │
│  ┌───────────────────────┐  │
│  │  C. Beijing           │  │
│  └───────────────────────┘  │
│                             │
│  ┌───────────────────────┐  │
│  │  D. Bangkok           │  │
│  └───────────────────────┘  │
│                             │
│  Auto-transition: 2s...     │
└─────────────────────────────┘
```

#### Écran 4 : Résultat Final
```
┌─────────────────────────────┐
│         🎉 Bravo !          │
│                             │
│      ┌─────────────┐        │
│      │     428     │        │
│      │   POINTS    │        │
│      └─────────────┘        │
│                             │
│  ✅ 4 bonnes réponses       │
│  ❌ 1 erreur                │
│                             │
│  ⚡ Bonus vitesse: +28      │
│  🔥 Streak maintenu !       │
│                             │
│  ┌───────────────────────┐  │
│  │  Ton rang: #234/5,892 │  │
│  └───────────────────────┘  │
│                             │
│  [  Voir le classement  ]   │
│                             │
│  Prochain quiz: 21h15       │
└─────────────────────────────┘
```

#### Écran 5 : Classement
```
┌─────────────────────────────┐
│  ←  Classement    [Daily] ▼ │
│                             │
│  ┌───────────────────────┐  │
│  │ #1  🥇 Brain_8932     │  │
│  │     500 pts  🔥25     │  │
│  ├───────────────────────┤  │
│  │ #2  🥈 QuizMaster     │  │
│  │     498 pts  🔥89     │  │
│  ├───────────────────────┤  │
│  │ #3  🥉 Sarah_K        │  │
│  │     495 pts  🔥12     │  │
│  ├───────────────────────┤  │
│  │ #4  Antoine_L         │  │
│  │     492 pts  🔥7      │  │
│  └───────────────────────┘  │
│           ...               │
│  ┌───────────────────────┐  │
│  │ ⭐ TOI                 │  │
│  │ #234  Brain_4729      │  │
│  │     428 pts  🔥12     │  │
│  └───────────────────────┘  │
│                             │
│  [Global] [Semaine] [Mois]  │
└─────────────────────────────┘
```

### 4.3 Animations & Micro-interactions

#### Animation 1 : Transition Question
```yaml
Trigger: Validation de la réponse
Duration: 800ms
Steps:
  1. Choice selected: Scale 1.05 + haptic feedback (100ms)
  2. Reveal correct answer: Color change (200ms)
  3. Show points: Slide in from right (200ms)
  4. Wait: 1.5s
  5. Slide out entire screen: Left (-100%) (300ms)
  6. Slide in next question: Right (100% → 0) (300ms)
```

#### Animation 2 : Streak Celebration
```yaml
Trigger: Nouveau record personnel
Duration: 2000ms
Effect:
  - Confetti particles (1s)
  - Streak number: Scale pulse (0.8 → 1.2 → 1.0)
  - Fire emoji: Rotation wiggle
  - Haptic: Success pattern
```

#### Animation 3 : Timer Warning
```yaml
Trigger: < 3 secondes restantes
Effect:
  - Timer bar: Color shift to red
  - Pulsing glow effect
  - Subtle vibration every second
```

#### Animation 4 : Score Count-Up
```yaml
Trigger: Écran de résultat
Duration: 1500ms
Effect:
  - Counter animé de 0 au score final
  - Ease-out curve
  - Sound: Tick-tick-ding
```

### 4.4 Composants Réutilisables

#### Component : QuizCard
```dart
QuizCard({
  required String title,
  required int questionCount,
  required int timeLimit,
  required VoidCallback onStart,
  bool isCompleted = false,
  int? userScore,
})
```

#### Component : QuestionTimer
```dart
QuestionTimer({
  required int duration,
  required Function(bool) onComplete,
  Color primaryColor,
  Color warningColor,
})
```

#### Component : StreakBadge
```dart
StreakBadge({
  required int count,
  bool showFireAnimation = false,
  Size size = Size.medium,
})
```

#### Component : RankingRow
```dart
RankingRow({
  required int rank,
  required String username,
  required int score,
  int? streak,
  bool isCurrentUser = false,
  String? badge, // 🥇🥈🥉
})
```

### 4.5 États & Messages

#### États de l'App
```yaml
QuizReady:
  - Message: "Prêt à tester ton cerveau ?"
  - CTA: "Commencer"

QuizInProgress:
  - Indicateur: "Question X/5"
  - Timer visible

QuizCompleted:
  - Message: "Quiz terminé !" ou "Bravo !" ou "Bien joué !"
  - Score affiché

QuizAlreadyPlayed:
  - Message: "Tu as déjà joué aujourd'hui"
  - CTA: "Voir mon score"
  - Info: "Prochain quiz dans X heures"

NoInternet:
  - Message: "Pas de connexion"
  - CTA: "Réessayer"
  - Info: "Tu peux consulter tes stats en attendant"

StreakAtRisk:
  - Alert: "⚠️ Ta série est en danger !"
  - Message: "Tu n'as pas encore joué aujourd'hui"
  - CTA: "Jouer maintenant"

StreakLost:
  - Message: "Ta série de X jours est terminée 😢"
  - CTA: "Recommencer"
```

### 4.6 Accessibilité

```yaml
Requirements:
  - Contraste: WCAG AA minimum (4.5:1)
  - Taille police: Minimum 14px
  - Touch targets: 44x44px minimum
  - Screen reader: Labels sur tous les boutons
  - Color blind: Pas de rouge/vert seul
  - Animations: Respect de prefers-reduced-motion

Specific:
  - Timer: Indicateur visuel + numérique
  - Feedback: Couleur + icône + haptic
  - Questions: Police lisible, haut contraste
```

---

## 5. PLAN DE DÉVELOPPEMENT

### 5.1 Phases & Sprints

#### Phase 1 : Setup & Fondations (2 semaines)
**Sprint 1 - Infrastructure**
```yaml
Tasks:
  - Setup projet Flutter
  - Configuration Firebase
  - Architecture dossiers
  - State management (Riverpod)
  - Navigation (go_router)
  - Design system (couleurs, typo, spacing)
  - CI/CD pipeline

Deliverables:
  - Repo GitHub configuré
  - App vide qui build iOS + Android
  - Firebase connecté
  - Design tokens implémentés
```

**Sprint 2 - Modèles & Services**
```yaml
Tasks:
  - Modèles de données (User, Quiz, Score)
  - Service Firebase (CRUD)
  - Service Local Storage (Hive)
  - Service API (wrapper)
  - Service Analytics
  - Gestion des erreurs

Deliverables:
  - Tous les modèles testés
  - Services fonctionnels avec tests unitaires
  - Documentation API
```

#### Phase 2 : Features Core (3 semaines)

**Sprint 3 - Quiz Flow**
```yaml
Tasks:
  - Écran Home (quiz ready/completed)
  - Écran Question
  - Système de timer
  - Validation réponse
  - Feedback visuel
  - Navigation inter-questions
  - Écran résultat

Deliverables:
  - Quiz jouable de A à Z
  - Scores calculés correctement
  - Animations fluides
```

**Sprint 4 - Système de Streak**
```yaml
Tasks:
  - Logique streak (calcul, reset)
  - Badge streak UI
  - Notifications push
  - Récupération via rewarded ad
  - Cooldown système
  - Animations célébration

Deliverables:
  - Streak fonctionnel
  - Notifications testées
  - Recovery working
```

**Sprint 5 - Classements**
```yaml
Tasks:
  - Écran ranking
  - Fetch rankings (daily/global)
  - Infinite scroll
  - Épinglage user
  - Filtres (day/week/all)
  - Refresh

Deliverables:
  - Classements affichés
  - Performance optimisée
  - UX fluide
```

#### Phase 3 : Monétisation & Polish (2 semaines)

**Sprint 6 - Publicités**
```yaml
Tasks:
  - Intégration AdMob
  - Interstitial après quiz
  - Rewarded pour recovery
  - Gestion du loading
  - Fallback si pas de pub
  - Tracking revenue

Deliverables:
  - Ads fonctionnelles
  - Revenue tracking
  - UX non intrusive
```

**Sprint 7 - Polish & Testing**
```yaml
Tasks:
  - Animations finales
  - Sounds effects
  - Haptic feedback
  - Loading states
  - Error states
  - Offline mode basique
  - Tests E2E
  - Bug fixes

Deliverables:
  - App polished
  - 0 bugs critiques
  - Tests passés
```

#### Phase 4 : Launch (1 semaine)

**Sprint 8 - Deployment**
```yaml
Tasks:
  - App Store submission
  - Play Store submission
  - Landing page
  - Press kit
  - Social media assets
  - Monitoring setup
  - Support email

Deliverables:
  - Apps live
  - Marketing ready
  - Support ready
```

### 5.2 Tech Stack Choisi

```yaml
Frontend:
  Framework: Flutter 3.16+
  Language: Dart 3.2+
  State: Riverpod 2.4+
  Navigation: go_router 12+
  Storage: Hive 2.2+
  Network: Dio 5+

Backend:
  Platform: Firebase
  Database: Firestore
  Auth: Firebase Auth
  Functions: Cloud Functions (Node.js)
  Storage: Cloud Storage
  Hosting: Firebase Hosting

Ads:
  SDK: google_mobile_ads 4+
  Platform: AdMob

Analytics:
  Firebase Analytics
  Crashlytics

DevOps:
  CI/CD: GitHub Actions
  Versioning: Semantic versioning
  Testing: Flutter test + Integration tests
```

### 5.3 Dépendances (pubspec.yaml)

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  flutter_riverpod: ^2.4.0
  riverpod_annotation: ^2.3.0
  
  # Navigation
  go_router: ^12.0.0
  
  # Firebase
  firebase_core: ^2.24.0
  firebase_auth: ^4.15.0
  firebase_analytics: ^10.8.0
  cloud_firestore: ^4.14.0
  firebase_crashlytics: ^3.4.0
  
  # Storage
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  shared_preferences: ^2.2.2
  
  # Network
  dio: ^5.4.0
  connectivity_plus: ^5.0.2
  
  # Ads
  google_mobile_ads: ^4.0.0
  
  # UI
  flutter_animate: ^4.3.0
  flutter_svg: ^2.0.9
  cached_network_image: ^3.3.1
  
  # Utils
  intl: ^0.18.1
  uuid: ^4.3.3
  
dev_dependencies:
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter
  riverpod_generator: ^2.3.0
  build_runner: ^2.4.7
  flutter_lints: ^3.0.1
  mockito: ^5.4.4
```

### 5.4 Structure du Projet

```
lib/
├── main.dart
├── app.dart
│
├── core/
│   ├── constants/
│   │   ├── colors.dart
│   │   ├── typography.dart
│   │   └── spacing.dart
│   ├── theme/
│   │   └── app_theme.dart
│   ├── router/
│   │   └── app_router.dart
│   └── utils/
│       ├── validators.dart
│       └── formatters.dart
│
├── features/
│   ├── quiz/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   ├── quiz.dart
│   │   │   │   └── question.dart
│   │   │   ├── repositories/
│   │   │   │   └── quiz_repository.dart
│   │   │   └── services/
│   │   │       └── quiz_service.dart
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   ├── home_screen.dart
│   │   │   │   ├── quiz_screen.dart
│   │   │   │   └── result_screen.dart
│   │   │   ├── widgets/
│   │   │   │   ├── quiz_card.dart
│   │   │   │   ├── question_widget.dart
│   │   │   │   └── timer_widget.dart
│   │   │   └── controllers/
│   │   │       └── quiz_controller.dart
│   │   └── domain/
│   │       ├── entities/
│   │       └── usecases/
│   │
│   ├── streak/
│   │   ├── data/
│   │   ├── presentation/
│   │   └── domain/
│   │
│   ├── ranking/
│   │   ├── data/
│   │   ├── presentation/
│   │   └── domain/
│   │
│   └── user/
│       ├── data/
│       ├── presentation/
│       └── domain/
│
├── shared/
│   ├── widgets/
│   │   ├── buttons/
│   │   ├── loading/
│   │   └── error/
│   └── providers/
│       └── firebase_providers.dart
│
└── services/
    ├── ads/
    │   └── ad_service.dart
    ├── analytics/
    │   └── analytics_service.dart
    └── notifications/
        └── notification_service.dart
```

### 5.5 Environnements

```yaml
Development:
  - Firebase project: dailybrain-dev
  - AdMob: Test ads
  - Analytics: Debug mode
  - Bundle ID: com.dailybrain.dev

Staging:
  - Firebase project: dailybrain-staging
  - AdMob: Test ads
  - Analytics: Production mode
  - Bundle ID: com.dailybrain.staging

Production:
  - Firebase project: dailybrain-prod
  - AdMob: Production ads
  - Analytics: Production mode
  - Bundle ID: com.dailybrain
```

---

## 6. PLAN DE TEST

### 6.1 Stratégie de Test

```yaml
Pyramid de tests:
  - 70% : Unit tests (logique métier)
  - 20% : Widget tests (UI)
  - 10% : Integration tests (flows complets)
```

### 6.2 Tests Unitaires

#### Test : Score Calculation
```dart
group('Score Calculator', () {
  test('calcule score avec bonus vitesse', () {
    final answers = [
      Answer(correct: true, timeSpent: 2, timeLimit: 10),
      Answer(correct: true, timeSpent: 5, timeLimit: 10),
    ];
    
    final score = ScoreCalculator.calculate(answers);
    
    expect(score, equals(180)); // 100*0.8 + 100*0.5
  });
  
  test('score max est 500', () {
    final perfectAnswers = List.generate(5, (i) => 
      Answer(correct: true, timeSpent: 0, timeLimit: 10)
    );
    
    final score = ScoreCalculator.calculate(perfectAnswers);
    
    expect(score, equals(500));
  });
  
  test('réponse incorrecte = 0 point', () {
    final answer = Answer(correct: false, timeSpent: 5, timeLimit: 10);
    final score = ScoreCalculator.calculate([answer]);
    
    expect(score, equals(0));
  });
});
```

#### Test : Streak Logic
```dart
group('Streak Manager', () {
  test('incrémente streak si quiz complété aujourd\'hui', () {
    final user = User(lastPlayed: yesterday, streak: 5);
    final updated = StreakManager.update(user, today);
    
    expect(updated.streak, equals(6));
  });
  
  test('reset streak si jour manqué', () {
    final user = User(lastPlayed: twoDaysAgo, streak: 10);
    final updated = StreakManager.update(user, today);
    
    expect(updated.streak, equals(0));
  });
  
  test('recovery préserve le streak', () {
    final user = User(lastPlayed: yesterday, streak: 15);
    final recovered = StreakManager.recover(user);
    
    expect(recovered.streak, equals(15));
    expect(recovered.recoveryAvailableAt, isNotNull);
  });
});
```

### 6.3 Widget Tests

#### Test : Question Widget
```dart
testWidgets('affiche question et choix', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: QuestionWidget(
        question: Question(
          text: 'Capitale du Japon ?',
          choices: ['Seoul', 'Tokyo', 'Beijing', 'Bangkok'],
        ),
      ),
    ),
  );
  
  expect(find.text('Capitale du Japon ?'), findsOneWidget);
  expect(find.text('Tokyo'), findsOneWidget);
  expect(find.byType(ChoiceButton), findsNWidgets(4));
});

testWidgets('sélection d\'un choix', (tester) async {
  var selectedIndex = -1;
  
  await tester.pumpWidget(
    MaterialApp(
      home: QuestionWidget(
        question: mockQuestion,
        onAnswer: (index) => selectedIndex = index,
      ),
    ),
  );
  
  await tester.tap(find.text('Tokyo'));
  await tester.pump();
  
  expect(selectedIndex, equals(1));
});
```

#### Test : Timer Widget
```dart
testWidgets('timer décrémente', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: TimerWidget(duration: 10),
    ),
  );
  
  expect(find.text('10'), findsOneWidget);
  
  await tester.pump(Duration(seconds: 5));
  expect(find.text('5'), findsOneWidget);
  
  await tester.pump(Duration(seconds: 5));
  expect(find.text('0'), findsOneWidget);
});
```

### 6.4 Tests d'Intégration

#### Test : Flow Quiz Complet
```dart
testWidgets('flow complet du quiz', (tester) async {
  await tester.pumpWidget(MyApp());
  
  // 1. Home screen
  expect(find.text('COMMENCER'), findsOneWidget);
  await tester.tap(find.text('COMMENCER'));
  await tester.pumpAndSettle();
  
  // 2. Question 1
  expect(find.text('Question 1/5'), findsOneWidget);
  await tester.tap(find.byType(ChoiceButton).first);
  await tester.pump(Duration(seconds: 2));
  
  // 3. Question 2-5 (répéter)
  for (var i = 2; i <= 5; i++) {
    expect(find.text('Question $i/5'), findsOneWidget);
    await tester.tap(find.byType(ChoiceButton).first);
    await tester.pump(Duration(seconds: 2));
  }
  
  // 4. Result screen
  expect(find.text('POINTS'), findsOneWidget);
  expect(find.byType(ResultScreen), findsOneWidget);
  
  // 5. Ranking
  await tester.tap(find.text('Voir le classement'));
  await tester.pumpAndSettle();
  expect(find.byType(RankingScreen), findsOneWidget);
});
```

### 6.5 Tests de Performance

```dart
testWidgets('quiz load < 1 seconde', (tester) async {
  final stopwatch = Stopwatch()..start();
  
  await tester.pumpWidget(MyApp());
  await tester.tap(find.text('COMMENCER'));
  await tester.pumpAndSettle();
  
  stopwatch.stop();
  expect(stopwatch.elapsedMilliseconds, lessThan(1000));
});
```

### 6.6 Tests Manuels (QA Checklist)

#### Checklist Quiz Flow
- [ ] Timer démarre automatiquement
- [ ] Timer s'arrête à 0
- [ ] Impossible de changer de réponse après validation
- [ ] Animation de feedback correcte
- [ ] Score affiché correspond au calcul
- [ ] Impossible de rejouer le même jour
- [ ] Message "Déjà joué" visible

#### Checklist Streak
- [ ] Badge streak affiché correctement
- [ ] Notification push à 20h si pas joué
- [ ] Recovery propose vidéo rewarded
- [ ] Cooldown de 7 jours respecté
- [ ] Animation célébration sur record

#### Checklist Ads
- [ ] Interstitial après résultat (pas avant)
- [ ] Rewarded skip possible
- [ ] Pas d'ad pendant le quiz
- [ ] Fallback si pas de pub disponible

#### Checklist Ranking
- [ ] Classement daily/global correct
- [ ] Position user épinglée
- [ ] Refresh fonctionne
- [ ] Infinite scroll fluide

### 6.7 Tests de Sécurité

```yaml
Scenarios:
  - Manipulation du timer (speed hack)
  - Soumission multiple du même score
  - Modification du device clock
  - Replay attack
  - SQL injection (si applicable)

Validation:
  - Tous les calculs côté serveur
  - Token de session
  - Rate limiting
  - Fingerprinting device
```

### 6.8 Tests Multi-Devices

```yaml
Devices iOS:
  - iPhone SE (small screen)
  - iPhone 14 Pro (notch)
  - iPad (tablet)

Devices Android:
  - Pixel 6 (modern)
  - Samsung Galaxy S21 (custom UI)
  - Budget phone (low RAM)

OS Versions:
  - iOS: 14, 15, 16, 17
  - Android: 8, 10, 12, 14
```

---

## 7. PLAN DE LANCEMENT

### 7.1 Pre-Launch (J-14 à J-7)

#### Tâches Marketing
```yaml
Assets:
  - Logo variants (1024x1024)
  - Screenshots (iPhone + Android)
  - App Preview video (30s)
  - Press kit (PDF)
  - Landing page

Content:
  - App Store description (FR + EN)
  - Privacy policy
  - Terms of service
  - FAQ
  - Social media posts (x10)

Outreach:
  - Liste 50 influenceurs micro
  - Email template
  - Media kit
```

#### App Store Optimization (ASO)

**Titre**
```
FR: DailyBrain - Quiz Quotidien
EN: DailyBrain - Daily Quiz Game
```

**Subtitle (30 chars)**
```
FR: 1 quiz, 1 minute, 1 jour
EN: 1 quiz, 1 minute, 1 day
```

**Description**
```
🧠 Teste ton cerveau en moins d'une minute !

DailyBrain, c'est :
✨ 1 quiz unique par jour
⚡ 5 questions chronométrées
🏆 Classements en temps réel
🔥 Séries quotidiennes
🎯 Score basé sur ta rapidité

Rejoins des milliers de joueurs et deviens le plus rapide !

[Télécharger] maintenant et commence ta série dès aujourd'hui 🚀

---

📱 Totalement gratuit
⏱️ Session < 60 secondes
🌍 Nouveau quiz chaque jour
🏅 Classements quotidiens et globaux
```

**Keywords**
```
quiz, brain, daily, trivia, game, knowledge, 
fast, quick, challenge, ranking, streak
```

**Screenshots Order**
1. Home screen (quiz ready)
2. Question en action
3. Résultat avec score
4. Classement
5. Streak badge

#### Soft Launch (Pays Test)

```yaml
Markets: Canada, Belgium
Duration: 7 jours
Budget ads: $200
Goal: 
  - 500 users
  - D1 retention > 35%
  - 0 crash
  - Feedback recueilli
```

### 7.2 Launch Day (J-Day)

#### Timeline
```yaml
00:00 UTC:
  - App live sur stores
  - Landing page active
  - Analytics monitoring ON

08:00 UTC:
  - Post social media (FR)
  - Email à la liste (si applicable)
  - ProductHunt submission

14:00 UTC:
  - Post social media (EN)
  - Reddit posts (r/AndroidApps, r/iOSApps)
  
18:00 UTC:
  - Monitoring dashboards
  - First metrics report
  - Bug triage if needed

23:59 UTC:
  - Day 1 report
  - Plan J+1
```

#### Launch Channels

**Owned**
- Landing page: www.dailybrain.app
- Email: launch@dailybrain.app
- Twitter: @dailybrain_app
- Instagram: @dailybrain

**Earned**
- ProductHunt launch
- Reddit communities
- HackerNews Show HN
- Indie Hackers post

**Paid** (J+3)
- Google Ads (search)
- Meta Ads (retargeting landing page visitors)
- Budget: $50/jour

### 7.3 Post-Launch (J+1 à J+30)

#### Week 1 Focus
```yaml
Priority: Stability
Tasks:
  - Monitor crash rate (target < 1%)
  - Fix critical bugs < 24h
  - Respond to reviews < 12h
  - Daily metrics review
  - Community engagement

KPIs:
  - D1 retention: > 40%
  - Daily active users: +10%/day
  - App rating: > 4.5
  - Crash-free: > 99%
```

#### Week 2-4 Focus
```yaml
Priority: Growth
Tasks:
  - A/B test notifications
  - Optimize ASO based on data
  - Influencer outreach
  - Content marketing (blog posts)
  - Community building

KPIs:
  - D7 retention: > 20%
  - MAU: 10K
  - Organic rate: > 25%
  - ARPDAU: > $0.05
```

### 7.4 Metrics & Monitoring

#### Dashboard Real-Time
```yaml
Critical Metrics (refresh 5min):
  - Active users now
  - Crash rate
  - API response time
  - Ad fill rate

Hourly Metrics:
  - New users
  - Quiz completion rate
  - Avg session duration
  - Revenue

Daily Metrics:
  - DAU / MAU
  - Retention curves
  - Top countries
  - Conversion funnel
```

#### Alerts Setup
```yaml
Critical (SMS):
  - Crash rate > 2%
  - API down > 2min
  - Revenue drop > 50%

Warning (Email):
  - Retention drop > 10%
  - Quiz completion < 70%
  - Ad fill rate < 80%
```

### 7.5 Support & Community

#### Support Channels
```
Email: support@dailybrain.app
Response time: < 24h
FAQ: dailybrain.app/faq
Discord: discord.gg/dailybrain (v1.1)
```

#### FAQ Préparée
```markdown
Q: Quand est le nouveau quiz disponible ?
R: Chaque jour à minuit UTC.

Q: Comment fonctionne le streak ?
R: Joue chaque jour pour maintenir ta série.

Q: Puis-je rejouer un quiz ?
R: Non, 1 quiz par jour pour tous.

Q: Comment monter dans le classement ?
R: Réponds vite ET juste !

Q: Les publicités sont-elles obligatoires ?
R: L'interstitielle oui, mais elle ne dure que quelques secondes.

Q: Mes données sont-elles sauvegardées ?
R: Oui, automatiquement dans le cloud.
```

### 7.6 Roadmap Communication

**Public Roadmap** (sur landing page)
```markdown
✅ Lancé
- Quiz quotidien
- Classements
- Système de streak

🚧 En cours (T1 2024)
- Mode thématique
- Duels entre amis
- Quizz audio

💡 Prévu (T2 2024)
- Tournois hebdomadaires
- Récompenses personnalisées
- Mode hors-ligne complet
```

### 7.7 Iterate & Improve

#### Feedback Loop
```yaml
Sources:
  - App Store reviews
  - Google Play reviews
  - Email support
  - In-app surveys (v1.1)
  - Analytics behavior

Process:
  Weekly:
    - Review feedback
    - Prioritize features/fixes
    - Update backlog
  
  Bi-weekly:
    - Sprint planning
    - Deploy updates
```

#### Update Cadence
```yaml
Hotfixes: As needed (< 24h)
Minor updates: Every 2 weeks
Major updates: Every 6-8 weeks
```

---

## 📊 ANNEXES

### A. Glossaire

| Terme | Définition |
|-------|------------|
| DAU | Daily Active Users |
| MAU | Monthly Active Users |
| ARPDAU | Average Revenue Per Daily Active User |
| eCPM | Effective Cost Per Mille (impressions) |
| D1/D7 Retention | % users qui reviennent après 1/7 jours |
| Streak | Série de jours consécutifs |
| Rewarded Ad | Publicité optionnelle avec récompense |
| Interstitial | Publicité plein écran |

### B. Risques & Mitigation

| Risque | Impact | Probabilité | Mitigation |
|--------|--------|-------------|------------|
| Contenu manquant | Critique | Faible | Buffer de 30 quizzes pré-créés |
| Crash sur certains devices | Élevé | Moyen | Tests multi-devices + Beta testeurs |
| Ads ne chargent pas | Élevé | Moyen | Fallback + Multiple ad networks |
| Triche / Bot | Moyen | Élevé | Validation serveur + Rate limiting |
| Faible rétention | Critique | Moyen | Notifications + Streak incentive |

### C. Budget Estimé

```yaml
Développement:
  Dev (freelance 2 mois): $8,000
  Design (5 jours): $1,000
  
Infrastructure (mensuel):
  Firebase Blaze: ~$50
  Domaine: $15
  AdMob: $0 (gratuit)
  
Marketing (mois 1):
  Ads: $500
  Influenceurs: $500
  Assets: $200
  
Total initial: ~$10,000
Monthly run: ~$1,100
```

### D. Équipe Recommandée (MVP)

```yaml
Core Team:
  - 1 Dev Full-Stack (Flutter + Firebase)
  - 1 Designer UI/UX (part-time)
  - 1 Content Creator (quizzes)
  - 1 Product Owner / Marketing

Extended:
  - Beta testers (20)
  - Community manager (post-launch)
```

### E. Outils & Services

```yaml
Development:
  - GitHub (code)
  - Figma (design)
  - Notion (docs)
  - Linear (tasks)

Analytics:
  - Firebase Analytics
  - Mixpanel (v1.1)
  - Google Analytics (web)

Communication:
  - Slack (team)
  - Discord (community)
  - Email (support)

Monitoring:
  - Firebase Crashlytics
  - Sentry (backup)
  - Uptime Robot (API)
```

---

## ✅ CHECKLIST GO/NO-GO LAUNCH

### Must Have (Bloquants)
- [ ] App build sur iOS + Android
- [ ] 0 crash critique
- [ ] Quiz du jour fonctionne
- [ ] Score se calcule correctement
- [ ] Classement s'affiche
- [ ] Streak se maintient
- [ ] Ads s'affichent
- [ ] Analytics fonctionnent
- [ ] Privacy policy publiée
- [ ] Support email actif

### Nice to Have (Non bloquants)
- [ ] Animations polies
- [ ] Sounds effects
- [ ] 30 quizzes en buffer
- [ ] Landing page SEO optimisée
- [ ] 100 beta testers
- [ ] Press kit complet

---

**Version**: 1.0  
**Date**: Janvier 2024  
**Auteur**: Spec DailyBrain MVP  
**Status**: Ready for Development
```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

You are updating the project constitution at `.specify/memory/constitution.md`. This file is a TEMPLATE containing placeholder tokens in square brackets (e.g. `[PROJECT_NAME]`, `[PRINCIPLE_1_NAME]`). Your job is to (a) collect/derive concrete values, (b) fill the template precisely, and (c) propagate any amendments across dependent artifacts.

Follow this execution flow:

1. Load the existing constitution template at `.specify/memory/constitution.md`.
   - Identify every placeholder token of the form `[ALL_CAPS_IDENTIFIER]`.
   **IMPORTANT**: The user might require less or more principles than the ones used in the template. If a number is specified, respect that - follow the general template. You will update the doc accordingly.

2. Collect/derive values for placeholders:
   - If user input (conversation) supplies a value, use it.
   - Otherwise infer from existing repo context (README, docs, prior constitution versions if embedded).
   - For governance dates: `RATIFICATION_DATE` is the original adoption date (if unknown ask or mark TODO), `LAST_AMENDED_DATE` is today if changes are made, otherwise keep previous.
   - `CONSTITUTION_VERSION` must increment according to semantic versioning rules:
     - MAJOR: Backward incompatible governance/principle removals or redefinitions.
     - MINOR: New principle/section added or materially expanded guidance.
     - PATCH: Clarifications, wording, typo fixes, non-semantic refinements.
   - If version bump type ambiguous, propose reasoning before finalizing.

3. Draft the updated constitution content:
   - Replace every placeholder with concrete text (no bracketed tokens left except intentionally retained template slots that the project has chosen not to define yet—explicitly justify any left).
   - Preserve heading hierarchy and comments can be removed once replaced unless they still add clarifying guidance.
   - Ensure each Principle section: succinct name line, paragraph (or bullet list) capturing non‑negotiable rules, explicit rationale if not obvious.
   - Ensure Governance section lists amendment procedure, versioning policy, and compliance review expectations.

4. Consistency propagation checklist (convert prior checklist into active validations):
   - Read `.specify/templates/plan-template.md` and ensure any "Constitution Check" or rules align with updated principles.
   - Read `.specify/templates/spec-template.md` for scope/requirements alignment—update if constitution adds/removes mandatory sections or constraints.
   - Read `.specify/templates/tasks-template.md` and ensure task categorization reflects new or removed principle-driven task types (e.g., observability, versioning, testing discipline).
   - Read each command file in `.specify/templates/commands/*.md` (including this one) to verify no outdated references (agent-specific names like CLAUDE only) remain when generic guidance is required.
   - Read any runtime guidance docs (e.g., `README.md`, `docs/quickstart.md`, or agent-specific guidance files if present). Update references to principles changed.

5. Produce a Sync Impact Report (prepend as an HTML comment at top of the constitution file after update):
   - Version change: old → new
   - List of modified principles (old title → new title if renamed)
   - Added sections
   - Removed sections
   - Templates requiring updates (✅ updated / ⚠ pending) with file paths
   - Follow-up TODOs if any placeholders intentionally deferred.

6. Validation before final output:
   - No remaining unexplained bracket tokens.
   - Version line matches report.
   - Dates ISO format YYYY-MM-DD.
   - Principles are declarative, testable, and free of vague language ("should" → replace with MUST/SHOULD rationale where appropriate).

7. Write the completed constitution back to `.specify/memory/constitution.md` (overwrite).

8. Output a final summary to the user with:
   - New version and bump rationale.
   - Any files flagged for manual follow-up.
   - Suggested commit message (e.g., `docs: amend constitution to vX.Y.Z (principle additions + governance update)`).

Formatting & Style Requirements:

- Use Markdown headings exactly as in the template (do not demote/promote levels).
- Wrap long rationale lines to keep readability (<100 chars ideally) but do not hard enforce with awkward breaks.
- Keep a single blank line between sections.
- Avoid trailing whitespace.

If the user supplies partial updates (e.g., only one principle revision), still perform validation and version decision steps.

If critical info missing (e.g., ratification date truly unknown), insert `TODO(<FIELD_NAME>): explanation` and include in the Sync Impact Report under deferred items.

Do not create a new template; always operate on the existing `.specify/memory/constitution.md` file.
