// features/study_schedule/data/data_sources/tasks_api.dart

import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../models/task_model.dart';

class TasksApi {
  final String baseUrl = 'http://10.0.2.2:8000/api';

  Future<List<TaskModel>> getTasks(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/tasks'),
      headers: {'Authorization': 'Bearer $token'},
    );
    final data = jsonDecode(response.body);
    if (data['success'] == true && data['data'] != null) {
      return (data['data'] as List)
          .map((json) => TaskModel.fromJson(json))
          .toList();
    } else {
      return [];
    }
  }

  Future<bool> startTask(int id, String token) async {
    final res = await http.post(
      Uri.parse('$baseUrl/tasks/$id/start'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    debugPrint('START $id → ${res.statusCode}');
    debugPrint(res.body);

    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      return body['success'] == true;
    }
    return false;
  }

  Future<int?> pauseTask(int id, int mins, String token) async {
    final res = await http.post(
      Uri.parse('$baseUrl/tasks/$id/pause'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'pause_time': mins}),
    );
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      return body['data']?['complete_time'];
    }
    return null;
  }

  Future<int?> giveUpTask(int id, int mins, String token) async {
    final res = await http.post(
      Uri.parse('$baseUrl/tasks/$id/give-up'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'give_up_time': mins}),
    );
    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      return body['data']?['complete_time'];
    }
    return null;
  }

   Future<Map<String, dynamic>?> completeTask(int id, String token) async {
    final res = await http.post(
      Uri.parse('$baseUrl/tasks/$id/complete'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept':        'application/json',
        'Content-Type':  'application/json',
      },
      body: jsonEncode({'completed_time': 0}),
    );
    if (res.statusCode == 200) {
      final b = jsonDecode(res.body);
      final giftWrapper = b['data']?['gift']?['original']?['data']?['gift'];
      if (giftWrapper != null) {
        return giftWrapper as Map<String, dynamic>;
      }
    }
    return null;
  }

}
