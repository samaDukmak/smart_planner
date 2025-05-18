// features/study_schedule/data/data_sources/study_schedule_api.dart
// // // import 'dart:convert';

// // // import 'package:flutter_application_5/features/study_schedule/data/models/question_model.dart';
// // // import 'package:flutter_application_5/features/study_schedule/data/models/schedule_request.dart';
// // // import 'package:flutter_application_5/features/study_schedule/data/models/schedule_response.dart';
// // // import 'package:http/http.dart' as http;
// // // class StudyScheduleApi {
// // //   final String baseUrl = 'http://10.0.2.2:8000/api/study-schedule';

// // //   Future<List<QuestionModel>> fetchQuestions(String token) async {
// // //     final url = Uri.parse('$baseUrl/questions');
// // //     final res = await http.get(
// // //       url,
// // //       headers: {
// // //         'Authorization': 'Bearer $token',
// // //         'Content-Type': 'application/json',
// // //       },
// // //     );
// // //     final body = jsonDecode(res.body);
// // //     if (res.statusCode == 200 && body['success'] == true) {
// // //       return (body['data'] as Map<String, dynamic>)
// // //           .entries
// // //           .map((e) => QuestionModel(key: e.key, text: e.value as String))
// // //           .toList();
// // //     } else {
// // //       throw Exception(body['msg'] ?? 'Failed to load questions');
// // //     }
// // //   }

// // //   Future<ScheduleResponse> submitSchedule({
// // //     required String token,
// // //     required ScheduleRequest request,
// // //   }) async {
// // //     final url = Uri.parse('$baseUrl/submit');
// // //     final res = await http.post(
// // //       url,
// // //       headers: {
// // //         'Authorization': 'Bearer $token',
// // //         'Content-Type': 'application/json',
// // //       },
// // //       body: jsonEncode(request.toJson()),
// // //     );
// // //     final body = jsonDecode(res.body);
// // //     if (res.statusCode == 200 && body['success'] == true) {
// // //       return ScheduleResponse.fromJson(body['data']);
// // //     } else {
// // //       throw Exception(body['msg'] ?? 'Failed to submit schedule');
// // //     }
// // //   }
// // // }
// // import 'dart:convert';
// // import 'package:flutter/foundation.dart';
// // import 'package:http/http.dart' as http;
// // import '../models/question_model.dart';
// // import '../models/schedule_request.dart';
// // import '../models/schedule_response.dart';

// // class StudyScheduleApi {
// //   final String baseUrl = 'http://10.0.2.2:8000/api/study-schedule';

// //   Future<List<QuestionModel>> fetchQuestions(String token) async {
// //     final url = Uri.parse('$baseUrl/questions');
// //     final res = await http.get(
// //       url,
// //       headers: {
// //         'Authorization': 'Bearer $token',
// //         'Content-Type': 'application/json',
// //       },
// //     );
// //     final body = jsonDecode(res.body);
// //     if (res.statusCode == 200 && body['success'] == true) {
// //       return (body['data'] as Map<String, dynamic>)
// //           .entries
// //           .map((e) => QuestionModel(key: e.key, text: e.value as String))
// //           .toList();
// //     } else {
// //       throw Exception(body['msg'] ?? 'Failed to load questions');
// //     }
// //   }

// // //   Future<ScheduleResponse> submitSchedule({
// // //     required String token,
// // //     required ScheduleRequest request,
// // //   }) async {
// // //     final url = Uri.parse('$baseUrl/submit');
// // //     final res = await http.post(
// // //       url,
// // //       headers: {
// // //         'Authorization': 'Bearer $token',
// // //         'Content-Type': 'application/json',
// // //       },
// // //       body: jsonEncode(request.toJson()),
// // //     );

// // //     // Debugging logs (optional)
// // //     if (kDebugMode) {
// // //       debugPrint('››› POST $url');
// // //       debugPrint('››› payload: ${jsonEncode(request.toJson())}');
// // //       debugPrint('››› status: ${res.statusCode}');
// // //       debugPrint('››› response: ${res.body}');
// // //     }

// // //     final body = jsonDecode(res.body);
// // //     if (res.statusCode == 200 && body['success'] == true) {
// // //       // الباك-إند يرجّع:
// // //       // {
// // //       //   "msg": "...",
// // //       //   "success": true,
// // //       //   "schedule": [ { "name": "...", "time": 240 }, ... ]
// // //       // }
// // //       // لذا نمرّر الـ root body للـ fromJson
// // //       return ScheduleResponse.fromJson(body);
// // //     } else {
// // //       final msg = body['msg'] ?? 'Failed to submit schedule';
// // //       throw Exception('Error ${res.statusCode}: $msg');
// // //     }
// // //   }
// // // }
// // // features/study_schedule/data/data_sources/study_schedule_api.dart

// // // Future<ScheduleResponse> submitSchedule({
// // //   required String token,
// // //   required ScheduleRequest request,
// // // }) async {
// // //   final url = Uri.parse('$baseUrl/submit');
// // //   final payload = jsonEncode(request.toJson());
// // //   final res = await http.post(
// // //     url,
// // //     headers: {
// // //       'Authorization': 'Bearer $token',
// // //       'Content-Type': 'application/json',
// // //     },
// // //     body: payload,
// // //   );

// // //   // ===== طباعة للتصحيح =====
// // //   debugPrint('→ POST $url');
// // //   debugPrint('→ payload: $payload');
// // //   debugPrint('→ status: ${res.statusCode}');
// // //   debugPrint('→ response: ${res.body}');

// // //   final body = jsonDecode(res.body);
// // //   if (res.statusCode == 200 && body['success'] == true) {
// // //     return ScheduleResponse.fromJson(body);
// // //   } else {
// // //     // نرمي الاستثناء مع كامل response body
// // //     throw Exception(
// // //       'Error ${res.statusCode}: ${body['msg'] ?? res.body}'
// // //     );
// // //   }
// // // }
// // // }
// // Future<ScheduleResponse> submitSchedule({
// //   required String token,
// //   required ScheduleRequest request,
// // }) async {
// //   final url = Uri.parse('$baseUrl/submit');
// //   final payload = jsonEncode(request.toJson());
// //   final res = await http.post(
// //     url,
// //     headers: {
// //       'Authorization': 'Bearer $token',
// //       'Content-Type': 'application/json',
// //     },
// //     body: payload,
// //   );

// //   // طبع للتصحيح
// //   debugPrint('→ POST $url');
// //   debugPrint('→ payload: $payload');
// //   debugPrint('→ status: ${res.statusCode}');
// //   debugPrint('→ raw response: ${res.body}');

// //   // نجرب نفكّ الـ JSON بحذر
// //   Map<String, dynamic> body;
// //   try {
// //     body = jsonDecode(res.body) as Map<String, dynamic>;
// //   } catch (e) {
// //     // هذا معناها السيرفر رجّع نص مش JSON صالح
// //     debugPrint('‼️ JSON decode error: $e');
// //     throw Exception(
// //       'Invalid response from server (not JSON)\n\n${res.body}'
// //     );
// //   }

// //   // لو السيرفر رجّع success==true نتابع، وإلّا نرمي الخطأ اللي رجع
// //   if (res.statusCode == 200 && body['success'] == true) {
// //     return ScheduleResponse.fromJson(body);
// //   } else {
// //     final msg = body['msg'] ?? body.toString();
// //     throw Exception('Server error ${res.statusCode}: $msg');
// //   }
// // }
// // }

// // features/study_schedule/data/data_sources/study_schedule_api.dart


// import 'dart:convert';

// import 'package:flutter/foundation.dart';
// import 'package:flutter_application_5/features/study_schedule/data/models/schedule_request.dart';
// import 'package:flutter_application_5/features/study_schedule/data/models/schedule_response.dart';
// import 'package:http/http.dart' as http;


// class StudyScheduleApi {
//   final String baseUrl = 'http://10.0.2.2:8000/api/study-schedule';

//   Future<ScheduleResponse> submitSchedule({
//     required String token,
//     required ScheduleRequest request,
//   }) async {
//     final url     = Uri.parse('$baseUrl/submit');
//     final payload = jsonEncode(request.toJson());
//     final res = await http.post(
//       url,
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type' : 'application/json',
//       },
//       body: payload,
//     );

//     if (kDebugMode) {
//       debugPrint('→ POST $url');
//       debugPrint('→ payload: $payload');
//       debugPrint('→ status: ${res.statusCode}');
//       debugPrint('→ response: ${res.body}');
//     }

//     final body = jsonDecode(res.body) as Map<String, dynamic>;
//     if (res.statusCode == 200 && body['success'] == true) {
//       return ScheduleResponse.fromJson(body);
//     } else {
//       throw Exception('Error ${res.statusCode}: ${body['msg'] ?? res.body}');
//     }
//   }

//   fetchQuestions(String token) {}
// }
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