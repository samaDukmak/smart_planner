// features/study_schedule/presentation/cubit/tasks_state.dart

import '../../data/models/task_model.dart';

/// الحالات الممكنة لواجهة المهام
abstract class TasksState {}

class TasksInitial extends TasksState {}
class TasksLoading extends TasksState {}
class TasksEmpty extends TasksState {}
class TasksError extends TasksState {
  final String message;
  TasksError(this.message);
}
class TasksLoaded extends TasksState {
  final List<TaskModel> tasks;
  TasksLoaded(this.tasks);
}

