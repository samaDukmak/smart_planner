// features/Auth/data/data_sources/login_api.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';

class LoginApi {
  final String baseUrl = 'http://10.0.2.2:8000/api';

  Future<UserModel> login({
    required String identifier,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'identifier': identifier,
        'password': password,
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['success'] == true) {
      return UserModel.fromJson(data['data']);
    } else {
      throw Exception(data['msg'] ?? 'Login failed');
    }
  }
}
