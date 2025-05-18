// features/auth/presentation/cubit/auth_cubit.dart
import 'package:flutter_application_5/features/auth/domain/repositories/login_repository.dart';
import 'package:flutter_application_5/features/auth/domain/repositories/otp_repository.dart';

import 'package:flutter_application_5/features/auth/domain/repositories/signup_repository.dart';
import 'package:flutter_application_5/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginRepository loginRepository;
  final SignupRepository signupRepository;
  final OtpRepository otpRepository;

  AuthCubit({
    required this.loginRepository,
    required this.signupRepository,
    required this.otpRepository,
  }) : super(AuthInitial());

  void login(String email, String password) async {
    emit(LoginLoading());
    try {
      final user = await loginRepository.login(
        identifier: email,
        password: password,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', user.token);
      print('✅ [AuthCubit.login] saved token: ${user.token}');

      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  // void signup(String userName, String email, String password,
  //     String confirmPassword) async {
  //   emit(SignupLoading());
  //   try {
  //     final user = await signupRepository.signup(
  //       userName: userName,
  //       email: email,
  //       password: password,
  //       confirmPassword: confirmPassword,
  //     );

  //     emit(SignupSuccess());
  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.setBool('pendingOtp', true);
  //     await prefs.setString('pendingEmail', email);
  //     await prefs.setString('token', user.token);
  //   } catch (e) {
  //     emit(SignupError(e.toString()));
  //   }
  // }
  void signup(String userName, String email, String password, String confirmPassword) async {
  emit(SignupLoading());
  try {
    final user = await signupRepository.signup(
      userName: userName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('pendingEmail', email);
    await prefs.setString('pendingPassword', password);
    await prefs.setBool('pendingOtp', true);
    emit(SignupSuccess());
  } catch (e) {
    emit(SignupError(e.toString()));
  }
}


  // void verifyOtp(String email, String otp) async {
  //   emit(OtpLoading());
  //   try {
  //     final user = await otpRepository.verifyOtp(otp: otp, email: email);

  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.setString('token', user.token); // ✅ هذا ضروري جداً

  //     print("OTP token saved: ${user.token}");

  //     emit(OtpSuccess());
  //   } catch (e) {
  //     emit(OtpError(e.toString()));
  //   }
  // }
  void verifyOtp(String email, String otp) async {
  emit(OtpLoading());
  try {
    // خطوة 1: فعل الحساب (لا يُعيد توكن)
    await otpRepository.verifyOtp(email: email, otp: otp);

    // خطوة 2: استعادة الإيميل والباسورد
    final prefs = await SharedPreferences.getInstance();
    final savedEmail    = prefs.getString('pendingEmail')!;
    final savedPassword = prefs.getString('pendingPassword')!;

    // خطوة 3: اطلب login للحصول على توكن
    final user = await loginRepository.login(
      identifier: savedEmail,
      password: savedPassword,
    );

    // خطوة 4: خزّن التوكن الحقيقي
    await prefs.setString('token', user.token);
    print('✅ [AuthCubit] saved token after OTP login: ${user.token}');

    emit(OtpSuccess());
  } catch (e) {
    print('🚨 [AuthCubit] verifyOtp error: $e');
    emit(OtpError(e.toString()));
  }
}


  void resendOtp(String email) async {
    try {
      await otpRepository.resendOtp(email);
    } catch (e) {
      emit(OtpError(e.toString()));
    }
  }
}
