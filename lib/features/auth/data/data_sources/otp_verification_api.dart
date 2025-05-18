// features/Auth/data/data_sources/otp_verification_api.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';

class OtpApi {
  final String baseUrl = 'http://10.0.2.2:8000/api';

  Future<UserModel> verifyOtp({
     required String email,
   
    required String otp,
  }) async {
    final url = Uri.parse('$baseUrl/verify-otp');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'otp': otp,
      }),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data['success'] == true) {
      return UserModel.fromJson(data['data']);
    } else {
      throw Exception(data['msg'] ?? 'OTP verification failed');
    }
  }

  Future<void> resendOtp(String email) async {
    final url = Uri.parse('$baseUrl/resend-verify-otp');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode != 200 || data['success'] != true) {
      throw Exception(data['msg'] ?? 'Failed to resend OTP');
    }
  }
}