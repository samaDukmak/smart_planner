// features/study_schedule/presentation/cubit/study_schedule_cubit.dart

import 'package:flutter_application_5/features/study_schedule/data/models/schedule_request.dart';
import 'package:flutter_application_5/features/study_schedule/domain/usecases/fetch_questions.dart';
import 'package:flutter_application_5/features/study_schedule/domain/usecases/submit_schedule.dart';
import 'package:flutter_application_5/features/study_schedule/presentation/cubit/study_schedule_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudyScheduleCubit extends Cubit<StudyScheduleState> {
  final FetchQuestions fetchQ;
  final SubmitSchedule submitS;
  StudyScheduleCubit(this.fetchQ, this.submitS) : super(SSInitial());

  Future<void> loadQuestions() async {
    emit(SSLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      if (token.isEmpty) throw Exception('No auth token');
      final qs = await fetchQ(token);
      emit(SSQuestionsLoaded(qs));
    } catch (e) {
      emit(SSError(e.toString()));
    }
  }

  Future<void> sendAnswers(ScheduleRequest req) async {
    emit(SSLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      if (token.isEmpty) throw Exception('No auth token');
      final res = await submitS(token: token, request: req);
      emit(SSSubmissionSuccess(res));
    } catch (e) {
      emit(SSError(e.toString()));
    }
  }
}
