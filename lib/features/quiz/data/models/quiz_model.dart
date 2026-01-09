import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// Question model matching specification section 3.2
class QuestionModel extends Equatable {
  final String id;
  final String text;
  final List<String> choices; // Exactly 4 per specification
  final int correctIndex; // 0-3
  final int timeLimit; // Seconds
  final String? explanation; // v1.1 feature
  final int difficulty; // 1-5

  const QuestionModel({
    required this.id,
    required this.text,
    required this.choices,
    required this.correctIndex,
    required this.timeLimit,
    this.explanation,
    required this.difficulty,
  });

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['id'] as String,
      text: map['text'] as String,
      choices: List<String>.from(map['choices'] as List),
      correctIndex: map['correctIndex'] as int,
      timeLimit: map['timeLimit'] as int,
      explanation: map['explanation'] as String?,
      difficulty: map['difficulty'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'choices': choices,
      'correctIndex': correctIndex,
      'timeLimit': timeLimit,
      'explanation': explanation,
      'difficulty': difficulty,
    };
  }

  @override
  List<Object?> get props => [
        id,
        text,
        choices,
        correctIndex,
        timeLimit,
        explanation,
        difficulty,
      ];
}

/// Quiz model matching specification section 3.2
/// Constitution Principle VII: Includes language field for i18n
class QuizModel extends Equatable {
  final String id; // Format: YYYY-MM-DD
  final DateTime publishedAt;
  final List<QuestionModel> questions;
  final String difficulty; // 'easy' | 'medium' | 'hard' | 'mixed'
  final String? category; // v1.1 feature
  final String language; // 'en' | 'fr' for MVP (Constitution Principle VII)
  final bool active;

  const QuizModel({
    required this.id,
    required this.publishedAt,
    required this.questions,
    required this.difficulty,
    this.category,
    required this.language,
    required this.active,
  });

  factory QuizModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return QuizModel(
      id: doc.id,
      publishedAt: (data['publishedAt'] as Timestamp).toDate(),
      questions: (data['questions'] as List)
          .map((q) => QuestionModel.fromMap(q as Map<String, dynamic>))
          .toList(),
      difficulty: data['difficulty'] as String,
      category: data['category'] as String?,
      language: data['language'] as String,
      active: data['active'] as bool,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'publishedAt': Timestamp.fromDate(publishedAt),
      'questions': questions.map((q) => q.toMap()).toList(),
      'difficulty': difficulty,
      'category': category,
      'language': language,
      'active': active,
    };
  }

  /// Get total possible score for this quiz
  /// Per specification: 500 points max (100 per question * 5 questions)
  int get maxScore => questions.length * 100;

  @override
  List<Object?> get props => [
        id,
        publishedAt,
        questions,
        difficulty,
        category,
        language,
        active,
      ];
}
