// features/auth/data/repository/login_repository_impl.dart
import 'package:flutter_application_5/features/auth/data/data_sources/login_api.dart';
import 'package:flutter_application_5/features/auth/domain/repositories/login_repository.dart';
import 'package:flutter_application_5/features/auth/data/models/user_model.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginApi loginApi;

  LoginRepositoryImpl(this.loginApi);

  @override
  Future<UserModel> login({
    required String identifier,
    required String password,
  }) {
    return loginApi.login(identifier: identifier, password: password);
  }
}
