// features/study_schedule/domain/usecases/fetch_questions.dart
import '../entities/question.dart';
import '../repositories/study_schedule_repository.dart';

class FetchQuestions {
  final StudyScheduleRepository repo;
  FetchQuestions(this.repo);
  Future<List<Question>> call(String token) => repo.fetchQuestions(token);
}