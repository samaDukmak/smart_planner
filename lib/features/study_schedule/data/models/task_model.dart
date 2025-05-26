// features/study_schedule/data/models/task_model.dart

import 'api_subject_model.dart';

class TaskModel {
  final int id, subjectId, userId;
  final String status;                 // pending | in_progress | pause | give_up | completed
  final int? priority;

  /// الزمن المتبقّي (من السيرفر) إما في complete_time أو pause_time
  final int? remainingMinutes;

  final ApiSubjectModel subject;
  final DateTime createdAt, updatedAt;

  const TaskModel({
    required this.id,
    required this.subjectId,
    required this.status,
    required this.userId,
    required this.subject,
    required this.createdAt,
    required this.updatedAt,
    this.priority,
    this.remainingMinutes,
  });

  factory TaskModel.fromJson(Map<String, dynamic> j) => TaskModel(
        id              : j['id'],
        subjectId       : j['subject_id'],
        status          : j['status'],
        priority        : j['priority'],
        userId          : j['user_id'],
        remainingMinutes: j['complete_time'] != null
            ? int.tryParse(j['complete_time'].toString())
            : j['pause_time'],
        subject         : ApiSubjectModel.fromJson(j['subject']),
        createdAt       : DateTime.parse(j['created_at']),
        updatedAt       : DateTime.parse(j['updated_at']),
      );

  TaskModel copyWith({
    String? status,
    int?    remainingMinutes,
  }) =>
      TaskModel(
        id              : id,
        subjectId       : subjectId,
        status          : status ?? this.status,
        priority        : priority,
        userId          : userId,
        subject         : subject,
        createdAt       : createdAt,
        updatedAt       : DateTime.now(),
        remainingMinutes: remainingMinutes ?? this.remainingMinutes,
      );
}

