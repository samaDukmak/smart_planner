// main.dart



// import 'package:flutter/material.dart';

// import 'package:flutter_application_5/features/auth/data/data_sources/login_api.dart';
// import 'package:flutter_application_5/features/auth/data/data_sources/otp_verification_api.dart';
// import 'package:flutter_application_5/features/auth/data/data_sources/signup_api.dart';
// import 'package:flutter_application_5/features/auth/data/repository/OtpRepositoryImpl.dart';
// import 'package:flutter_application_5/features/auth/data/repository/login_repository_impl.dart';
// import 'package:flutter_application_5/features/auth/data/repository/signup_repository_impl.dart';

// import 'package:flutter_application_5/features/auth/presentation/cubit/auth_cubit.dart';
// import 'package:flutter_application_5/router.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   final prefs = await SharedPreferences.getInstance();
//   final pendingEmail = prefs.getString('pendingEmail') ?? '';
//   final initialRoute = await AppRouter.getInitialRoute();

//   runApp(MyApp(initialRoute: initialRoute, pendingEmail: pendingEmail));
// }

// class MyApp extends StatelessWidget {
//   final String initialRoute;
//   final String pendingEmail;

//   const MyApp({
//     required this.initialRoute,
//     required this.pendingEmail,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (_) => AuthCubit(
//             loginRepository: LoginRepositoryImpl(LoginApi()),
//             signupRepository: SignupRepositoryImpl(SignupApi()),
//             otpRepository: OtpRepositoryImpl(OtpApi()),
//           ),
//         ),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         initialRoute: initialRoute,
//         routes: AppRouter.routes(pendingEmail),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_application_5/features/auth/data/repository/OtpRepositoryImpl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'router.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/data/data_sources/login_api.dart';
import 'features/auth/data/data_sources/signup_api.dart';
import 'features/auth/data/data_sources/otp_verification_api.dart';
import 'features/auth/data/repository/login_repository_impl.dart';
import 'features/auth/data/repository/signup_repository_impl.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs         = await SharedPreferences.getInstance();
  final pendingEmail  = prefs.getString('pendingEmail') ?? '';
  final initialRoute  = await AppRouter.getInitialRoute();

  runApp(MyApp(
    initialRoute: initialRoute,
    pendingEmail: pendingEmail,
  ));
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
    return BlocProvider(
      create: (_) => AuthCubit(
        loginRepository:  LoginRepositoryImpl(LoginApi()),
        signupRepository: SignupRepositoryImpl(SignupApi()),
        otpRepository:    OtpRepositoryImpl(OtpApi()),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: initialRoute,
        routes: AppRouter.routes(pendingEmail),
        theme: ThemeData.dark(),
      ),
    );
  }
}


