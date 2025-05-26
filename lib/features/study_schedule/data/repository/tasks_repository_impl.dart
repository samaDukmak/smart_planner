// features/study_schedule/data/repository/tasks_repository_impl.dart

import '../../data/models/task_model.dart';

abstract class TasksRepository {
  Future<List<TaskModel>> getTasks(String token);
  Future<bool>            startTask(int id, String token);
  Future<int?>            pauseTask(int id, int m, String t);
  Future<int?>            giveUpTask(int id, int m, String t);
  Future<Map<String, dynamic>?> completeTask(int id, String token);
}
