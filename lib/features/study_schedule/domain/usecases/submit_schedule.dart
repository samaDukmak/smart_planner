// features/study_schedule/domain/usecases/submit_schedule.dart
// import '../../data/models/schedule_request.dart';
// import '../../data/models/schedule_response.dart';
// import '../repositories/study_schedule_repository.dart';

// class SubmitSchedule {
//   final StudyScheduleRepository repository;
//   SubmitSchedule(this.repository);

//   Future<ScheduleResponse> call({
//     required String token,
//     required ScheduleRequest request,
//   }) =>
//       repository.submitSchedule(token: token, request: request);
// }
import '../../data/models/schedule_request.dart';
import '../../data/models/schedule_response.dart';
import '../repositories/study_schedule_repository.dart';

class SubmitSchedule {
  final StudyScheduleRepository repo;
  SubmitSchedule(this.repo);
  Future<ScheduleResponse> call({
    required String token,
    required ScheduleRequest request,
  }) => repo.submitSchedule(token: token, request: request);
}