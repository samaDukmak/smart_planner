// features/Auth/data/models/otp_repository.dart
import 'package:flutter_application_5/features/auth/data/models/user_model.dart';

abstract class OtpRepository {
  Future<UserModel> verifyOtp({
  required String email,
    required String otp,
  });

  Future<void> resendOtp(String email);
}
