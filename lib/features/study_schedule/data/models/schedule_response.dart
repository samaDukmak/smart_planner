// features/study_schedule/data/models/schedule_response.dart
// // class ScheduleResponse {
// //   final List<Map<String, dynamic>> schedule;

// //   ScheduleResponse({required this.schedule});

// //   factory ScheduleResponse.fromJson(dynamic data) {
// //     if (data is List) {
// //       return ScheduleResponse(
// //         schedule: List<Map<String, dynamic>>.from(data),
// //       );
// //     } else if (data is Map<String, dynamic> && data['schedule'] is List) {
// //       return ScheduleResponse(
// //         schedule: List<Map<String, dynamic>>.from(data['schedule']),
// //       );
// //     }
// //     throw Exception('Invalid schedule response format');
// //   }
// // }
// class ScheduleResponse {
//   /// قائمة العناصر كما يرسلها الباك-إند تحت مفتاح "schedule"
//   final List<ScheduleEntry> schedule;

//   ScheduleResponse({required this.schedule});

//   factory ScheduleResponse.fromJson(Map<String, dynamic> json) {
//     final raw = json['schedule'];
//     if (raw is List) {
//       return ScheduleResponse(
//         schedule: raw
//             .map((e) => ScheduleEntry.fromJson(e as Map<String, dynamic>))
//             .toList(),
//       );
//     }
//     throw Exception('Invalid schedule format');
//   }
// }

// class ScheduleEntry {
//   final String name;
//   final int time;

//   ScheduleEntry({
//     required this.name,
//     required this.time,
//   });

//   factory ScheduleEntry.fromJson(Map<String, dynamic> json) {
//     return ScheduleEntry(
//       name: json['name'] as String,
//       time: (json['time'] as num).toInt(),
//     );
//   }
// }
class ScheduleResponse {
  final List<ScheduleEntry> schedule;
  ScheduleResponse({required this.schedule});

  factory ScheduleResponse.fromJson(Map<String, dynamic> json) {
    return ScheduleResponse(
      schedule: (json['schedule'] as List)
          .map((e) => ScheduleEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ScheduleEntry {
  final String name;
  final int time;
  ScheduleEntry({required this.name, required this.time});

  factory ScheduleEntry.fromJson(Map<String, dynamic> json) =>
      ScheduleEntry(
        name: json['name'] as String,
        time: (json['time'] as num).toInt(),
      );
}