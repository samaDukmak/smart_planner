// features/study_schedule/presentation/cubit/tasks_cubit.dart

import 'package:flutter_application_5/features/study_schedule/data/repository/tasks_repository_impl.dart';
import 'package:flutter_application_5/features/study_schedule/presentation/cubit/tasks_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksCubit extends Cubit<TasksState> {
  final TasksRepository repo;
  TasksCubit(this.repo) : super(TasksInitial());

  Future<void> loadTasks(String token) async {
    emit(TasksLoading());
    try {
      final tasks = await repo.getTasks(token);
      if (tasks.isEmpty) {
        emit(TasksEmpty());
      } else {
        emit(TasksLoaded(tasks));
      }
    } catch (e) {
      emit(TasksError('Failed to fetch tasks'));
    }
  }

  Future<bool> startTask(int id, String token) async {
    try {
      return await repo.startTask(id, token);
    } catch (e) {
      emit(TasksError(e.toString()));
      return false;
    }
  }

  Future<int?> pauseTask(int id, int mins, String token) async {
    try {
      final newMins = await repo.pauseTask(id, mins, token);
      if (newMins != null && state is TasksLoaded) {
        final updated = (state as TasksLoaded).tasks.map((t) {
          return t.id == id
              ? t.copyWith(status: 'pause', remainingMinutes: newMins)
              : t;
        }).toList();
        emit(TasksLoaded(updated));
      }
      return newMins;
    } catch (e) {
      emit(TasksError(e.toString()));
      return null;
    }
  }

  Future<int?> giveUpTask(int id, int mins, String token) async {
    try {
      final newMins = await repo.giveUpTask(id, mins, token);
      if (newMins != null && state is TasksLoaded) {
        final updated = (state as TasksLoaded).tasks.map((t) {
          return t.id == id
              ? t.copyWith(status: 'give_up', remainingMinutes: newMins)
              : t;
        }).toList();
        emit(TasksLoaded(updated));
      }
      return newMins;
    } catch (e) {
      emit(TasksError(e.toString()));
      return null;
    }
  }
  Future<Map<String, dynamic>?> completeTask(int id, String token) async {
    try {
      final gift = await repo.completeTask(id, token);
      if (gift != null && state is TasksLoaded) {
        final updated = (state as TasksLoaded).tasks.map((t) {
          return t.id == id
              ? t.copyWith(status: 'completed', remainingMinutes: 0)
              : t;
        }).toList();
        emit(TasksLoaded(updated));
      }
      return gift;
    } catch (e) {
      emit(TasksError('Failed to complete task'));
      return null;
    }
  }
}


