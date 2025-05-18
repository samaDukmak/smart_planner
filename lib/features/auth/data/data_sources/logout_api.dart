// features/Auth/data/data_sources/logout_api.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class LogoutApi {
  final String baseUrl = 'http://10.0.2.2:8000/api';

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
     print('▶️ [LogoutApi] token="$token"');
    print("Logout using token: $token"); // ✅ للتأكد

    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {
        'Authorization': 'Bearer $token', // ✅ ضروري جداً
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Logout failed: ${response.body}");
    }
  }
}
