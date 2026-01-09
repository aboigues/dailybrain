import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// Answer model for individual question answers
class AnswerModel extends Equatable {
  final String questionId;
  final int selectedIndex;
  final bool correct;
  final int timeSpent; // Seconds
  final int points; // Points earned for this question

  const AnswerModel({
    required this.questionId,
    required this.selectedIndex,
    required this.correct,
    required this.timeSpent,
    required this.points,
  });

  factory AnswerModel.fromMap(Map<String, dynamic> map) {
    return AnswerModel(
      questionId: map['questionId'] as String,
      selectedIndex: map['selectedIndex'] as int,
      correct: map['correct'] as bool,
      timeSpent: map['timeSpent'] as int,
      points: map['points'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'questionId': questionId,
      'selectedIndex': selectedIndex,
      'correct': correct,
      'timeSpent': timeSpent,
      'points': points,
    };
  }

  @override
  List<Object?> get props => [
        questionId,
        selectedIndex,
        correct,
        timeSpent,
        points,
      ];
}

/// Score model matching specification section 3.2
/// Constitution Principle III: Server-side validation required
class ScoreModel extends Equatable {
  final String id;
  final String userId;
  final String quizId; // YYYY-MM-DD format
  final int score;
  final List<AnswerModel> answers;
  final DateTime completedAt;
  final int duration; // Total seconds

  const ScoreModel({
    required this.id,
    required this.userId,
    required this.quizId,
    required this.score,
    required this.answers,
    required this.completedAt,
    required this.duration,
  });

  factory ScoreModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ScoreModel(
      id: doc.id,
      userId: data['userId'] as String,
      quizId: data['quizId'] as String,
      score: data['score'] as int,
      answers: (data['answers'] as List)
          .map((a) => AnswerModel.fromMap(a as Map<String, dynamic>))
          .toList(),
      completedAt: (data['completedAt'] as Timestamp).toDate(),
      duration: data['duration'] as int,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'quizId': quizId,
      'score': score,
      'answers': answers.map((a) => a.toMap()).toList(),
      'completedAt': Timestamp.fromDate(completedAt),
      'duration': duration,
    };
  }

  /// Calculate score from answers
  /// Per specification section 2.2:
  /// Score = Σ (PointsCorrects × MultiplierTemps)
  /// - Bonne réponse = 100 points base
  /// - Multiplier temps = (TempsRestant / TempsTotal)
  static int calculateScore(List<AnswerModel> answers) {
    return answers.fold<int>(0, (sum, answer) => sum + answer.points);
  }

  /// Get number of correct answers
  int get correctAnswersCount =>
      answers.where((a) => a.correct).length;

  /// Get number of wrong answers
  int get wrongAnswersCount =>
      answers.where((a) => !a.correct).length;

  @override
  List<Object?> get props => [
        id,
        userId,
        quizId,
        score,
        answers,
        completedAt,
        duration,
      ];
}
