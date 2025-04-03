import 'package:dairl/constants/cloud_field_names.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@immutable
class CloudQuest {
  final String userId;
  final String questId;
  final String questTitle;
  final String questDescription;
  final bool isCompleted;
  final int streak;
  final int longestStreak;
  final DateTime? completedAt;

  const CloudQuest({
    required this.questId,
    required this.userId,
    required this.questTitle,
    required this.questDescription,
    required this.isCompleted,
    required this.streak,
    required this.longestStreak,
    required this.completedAt,
  });

  CloudQuest.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
    : questId = snapshot.id,
      userId = snapshot.data()[userIdFieldName],
      questTitle = snapshot[questTitleFieldName],
      questDescription = snapshot[questDescriptionFieldName],
      isCompleted = snapshot.data()[isCompletedFieldName],
      streak = snapshot.data()[streakFieldName],
      longestStreak = snapshot.data()[longestStreakFieldName],
      completedAt = snapshot.data()[completedAtFieldName];
}
