// features/study_schedule/data/models/api_subject_model.dart
class ApiSubjectModel {
  final int id;
  final String name;
  final int time;
  final int? priority;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  ApiSubjectModel({
    required this.id,
    required this.name,
    required this.time,
    this.priority,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ApiSubjectModel.fromJson(Map<String, dynamic> json) => ApiSubjectModel(
    id: json['id'],
    name: json['subject_name'],
    time: json['time'],
    priority: json['priority'],
    userId: json['user_id'],
    createdAt: DateTime.parse(json['created_at']),
    updatedAt: DateTime.parse(json['updated_at']),
  );
}
