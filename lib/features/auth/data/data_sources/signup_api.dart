// features/Auth/data/data_sources/signup_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_application_5/features/auth/data/models/user_model.dart';

class SignupApi {
  final String baseUrl = 'http://10.0.2.2:8000/api';

  Future<UserModel> signup({
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final url = Uri.parse('$baseUrl/register');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_name': userName,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['success'] == true) {
      return UserModel.fromJson(data['data']);
    } else {
      throw Exception(
        data['message'] ??
        data['errors']?['email']?[0] ??
        'Registration failed',
      );
    }
  }
}