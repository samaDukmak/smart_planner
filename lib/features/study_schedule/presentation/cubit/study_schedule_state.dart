// features/study_schedule/presentation/cubit/study_schedule_state.dart
// import '../../domain/entities/question.dart';
// import '../../data/models/schedule_response.dart';

// abstract class StudyScheduleState {}

// class SSInitial extends StudyScheduleState {}

// class SSLoading extends StudyScheduleState {}

// class SSQuestionsLoaded extends StudyScheduleState {
//   final List<Question> questions;
//   SSQuestionsLoaded(this.questions);
// }

// class SSSubmissionSuccess extends StudyScheduleState {
//   final ScheduleResponse response;
//   SSSubmissionSuccess(this.response);
// }

// class SSError extends StudyScheduleState {
//   final String message;
//   SSError(this.message);
// }
import '../../domain/entities/question.dart';
import '../../data/models/schedule_response.dart';

abstract class StudyScheduleState {}
class SSInitial extends StudyScheduleState {}
class SSLoading extends StudyScheduleState {}
class SSQuestionsLoaded extends StudyScheduleState {
  final List<Question> questions;
  SSQuestionsLoaded(this.questions);
}
class SSSubmissionSuccess extends StudyScheduleState {
  final ScheduleResponse response;
  SSSubmissionSuccess(this.response);
}
class SSError extends StudyScheduleState {
  final String message;
  SSError(this.message);
}