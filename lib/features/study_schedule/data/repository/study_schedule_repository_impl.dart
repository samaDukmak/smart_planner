// features/study_schedule/data/repository/study_schedule_repository_impl.dart
import 'package:flutter_application_5/features/study_schedule/data/data_sources/study_schedule_api.dart';
import 'package:flutter_application_5/features/study_schedule/data/models/schedule_request.dart';
import 'package:flutter_application_5/features/study_schedule/data/models/schedule_response.dart';
import 'package:flutter_application_5/features/study_schedule/domain/entities/question.dart';
import 'package:flutter_application_5/features/study_schedule/domain/repositories/study_schedule_repository.dart';


// import '../../domain/repositories/study_schedule_repository.dart';
// import '../../domain/entities/question.dart';
// import '../data_sources/study_schedule_api.dart';

// import '../models/schedule_request.dart';
// import '../models/schedule_response.dart';

// class StudyScheduleRepositoryImpl implements StudyScheduleRepository {
//   final StudyScheduleApi api;
//   StudyScheduleRepositoryImpl(this.api);

//   @override
//   Future<List<Question>> fetchQuestions(String token) async {
//     // تأكد هنا إنك ترجع Future<List<QuestionModel>> من الـ API
//     final models = await api.fetchQuestions(token);  // قبل
//     // final models = api.fetchQuestions(token);      // × غلط

//     // وبعدين حولهم للـ entity
//     return models
//       .map((m) => Question(key: m.key, text: m.text))
//       .toList();
//   }

//   @override
//   Future<ScheduleResponse> submitSchedule({
//     required String token,
//     required ScheduleRequest request,
//   }) {
//     return api.submitSchedule(token: token, request: request);
//   }
// }

class StudyScheduleRepositoryImpl implements StudyScheduleRepository {
  final StudyScheduleApi api;
  StudyScheduleRepositoryImpl(this.api);

  @override
  Future<List<Question>> fetchQuestions(String token) async {
    final models = await api.fetchQuestions(token);
    return models.map((m) => Question(key: m.key, text: m.text)).toList();
  }

  @override
  Future<ScheduleResponse> submitSchedule({
    required String token,
    required ScheduleRequest request,
  }) => api.submitSchedule(token: token, request: request);
}