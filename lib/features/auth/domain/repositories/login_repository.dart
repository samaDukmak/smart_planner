// features/Auth/data/models/login_repository.dart
import 'package:flutter_application_5/features/auth/data/models/user_model.dart';



abstract class LoginRepository {
  Future<UserModel> login({
    required String identifier,
    required String password,
  });
}
