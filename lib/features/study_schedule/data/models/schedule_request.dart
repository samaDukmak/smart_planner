// features/study_schedule/data/models/schedule_request.dart
// // import 'subject_model.dart';

// // class ScheduleRequest {
// //   final String stress;
// //   final String extracurricular;
// //   final String sleephours;
// //   final String subjectsCount;
// //   final String examSoon;
// //   final List<SubjectModel> subjects;

// //   ScheduleRequest({
// //     required this.stress,
// //     required this.extracurricular,
// //     required this.sleephours,
// //     required this.subjectsCount,
// //     required this.examSoon,
// //     required this.subjects,
// //   });

// //   Map<String, dynamic> toJson() => {
// //         'stress': stress,
// //         'extracurricular': extracurricular,
// //         'sleephours': sleephours,
// //         'subjects_count': subjectsCount,
// //         'exam_soon': examSoon,
// //         'subjects': subjects.map((s) => s.toJson()).toList(),
// //       };
// // }
// // features/study_schedule/data/models/schedule_request.dart

// import 'subject_model.dart';

// class ScheduleRequest {
//   final String stress;
//   final String extracurricular;
//   final String sleephours;
//   final String subjectsCount;
//   final String examSoon;
//   final List<SubjectModel> subjects;

//   ScheduleRequest({
//     required this.stress,
//     required this.extracurricular,
//     required this.sleephours,
//     required this.subjectsCount,
//     required this.examSoon,
//     required this.subjects,
//   });

//   Map<String, dynamic> toJson() => {
//         'stress'          : stress,
//         'extracurricular' : extracurricular,
//         'sleephours'      : sleephours,
//         'subjects_count'  : subjectsCount,
//         'exam_soon'       : examSoon,
//         'subjects'        : subjects.map((s) => s.toJson()).toList(),
//       };
// }
import 'package:flutter_application_5/features/study_schedule/data/models/subject_model.dart';

class ScheduleRequest {
  final String stress;
  final String extracurricular;
  final String sleephours;
  final String subjectsCount;
  final String examSoon;
  final List<SubjectModel> subjects;

  ScheduleRequest({
    required this.stress,
    required this.extracurricular,
    required this.sleephours,
    required this.subjectsCount,
    required this.examSoon,
    required this.subjects,
  });

  Map<String, dynamic> toJson() => {
        'stress': stress,
        'extracurricular': extracurricular,
        'sleephours': sleephours,
        'subjects_count': subjectsCount,
        'exam_soon': examSoon,
        'subjects': subjects.map((s) => s.toJson()).toList(),
      };
}