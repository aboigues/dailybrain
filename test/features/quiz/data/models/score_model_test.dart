import 'package:flutter_test/flutter_test.dart';
import 'package:dailybrain/features/quiz/data/models/score_model.dart';

/// Tests for score calculation
/// Based on specification section 6.2: Test : Score Calculation
/// Constitution Principle VI: Test-Driven for Business Logic
void main() {
  group('Score Calculator', () {
    test('calcule score avec bonus vitesse', () {
      // Specification formula:
      // Score = Σ (PointsCorrects × MultiplierTemps)
      // - Bonne réponse = 100 points base
      // - Multiplier temps = (TempsRestant / TempsTotal)

      final answers = [
        const AnswerModel(
          questionId: 'q1',
          selectedIndex: 0,
          correct: true,
          timeSpent: 2,
          points: 80, // 100 * (10-2)/10 = 80
        ),
        const AnswerModel(
          questionId: 'q2',
          selectedIndex: 1,
          correct: true,
          timeSpent: 5,
          points: 50, // 100 * (10-5)/10 = 50
        ),
      ];

      final score = ScoreModel.calculateScore(answers);

      // Expected: 80 + 50 = 130 (was 180 in spec, but formula gives 130)
      expect(score, equals(130));
    });

    test('score max est 500', () {
      // Specification: Score max par quiz = 500 points
      // Perfect answers with instant response (0 time spent)
      final perfectAnswers = List.generate(
        5,
        (i) => const AnswerModel(
          questionId: 'q',
          selectedIndex: 0,
          correct: true,
          timeSpent: 0,
          points: 100, // 100 * (10-0)/10 = 100
        ),
      );

      final score = ScoreModel.calculateScore(perfectAnswers);

      expect(score, equals(500));
    });

    test('réponse incorrecte = 0 point', () {
      // Specification: Réponse fausse = 0 point
      const answer = AnswerModel(
        questionId: 'q1',
        selectedIndex: 2,
        correct: false,
        timeSpent: 5,
        points: 0,
      );

      final score = ScoreModel.calculateScore([answer]);

      expect(score, equals(0));
    });

    test('correctAnswersCount returns correct count', () {
      final score = ScoreModel(
        id: 'score1',
        userId: 'user1',
        quizId: '2024-01-09',
        score: 400,
        answers: const [
          AnswerModel(
            questionId: 'q1',
            selectedIndex: 0,
            correct: true,
            timeSpent: 2,
            points: 80,
          ),
          AnswerModel(
            questionId: 'q2',
            selectedIndex: 1,
            correct: true,
            timeSpent: 3,
            points: 70,
          ),
          AnswerModel(
            questionId: 'q3',
            selectedIndex: 2,
            correct: false,
            timeSpent: 8,
            points: 0,
          ),
        ],
        completedAt: DateTime.now(),
        duration: 13,
      );

      expect(score.correctAnswersCount, equals(2));
      expect(score.wrongAnswersCount, equals(1));
    });

    test('mixed correct and incorrect answers', () {
      final answers = [
        const AnswerModel(
          questionId: 'q1',
          selectedIndex: 0,
          correct: true,
          timeSpent: 1,
          points: 90, // Very fast
        ),
        const AnswerModel(
          questionId: 'q2',
          selectedIndex: 1,
          correct: false,
          timeSpent: 5,
          points: 0, // Wrong answer
        ),
        const AnswerModel(
          questionId: 'q3',
          selectedIndex: 2,
          correct: true,
          timeSpent: 7,
          points: 30, // Slow but correct
        ),
      ];

      final score = ScoreModel.calculateScore(answers);

      expect(score, equals(120)); // 90 + 0 + 30
    });
  });
}
