// features/auth/data/repository/signup_repository_impl.dart
import 'package:flutter_application_5/features/auth/data/data_sources/signup_api.dart';
import 'package:flutter_application_5/features/auth/domain/repositories/signup_repository.dart';
import 'package:flutter_application_5/features/auth/data/models/user_model.dart';

class SignupRepositoryImpl implements SignupRepository {
  final SignupApi signupApi;

  SignupRepositoryImpl(this.signupApi);

  @override
  Future<UserModel> signup({
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    return signupApi.signup(
      userName: userName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}
