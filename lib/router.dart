// router.dart

// import 'package:flutter/widgets.dart';
// import 'package:flutter_application_5/features/study_schedule/presentation/pages/timer_page.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// // Auth Pages
// import 'package:flutter_application_5/features/auth/presentation/pages/login_page.dart';
// import 'package:flutter_application_5/features/auth/presentation/pages/signup_page.dart';
// import 'package:flutter_application_5/features/auth/presentation/pages/otp_page.dart';

// // Study Schedule Pages
// import 'package:flutter_application_5/features/study_schedule/presentation/pages/home_page.dart';
// import 'package:flutter_application_5/features/study_schedule/presentation/pages/start_page.dart';
// import 'package:flutter_application_5/features/study_schedule/presentation/pages/questions_page.dart';
// import 'package:flutter_application_5/features/study_schedule/presentation/pages/subject_details_page.dart';
// import 'package:flutter_application_5/features/study_schedule/presentation/pages/result_page.dart';

// // Cubits & UseCases (لصفحات الـ questions)
// import 'package:flutter_application_5/features/study_schedule/presentation/cubit/study_schedule_cubit.dart';
// import 'package:flutter_application_5/features/study_schedule/data/data_sources/study_schedule_api.dart';
// import 'package:flutter_application_5/features/study_schedule/data/repository/study_schedule_repository_impl.dart';
// import 'package:flutter_application_5/features/study_schedule/domain/usecases/fetch_questions.dart';
// import 'package:flutter_application_5/features/study_schedule/domain/usecases/submit_schedule.dart';

// class AppRouter {
//   static Future<String> getInitialRoute() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('token');
//     final pendingOtp = prefs.getBool('pendingOtp') ?? false;
//     final pendingEmail = prefs.getString('pendingEmail') ?? '';

//     if (token != null && token.isNotEmpty) {
//       return '/home';
//     } else if (pendingOtp && pendingEmail.isNotEmpty) {
//       return '/otp';
//     } else {
//       return '/login';
//     }
//   }

//   static Map<String, WidgetBuilder> routes(String pendingEmail) {
//     // تهيئة الـ Cubit/Usecase لأسئلة الجدولة
//     final api = StudyScheduleApi();
//     final repo = StudyScheduleRepositoryImpl(api);
//     final fetchQ = FetchQuestions(repo);
//     final submitS = SubmitSchedule(repo);

//     return {
//       // Auth Flow
//       '/login': (_) => LoginPage(),
//       '/signup': (_) => SignupPage(),
//       '/otp': (_) => OtpPage(email: pendingEmail),

//       // مهام اليوم (لو عندك مهام أو بتظهر start):
//       '/home': (_) => const HomePage(),

//       // أسئلة بناء الجدول
//       '/start': (_) => const StartPage(),
//       '/questions': (ctx) => BlocProvider(
//             create: (_) => StudyScheduleCubit(fetchQ, submitS)..loadQuestions(),
//             child: const QuestionsPage(),
//           ),
//       '/details': (_) => const SubjectDetailsPage(),

//       '/result': (_) => const ResultPage(),
//       // … ضمن Map<String, WidgetBuilder> routes …

//       '/timer': (ctx) {
//         final args = ModalRoute.of(ctx)!.settings.arguments as Map;
//         return TimerPage(
//           totalMinutes: args['minutes'] as int,
//           taskId: args['id'] as int,
//         );
//       },
//     };
//   }
// }
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// auth pages
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/signup_page.dart';
import 'features/auth/presentation/pages/otp_page.dart';

// study schedule pages
import 'features/study_schedule/presentation/pages/home_page.dart';
import 'features/study_schedule/presentation/pages/start_page.dart';
import 'features/study_schedule/presentation/pages/questions_page.dart';
import 'features/study_schedule/presentation/pages/subject_details_page.dart';
import 'features/study_schedule/presentation/pages/result_page.dart';
import 'features/study_schedule/presentation/pages/timer_page.dart';

import 'features/study_schedule/presentation/pages/completion_page.dart';

// cubits & usecases for questions
import 'features/study_schedule/presentation/cubit/study_schedule_cubit.dart';
import 'features/study_schedule/data/data_sources/study_schedule_api.dart';
import 'features/study_schedule/data/repository/study_schedule_repository_impl.dart';
import 'features/study_schedule/domain/usecases/fetch_questions.dart';
import 'features/study_schedule/domain/usecases/submit_schedule.dart';

class AppRouter {
  static Future<String> getInitialRoute() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final pendingOtp = prefs.getBool('pendingOtp') ?? false;
    final pendingEmail = prefs.getString('pendingEmail') ?? '';

    if (token != null && token.isNotEmpty) {
      return '/home';
    } else if (pendingOtp && pendingEmail.isNotEmpty) {
      return '/otp';
    } else {
      return '/login';
    }
  }

  static Map<String, WidgetBuilder> routes(String pendingEmail) {
    // إعداد الأسئلة (questions flow)
    final api = StudyScheduleApi();
    final repo = StudyScheduleRepositoryImpl(api);
    final fetchQ = FetchQuestions(repo);
    final submitS = SubmitSchedule(repo);

    return {
      // Auth
      '/login': (_) => LoginPage(),
      '/signup': (_) => SignupPage(),
      '/otp': (_) => OtpPage(email: pendingEmail),

      // Study schedule
      '/home': (_) => const HomePage(),
      '/start': (_) => const StartPage(),
      '/questions': (ctx) => BlocProvider(
            create: (_) => StudyScheduleCubit(fetchQ, submitS)..loadQuestions(),
            child: const QuestionsPage(),
          ),
      '/details': (_) => const SubjectDetailsPage(),
      '/result': (_) => const ResultPage(),

      // Timer (named route)
      '/timer': (ctx) {
        final args = ModalRoute.of(ctx)!.settings.arguments as Map;
        return TimerPage(
          totalMinutes: args['minutes'] as int,
          taskId:       args['id']      as int,
        );
      },

      // View Progress
      // '/view-progress': (_) => const ProgressPage(),

      // Completion page (بعد انتهاء المؤقت)
      '/completion': (ctx) {
        final args = ModalRoute.of(ctx)!.settings.arguments as Map;
        return CompletionPage(
      
          hasStar:    args['hasStar']    as bool,
          planetName: args['planetName'] as String,
        );
      },
    };
  }
}
