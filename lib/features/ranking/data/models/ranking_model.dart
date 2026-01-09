import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// Ranking entry for a single user
class RankingEntryModel extends Equatable {
  final String userId;
  final String username;
  final int score;
  final int rank;
  final int streakBadge;

  const RankingEntryModel({
    required this.userId,
    required this.username,
    required this.score,
    required this.rank,
    required this.streakBadge,
  });

  factory RankingEntryModel.fromMap(Map<String, dynamic> map) {
    return RankingEntryModel(
      userId: map['userId'] as String,
      username: map['username'] as String,
      score: map['score'] as int,
      rank: map['rank'] as int,
      streakBadge: map['streakBadge'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'score': score,
      'rank': rank,
      'streakBadge': streakBadge,
    };
  }

  /// Get medal emoji for top 3 positions
  String? get medalEmoji {
    switch (rank) {
      case 1:
        return '🥇';
      case 2:
        return '🥈';
      case 3:
        return '🥉';
      default:
        return null;
    }
  }

  @override
  List<Object?> get props => [userId, username, score, rank, streakBadge];
}

/// Daily ranking model matching specification section 3.2
class DailyRankingModel extends Equatable {
  final String id; // YYYY-MM-DD format
  final List<RankingEntryModel> entries;
  final DateTime updatedAt;

  const DailyRankingModel({
    required this.id,
    required this.entries,
    required this.updatedAt,
  });

  factory DailyRankingModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DailyRankingModel(
      id: doc.id,
      entries: (data['entries'] as List)
          .map((e) => RankingEntryModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'entries': entries.map((e) => e.toMap()).toList(),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  /// Find user's rank in this ranking
  RankingEntryModel? findUserEntry(String userId) {
    try {
      return entries.firstWhere((entry) => entry.userId == userId);
    } catch (e) {
      return null;
    }
  }

  @override
  List<Object?> get props => [id, entries, updatedAt];
}

/// Global ranking model matching specification section 3.2
class GlobalRankingModel extends Equatable {
  final String userId;
  final String username;
  final int totalScore;
  final int rank;
  final int quizzesCompleted;
  final DateTime updatedAt;

  const GlobalRankingModel({
    required this.userId,
    required this.username,
    required this.totalScore,
    required this.rank,
    required this.quizzesCompleted,
    required this.updatedAt,
  });

  factory GlobalRankingModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return GlobalRankingModel(
      userId: doc.id,
      username: data['username'] as String,
      totalScore: data['totalScore'] as int,
      rank: data['rank'] as int,
      quizzesCompleted: data['quizzesCompleted'] as int,
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'username': username,
      'totalScore': totalScore,
      'rank': rank,
      'quizzesCompleted': quizzesCompleted,
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  /// Get medal emoji for top 3 positions
  String? get medalEmoji {
    switch (rank) {
      case 1:
        return '🥇';
      case 2:
        return '🥈';
      case 3:
        return '🥉';
      default:
        return null;
    }
  }

  @override
  List<Object?> get props => [
        userId,
        username,
        totalScore,
        rank,
        quizzesCompleted,
        updatedAt,
      ];
}
