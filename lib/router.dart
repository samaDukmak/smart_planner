// router.dart


// // import 'package:flutter/widgets.dart';
// // import 'package:flutter_application_5/Home_pages.dart';
// // import 'package:flutter_application_5/features/auth/presentation/pages/login_page.dart';
// // import 'package:flutter_application_5/features/auth/presentation/pages/otp_page.dart';
// // import 'package:flutter_application_5/features/auth/presentation/pages/signup_page.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// // class AppRouter {
// //   static Future<String> getInitialRoute() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     final token = prefs.getString('token');
// //     final pendingOtp = prefs.getBool('pendingOtp') ?? false;
// //     final pendingEmail = prefs.getString('pendingEmail') ?? '';

// //     if (token != null) {
// //       return '/home';
// //     } else if (pendingOtp && pendingEmail.isNotEmpty) {
// //       return '/otp';
// //     } else {
// //       return '/login';
// //     }
// //   }

// //   static Map<String, WidgetBuilder> routes(String pendingEmail) => {
// //     '/login': (_) => LoginPage(),
// //     '/signup': (_) => SignupPage(),
// //     '/otp': (_) => OtpPage(email: pendingEmail),
// //     '/home': (_) => HomePage(),
// //   };
// // }
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// // Auth
// import 'package:flutter_application_5/features/auth/presentation/pages/login_page.dart';
// import 'package:flutter_application_5/features/auth/presentation/pages/signup_page.dart';
// import 'package:flutter_application_5/features/auth/presentation/pages/otp_page.dart';

// // Study Scheduler
// import 'package:flutter_application_5/features/study_schedule/presentation/pages/start_page.dart';
// import 'package:flutter_application_5/features/study_schedule/presentation/pages/questions_page.dart';
// import 'package:flutter_application_5/features/study_schedule/presentation/pages/subject_details_page.dart';
// import 'package:flutter_application_5/features/study_schedule/presentation/pages/result_page.dart';
// import 'package:flutter_application_5/features/study_schedule/presentation/cubit/study_schedule_cubit.dart';
// import 'package:flutter_application_5/features/study_schedule/domain/usecases/fetch_questions.dart';
// import 'package:flutter_application_5/features/study_schedule/domain/usecases/submit_schedule.dart';
// import 'package:flutter_application_5/features/study_schedule/data/data_sources/study_schedule_api.dart';
// import 'package:flutter_application_5/features/study_schedule/data/repository/study_schedule_repository_impl.dart';

// class AppRouter {
//   static Future<String> getInitialRoute() async {
//     final prefs       = await SharedPreferences.getInstance();
//     final token       = prefs.getString('token');
//     final pendingOtp  = prefs.getBool('pendingOtp') ?? false;
//     final pendingEmail = prefs.getString('pendingEmail') ?? '';

//     if (token != null && token.isNotEmpty) {
//       return '/start';
//     } else if (pendingOtp && pendingEmail.isNotEmpty) {
//       return '/otp';
//     } else {
//       return '/login';
//     }
//   }

//   static Map<String, WidgetBuilder> routes(String pendingEmail) {
//     final api        = StudyScheduleApi();
//     final repo       = StudyScheduleRepositoryImpl(api);
//     final fetchQ     = FetchQuestions(repo);
//     final submitSched = SubmitSchedule(repo);

//     return {
//       // Authentication
//       '/login'   : (_) =>  LoginPage(),
//       '/signup'  : (_) =>  SignupPage(),
//       '/otp'     : (_) => OtpPage(email: pendingEmail),

//       // Study Planner flow
//       '/start'     : (_) => const StartPage(),
//       '/questions' : (ctx) => BlocProvider(
//                           create: (_) => StudyScheduleCubit(fetchQ, submitSched)
//                                             ..loadQuestions(),
//                           child: const QuestionsPage(),
//                         ),
//       '/details'   : (_) => const SubjectDetailsPage(),
//       '/result'    : (_) => const ResultPage(),
//     };
//   }
// }
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// — Auth pages & cubit
import 'package:flutter_application_5/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_application_5/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter_application_5/features/auth/presentation/pages/otp_page.dart';

// — Study Scheduler:
//   - API & Repository
import 'package:flutter_application_5/features/study_schedule/data/data_sources/study_schedule_api.dart';
import 'package:flutter_application_5/features/study_schedule/data/repository/study_schedule_repository_impl.dart';
//   - Use cases
import 'package:flutter_application_5/features/study_schedule/domain/usecases/fetch_questions.dart';
import 'package:flutter_application_5/features/study_schedule/domain/usecases/submit_schedule.dart';
//   - Cubit
import 'package:flutter_application_5/features/study_schedule/presentation/cubit/study_schedule_cubit.dart';
//   - UI pages
import 'package:flutter_application_5/features/study_schedule/presentation/pages/start_page.dart';
import 'package:flutter_application_5/features/study_schedule/presentation/pages/questions_page.dart';
import 'package:flutter_application_5/features/study_schedule/presentation/pages/subject_details_page.dart';
import 'package:flutter_application_5/features/study_schedule/presentation/pages/result_page.dart';

class AppRouter {
  static Future<String> getInitialRoute() async {
    final prefs        = await SharedPreferences.getInstance();
    final token        = prefs.getString('token');
    final pendingOtp   = prefs.getBool('pendingOtp') ?? false;
    final pendingEmail = prefs.getString('pendingEmail') ?? '';

    if (token != null && token.isNotEmpty) return '/start';
    if (pendingOtp && pendingEmail.isNotEmpty) return '/otp';
    return '/login';
  }

  static Map<String, WidgetBuilder> routes(String pendingEmail) {
    // تهيئة الـ Study Scheduler
    final api     = StudyScheduleApi();
    final repo    = StudyScheduleRepositoryImpl(api);
    final fetchQ  = FetchQuestions(repo);
    final submitS = SubmitSchedule(repo);

    return {
      // Auth flow
      '/login'   : (_) =>  LoginPage(),
      '/signup'  : (_) =>  SignupPage(),
      '/otp'     : (_) => OtpPage(email: pendingEmail),

      // Study Planner flow
      '/start'     : (_) => const StartPage(),
      '/questions': (ctx) => BlocProvider(
                          create: (_) => StudyScheduleCubit(fetchQ, submitS)
                                            ..loadQuestions(),
                          child: const QuestionsPage(),
                        ),
      '/details'   : (_) => const SubjectDetailsPage(),
      '/result'    : (_) => const ResultPage(),
    };
  }
}

