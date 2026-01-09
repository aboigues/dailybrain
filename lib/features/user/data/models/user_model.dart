import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// User model matching Firestore schema from specification section 3.2
/// Constitution Principle III: Server-side validation for all user data
class UserModel extends Equatable {
  final String id;
  final String username;
  final DateTime createdAt;
  final String lastPlayedDate; // YYYY-MM-DD format
  final int currentStreak;
  final int longestStreak;
  final int totalScore;
  final int quizzesCompleted;
  final DateTime? recoveryAvailableAt;
  final String deviceId; // Hashed per Constitution Principle III
  final String platform; // 'ios' | 'android'
  final String appVersion;

  const UserModel({
    required this.id,
    required this.username,
    required this.createdAt,
    required this.lastPlayedDate,
    required this.currentStreak,
    required this.longestStreak,
    required this.totalScore,
    required this.quizzesCompleted,
    this.recoveryAvailableAt,
    required this.deviceId,
    required this.platform,
    required this.appVersion,
  });

  /// Factory constructor from Firestore document
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      username: data['username'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      lastPlayedDate: data['lastPlayedDate'] as String,
      currentStreak: data['currentStreak'] as int,
      longestStreak: data['longestStreak'] as int,
      totalScore: data['totalScore'] as int,
      quizzesCompleted: data['quizzesCompleted'] as int,
      recoveryAvailableAt: data['recoveryAvailableAt'] != null
          ? (data['recoveryAvailableAt'] as Timestamp).toDate()
          : null,
      deviceId: data['deviceId'] as String,
      platform: data['platform'] as String,
      appVersion: data['appVersion'] as String,
    );
  }

  /// Convert to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'username': username,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastPlayedDate': lastPlayedDate,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'totalScore': totalScore,
      'quizzesCompleted': quizzesCompleted,
      'recoveryAvailableAt': recoveryAvailableAt != null
          ? Timestamp.fromDate(recoveryAvailableAt!)
          : null,
      'deviceId': deviceId,
      'platform': platform,
      'appVersion': appVersion,
    };
  }

  /// Create a copy with updated fields
  UserModel copyWith({
    String? id,
    String? username,
    DateTime? createdAt,
    String? lastPlayedDate,
    int? currentStreak,
    int? longestStreak,
    int? totalScore,
    int? quizzesCompleted,
    DateTime? recoveryAvailableAt,
    String? deviceId,
    String? platform,
    String? appVersion,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      createdAt: createdAt ?? this.createdAt,
      lastPlayedDate: lastPlayedDate ?? this.lastPlayedDate,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      totalScore: totalScore ?? this.totalScore,
      quizzesCompleted: quizzesCompleted ?? this.quizzesCompleted,
      recoveryAvailableAt: recoveryAvailableAt ?? this.recoveryAvailableAt,
      deviceId: deviceId ?? this.deviceId,
      platform: platform ?? this.platform,
      appVersion: appVersion ?? this.appVersion,
    );
  }

  @override
  List<Object?> get props => [
        id,
        username,
        createdAt,
        lastPlayedDate,
        currentStreak,
        longestStreak,
        totalScore,
        quizzesCompleted,
        recoveryAvailableAt,
        deviceId,
        platform,
        appVersion,
      ];
}
