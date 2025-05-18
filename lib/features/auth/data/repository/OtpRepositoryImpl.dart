// features/auth/data/repository/OtpRepositoryImpl.dart
import 'package:flutter_application_5/features/auth/data/data_sources/otp_verification_api.dart';
import 'package:flutter_application_5/features/auth/domain/repositories/otp_repository.dart';
import 'package:flutter_application_5/features/auth/data/models/user_model.dart';

class OtpRepositoryImpl implements OtpRepository {
  final OtpApi otpApi;

  OtpRepositoryImpl(this.otpApi);

  @override
  Future<UserModel> verifyOtp({
    required String email,
    required String otp,
  }) {
    return otpApi.verifyOtp( otp: otp,email: email);
  }

  @override
  Future<void> resendOtp(String email) {
    return otpApi.resendOtp(email);
  }
}