// features/study_schedule/domain/repositories/study_schedule_repository.dart
import '../../data/models/schedule_request.dart';
import '../../data/models/schedule_response.dart';
import '../entities/question.dart';

abstract class StudyScheduleRepository {
  Future<List<Question>> fetchQuestions(String token);
  Future<ScheduleResponse> submitSchedule({
    required String token,
    required ScheduleRequest request,
  });
}