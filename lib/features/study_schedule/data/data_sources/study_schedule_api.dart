// features/study_schedule/data/data_sources/study_schedule_api.dart

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/question_model.dart';
import '../models/schedule_request.dart';
import '../models/schedule_response.dart';

class StudyScheduleApi {
  final String baseUrl = 'http://10.0.2.2:8000/api/study-schedule';
  //final String baseUrl = 'http://0.0.0.0:8000/api/study-schedule';

  Future<List<QuestionModel>> fetchQuestions(String token) async {
    final url = Uri.parse('$baseUrl/questions');
    final res = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode == 200 && body['success'] == true) {
      final data = body['data'] as Map<String, dynamic>?;
      if (data == null) throw Exception('No data field');
      return data.entries
          .map((e) => QuestionModel(key: e.key, text: e.value as String))
          .toList();
    } else {
      throw Exception(body['msg'] ?? 'Failed to load questions');
    }
  }

  Future<ScheduleResponse> submitSchedule({
    required String token,
    required ScheduleRequest request,
  }) async {
    final url = Uri.parse('$baseUrl/submit');
    final payload = jsonEncode(request.toJson());
    final res = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: payload,
    );
    if (kDebugMode) {
      debugPrint('→ POST $url');
      debugPrint('→ payload: $payload');
      debugPrint('→ status: ${res.statusCode}');
      debugPrint('→ response: ${res.body}');
    }
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    if (res.statusCode == 200 && body['success'] == true) {
      return ScheduleResponse.fromJson(body);
    } else {
      throw Exception('Error ${res.statusCode}: ${body['msg'] ?? res.body}');
    }
  }



  
}
