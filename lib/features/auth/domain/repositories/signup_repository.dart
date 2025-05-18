// features/Auth/data/models/signup_repository.dart
import 'package:flutter_application_5/features/auth/data/models/user_model.dart';

abstract class SignupRepository {
  Future<UserModel> signup({
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
  });
}