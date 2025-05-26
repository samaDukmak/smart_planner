// features/study_schedule/domain/repositories/tasks_repository_impl.dart

import 'package:flutter_application_5/features/study_schedule/data/data_sources/tasks_api.dart';
import 'package:flutter_application_5/features/study_schedule/data/models/task_model.dart';
import 'package:flutter_application_5/features/study_schedule/data/repository/tasks_repository_impl.dart';


class TasksRepositoryImpl implements TasksRepository {
  final TasksApi api;
  TasksRepositoryImpl(this.api);

  @override
  Future<List<TaskModel>> getTasks(String token) =>
      api.getTasks(token);

  @override
  Future<bool> startTask(int id, String token) =>
      api.startTask(id, token);

  @override
  Future<int?> pauseTask(int id, int m, String t) =>
      api.pauseTask(id, m, t);

  @override
  Future<int?> giveUpTask(int id, int m, String t) =>
      api.giveUpTask(id, m, t);

      Future<Map<String, dynamic>?> completeTask(int id, String token) =>
      api.completeTask(id, token);
}

