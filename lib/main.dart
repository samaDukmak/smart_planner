// main.dart

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'router.dart';

// // Auth Cubit/Repo
// import 'features/auth/presentation/cubit/auth_cubit.dart';
// import 'features/auth/data/repository/OtpRepositoryImpl.dart';
// import 'features/auth/data/repository/login_repository_impl.dart';
// import 'features/auth/data/repository/signup_repository_impl.dart';
// import 'features/auth/data/data_sources/login_api.dart';
// import 'features/auth/data/data_sources/signup_api.dart';
// import 'features/auth/data/data_sources/otp_verification_api.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   final prefs = await SharedPreferences.getInstance();
//   final pendingEmail = prefs.getString('pendingEmail') ?? '';
//   final initialRoute = await AppRouter.getInitialRoute();
  
//   runApp(MyApp(
//     initialRoute: initialRoute,
//     pendingEmail: pendingEmail,
//   ));
// }

// class MyApp extends StatelessWidget {
//   final String initialRoute;
//   final String pendingEmail;

//   const MyApp({
//     required this.initialRoute,
//     required this.pendingEmail,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => AuthCubit(
//         loginRepository: LoginRepositoryImpl(LoginApi()),
//         signupRepository: SignupRepositoryImpl(SignupApi()),
//         otpRepository: OtpRepositoryImpl(OtpApi()),
//       ),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         initialRoute: initialRoute,
//         routes: AppRouter.routes(pendingEmail),
//         theme: ThemeData.dark(),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_application_5/features/auth/data/repository/OtpRepositoryImpl.dart';
import 'package:flutter_application_5/features/study_schedule/domain/repositories/tasks_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// auth
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/data/data_sources/login_api.dart';
import 'features/auth/data/data_sources/signup_api.dart';
import 'features/auth/data/data_sources/otp_verification_api.dart';
import 'features/auth/data/repository/login_repository_impl.dart';
import 'features/auth/data/repository/signup_repository_impl.dart';

// study schedule
import 'features/study_schedule/presentation/cubit/tasks_cubit.dart';
import 'features/study_schedule/data/data_sources/tasks_api.dart';
import 'features/study_schedule/data/repository/tasks_repository_impl.dart';


import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? '';
  final pendingEmail = prefs.getString('pendingEmail') ?? '';
  final initialRoute = await AppRouter.getInitialRoute();

  runApp(
    MultiBlocProvider(
      providers: [
        // Auth flow
        BlocProvider(
          create: (_) => AuthCubit(
            loginRepository: LoginRepositoryImpl(LoginApi()),
            signupRepository: SignupRepositoryImpl(SignupApi()),
            otpRepository: OtpRepositoryImpl(OtpApi()),
          ),
        ),

        // TasksCubit: لتحميل مهام الـ study schedule
        BlocProvider(
          create: (_) => TasksCubit(
            TasksRepositoryImpl(TasksApi()),
          )..loadTasks(token),
        ),

        // PlanetCubit: لتحميل قائمة الكواكب
        // BlocProvider(
        //   create: (_) => PlanetCubit(
        //     PlanetRepositoryImpl(PlanetApi()),
        //   )..loadAll(token),
        // ),
      ],
      child: MyApp(
        initialRoute: initialRoute,
        pendingEmail: pendingEmail,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  final String pendingEmail;

  const MyApp({
    required this.initialRoute,
    required this.pendingEmail,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      initialRoute: initialRoute,
      routes: AppRouter.routes(pendingEmail),
    );
  }
}
