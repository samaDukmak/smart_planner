// features/study_schedule/presentation/pages/questions_page.dart
// // // // import 'package:flutter/material.dart';
// // // // import 'package:flutter_application_5/features/study_schedule/presentation/pages/subject_details_page.dart';
// // // // import 'package:flutter_bloc/flutter_bloc.dart';
// // // // import '../../data/models/schedule_request.dart';
// // // // import '../../data/models/subject_model.dart';
// // // // import '../cubit/study_schedule_cubit.dart';
// // // // import '../cubit/study_schedule_state.dart';

// // // // class QuestionsPage extends StatefulWidget {
// // // //   const QuestionsPage({Key? key}) : super(key: key);

// // // //   @override
// // // //   State<QuestionsPage> createState() => _QuestionsPageState();
// // // // }

// // // // class _QuestionsPageState extends State<QuestionsPage> {
// // // //   final Map<String, dynamic> _answers = {};
// // // //   final Map<String, TextEditingController> _textCtrls = {};
// // // //   List<SubjectModel> _subjects = [];

// // // //   @override
// // // //   void dispose() {
// // // //     _textCtrls.values.forEach((c) => c.dispose());
// // // //     super.dispose();
// // // //   }

// // // //   bool get _canSubmit {
// // // //     final keys = ['stress','sleephours','extracurricular','subjects_count','exam_soon'];
// // // //     if (!keys.every((k) => _answers.containsKey(k))) return false;
// // // //     final count = int.tryParse(_answers['subjects_count'] ?? '') ?? 0;
// // // //     return _subjects.length == count;
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext ctx) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(title: const Text('Plan Your Day')),
// // // //       body: BlocConsumer<StudyScheduleCubit, StudyScheduleState>(
// // // //         listener: (ctx, state) {
// // // //           if (state is SSSubmissionSuccess) {
// // // //             Navigator.pushReplacementNamed(
// // // //               ctx,
// // // //               '/result',
// // // //               arguments: state.response.schedule,
// // // //             );
// // // //           } else if (state is SSError) {
// // // //             ScaffoldMessenger.of(ctx)
// // // //                 .showSnackBar(SnackBar(content: Text(state.message)));
// // // //           }
// // // //         },
// // // //         builder: (ctx, state) {
// // // //           if (state is SSLoading) {
// // // //             return const Center(child: CircularProgressIndicator());
// // // //           }
// // // //           if (state is SSQuestionsLoaded) {
// // // //             return ListView(
// // // //               padding: const EdgeInsets.all(16),
// // // //               children: [
// // // //                 for (var q in state.questions) ..._buildField(q, ctx),
// // // //                 const SizedBox(height: 24),
// // // //                 ElevatedButton(
// // // //                   onPressed: _canSubmit
// // // //                       ? () {
// // // //                           final req = ScheduleRequest(
// // // //                             stress: _answers['stress'],
// // // //                             sleephours: _answers['sleephours'],
// // // //                             extracurricular: _answers['extracurricular'],
// // // //                             subjectsCount: _answers['subjects_count'],
// // // //                             examSoon: _answers['exam_soon'],
// // // //                             subjects: _subjects,
// // // //                           );
// // // //                           ctx.read<StudyScheduleCubit>().sendAnswers(req);
// // // //                         }
// // // //                       : null,
// // // //                   child: const Text('Submit'),
// // // //                 ),
// // // //               ],
// // // //             );
// // // //           }
// // // //           if (state is SSError) {
// // // //             return Center(child: Text(state.message));
// // // //           }
// // // //           return const SizedBox();
// // // //         },
// // // //       ),
// // // //     );
// // // //   }

// // // //   List<Widget> _buildField(q, BuildContext ctx) {
// // // //     final key = q.key as String;
// // // //     final text = q.text as String;
// // // //     switch (key) {
// // // //       case 'stress':
// // // //         return [
// // // //           Text(text, style: Theme.of(ctx).textTheme.titleMedium),
// // // //           ...['low', 'moderate', 'high'].map((lvl) => RadioListTile<String>(
// // // //                 title: Text(lvl[0].toUpperCase()+lvl.substring(1)),
// // // //                 value: lvl,
// // // //                 groupValue: _answers[key],
// // // //                 onChanged: (v) => setState(() => _answers[key] = v),
// // // //               )),
// // // //         ];

// // // //       case 'sleephours':
// // // //       case 'extracurricular':
// // // //       case 'subjects_count':
// // // //         final ctrl = _textCtrls.putIfAbsent(key, () => TextEditingController());
// // // //         return [
// // // //           TextField(
// // // //             controller: ctrl,
// // // //             decoration: InputDecoration(labelText: text),
// // // //             keyboardType: TextInputType.number,
// // // //             onChanged: (v) => _answers[key] = v,
// // // //           ),
// // // //           const SizedBox(height: 12),
// // // //         ];

// // // //       case 'exam_soon':
// // // //         return [
// // // //           SwitchListTile(
// // // //             title: Text(text),
// // // //             value: _answers[key] == 'yes',
// // // //             onChanged: (v) => setState(() => _answers[key] = v ? 'yes' : 'no'),
// // // //           ),
// // // //           const SizedBox(height: 12),
// // // //         ];

// // // //       case 'subjects':
// // // //         final count = int.tryParse(_answers['subjects_count'] ?? '0') ?? 0;
// // // //         return [
// // // //           ElevatedButton(
// // // //             onPressed: count > 0
// // // //                 // ? () async {
// // // //                 //     final result = await Navigator.pushNamed<List<SubjectModel>>(
// // // //                 //       ctx, '/details',
// // // //                 //       arguments: count,
// // // //                 //     );
// // // //                 //     if (result != null) setState(() => _subjects = result);
// // // //                 //   }
// // // //                 // : null,
// // // //                 ?() async {
// // // //           final result = await Navigator.push<List<SubjectModel>>(
// // // //             ctx,
// // // //             MaterialPageRoute<List<SubjectModel>>(
// // // //               builder: (_) => const SubjectDetailsPage(),
// // // //               settings: RouteSettings(arguments: count),
// // // //             ),
// // // //           );
// // // //           if (result != null) {
// // // //             setState(() => _subjects = result);
// // // //           }
// // // //         }
// // // //         : null,
// // // //             child: Text(_subjects.isEmpty
// // // //                 ? 'Enter $count subject${count==1?'':'s'}'
// // // //                 : 'Subjects (${_subjects.length}/$count) ✓'),
// // // //           ),
// // // //           const SizedBox(height: 12),
// // // //         ];

// // // //       default:
// // // //         return [];
// // // //     }
// // // //   }
// // // // }
// // // import 'dart:convert';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_bloc/flutter_bloc.dart';
// // // import '../../data/models/schedule_request.dart';
// // // import '../../data/models/subject_model.dart';
// // // import '../cubit/study_schedule_cubit.dart';
// // // import '../cubit/study_schedule_state.dart';

// // // class QuestionsPage extends StatefulWidget {
// // //   const QuestionsPage({Key? key}) : super(key: key);

// // //   @override
// // //   State<QuestionsPage> createState() => _QuestionsPageState();
// // // }

// // // class _QuestionsPageState extends State<QuestionsPage> {
// // //   final Map<String, dynamic> _answers = {};
// // //   final Map<String, TextEditingController> _controllers = {};
// // //   List<SubjectModel> _subjects = [];

// // //   @override
// // //   void dispose() {
// // //     for (var ctr in _controllers.values) {
// // //       ctr.dispose();
// // //     }
// // //     super.dispose();
// // //   }

// // //   bool get _canSubmit {
// // //     const keys = [
// // //       'stress',
// // //       'sleephours',
// // //       'extracurricular',
// // //       'subjects_count',
// // //       'exam_soon',
// // //     ];
// // //     if (!keys.every((k) => _answers.containsKey(k))) return false;
// // //     final count = int.tryParse(_answers['subjects_count'] ?? '') ?? 0;
// // //     return _subjects.length == count;
// // //   }

// // //   void _onSubmit() {
// // //     final req = ScheduleRequest(
// // //       stress: _answers['stress'] as String,
// // //       extracurricular: _answers['extracurricular'] as String,
// // //       sleephours: _answers['sleephours'] as String,
// // //       subjectsCount: _answers['subjects_count'] as String,
// // //       examSoon: _answers['exam_soon'] as String,
// // //       subjects: _subjects,
// // //     );
// // //     // Debug print payload
// // //     debugPrint(JsonEncoder.withIndent('  ').convert(req.toJson()));
// // //     context.read<StudyScheduleCubit>().sendAnswers(req);
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(title: const Text('Plan Your Day')),
// // //       body: BlocConsumer<StudyScheduleCubit, StudyScheduleState>(
// // //         listener: (context, state) {
// // //           if (state is SSSubmissionSuccess) {
// // //             Navigator.pushReplacementNamed(
// // //               context,
// // //               '/result',
// // //               arguments: state.response.schedule,
// // //             );
// // //           } else if (state is SSError) {
// // //             ScaffoldMessenger.of(context)
// // //                 .showSnackBar(SnackBar(content: Text(state.message)));
// // //           }
// // //         },
// // //         builder: (context, state) {
// // //           if (state is SSLoading) {
// // //             return const Center(child: CircularProgressIndicator());
// // //           }
// // //           if (state is SSQuestionsLoaded) {
// // //             return ListView(
// // //               padding: const EdgeInsets.all(16),
// // //               children: [
// // //                 for (var q in state.questions) ..._buildField(q, context),
// // //                 const SizedBox(height: 24),
// // //                 ElevatedButton(
// // //                   onPressed: _canSubmit ? _onSubmit : null,
// // //                   child: const Text('Submit'),
// // //                 ),
// // //               ],
// // //             );
// // //           }
// // //           if (state is SSError) {
// // //             return Center(child: Text(state.message));
// // //           }
// // //           return const SizedBox();
// // //         },
// // //       ),
// // //     );
// // //   }

// // //   List<Widget> _buildField(
// // //       dynamic q, // Question entity has key & text
// // //       BuildContext context,
// // //   ) {
// // //     final key = q.key as String;
// // //     final text = q.text as String;
// // //     switch (key) {
// // //       case 'stress':
// // //         return [
// // //           Text(text, style: Theme.of(context).textTheme.titleMedium),
// // //           ...['low', 'moderate', 'high'].map(
// // //             (lvl) => RadioListTile<String>(
// // //               title: Text(lvl[0].toUpperCase() + lvl.substring(1)),
// // //               value: lvl,
// // //               groupValue: _answers[key],
// // //               onChanged: (v) => setState(() => _answers[key] = v),
// // //             ),
// // //           ),
// // //         ];

// // //       case 'sleephours':
// // //       case 'extracurricular':
// // //       case 'subjects_count':
// // //         final ctr = _controllers.putIfAbsent(
// // //           key,
// // //           () => TextEditingController(),
// // //         );
// // //         return [
// // //           TextField(
// // //             controller: ctr,
// // //             decoration: InputDecoration(labelText: text),
// // //             keyboardType: TextInputType.number,
// // //             onChanged: (v) => _answers[key] = v,
// // //           ),
// // //           const SizedBox(height: 12),
// // //         ];

// // //       case 'exam_soon':
// // //         return [
// // //           SwitchListTile(
// // //             title: Text(text),
// // //             value: _answers[key] == 'yes',
// // //             onChanged: (v) => setState(() => _answers[key] = v ? 'yes' : 'no'),
// // //           ),
// // //           const SizedBox(height: 12),
// // //         ];

// // //       case 'subjects':
// // //         final count = int.tryParse(_answers['subjects_count'] ?? '0') ?? 0;
// // //         return [
// // //           ElevatedButton(
// // //             onPressed: count > 0
// // //                 ? () async {
// // //                     final result = await Navigator.pushNamed<
// // //                         List<SubjectModel>>(context, '/details',
// // //                       arguments: count,
// // //                     );
// // //                     if (result != null) {
// // //                       setState(() => _subjects = result);
// // //                     }
// // //                   }
// // //                 : null,
// // //             child: Text(
// // //               _subjects.isEmpty
// // //                   ? 'Enter $count subject${count == 1 ? '' : 's'}'
// // //                   : 'Subjects (${_subjects.length}/$count) ✓',
// // //             ),
// // //           ),
// // //           const SizedBox(height: 12),
// // //         ];

// // //       default:
// // //         return [];
// // //     }
// // //   }
// // // }
// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import '../../data/models/schedule_request.dart';
// // import '../../data/models/subject_model.dart';
// // import '../cubit/study_schedule_cubit.dart';
// // import '../cubit/study_schedule_state.dart';

// // class QuestionsPage extends StatefulWidget {
// //   const QuestionsPage({Key? key}) : super(key: key);

// //   @override
// //   State<QuestionsPage> createState() => _QuestionsPageState();
// // }

// // class _QuestionsPageState extends State<QuestionsPage> {
// //   final Map<String, dynamic> _answers = {};
// //   final Map<String, TextEditingController> _controllers = {};
// //   List<SubjectModel> _subjects = [];

// //   @override
// //   void dispose() {
// //     for (var ctr in _controllers.values) {
// //       ctr.dispose();
// //     }
// //     super.dispose();
// //   }

// //   bool get _canSubmit {
// //     const keys = [
// //       'stress',
// //       'sleephours',
// //       'extracurricular',
// //       'subjects_count',
// //       'exam_soon',
// //     ];
// //     if (!keys.every((k) => _answers.containsKey(k))) return false;
// //     final count = int.tryParse(_answers['subjects_count'] ?? '') ?? 0;
// //     return _subjects.length == count;
// //   }

// //   void _onSubmit() {
// //     final req = ScheduleRequest(
// //       stress: _answers['stress'] as String,
// //       extracurricular: _answers['extracurricular'] as String,
// //       sleephours: _answers['sleephours'] as String,
// //       subjectsCount: _answers['subjects_count'] as String,
// //       examSoon: _answers['exam_soon'] as String,
// //       subjects: _subjects,
// //     );
// //     debugPrint(JsonEncoder.withIndent('  ').convert(req.toJson()));
// //     context.read<StudyScheduleCubit>().sendAnswers(req);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Plan Your Day')),
// //       body: BlocConsumer<StudyScheduleCubit, StudyScheduleState>(
// //         listener: (context, state) {
// //           if (state is SSSubmissionSuccess) {
// //             Navigator.pushReplacementNamed(
// //               context,
// //               '/result',
// //               arguments: state.response.schedule,
// //             );
// //           } else if (state is SSError) {
// //             ScaffoldMessenger.of(context)
// //                 .showSnackBar(SnackBar(content: Text(state.message)));
// //           }
// //         },
// //         builder: (context, state) {
// //           if (state is SSLoading) {
// //             return const Center(child: CircularProgressIndicator());
// //           }
// //           if (state is SSQuestionsLoaded) {
// //             return ListView(
// //               padding: const EdgeInsets.all(16),
// //               children: [
// //                 for (var q in state.questions) ..._buildField(q, context),
// //                 const SizedBox(height: 24),
// //                 ElevatedButton(
// //                   onPressed: _canSubmit ? _onSubmit : null,
// //                   child: const Text('Submit'),
// //                 ),
// //               ],
// //             );
// //           }
// //           if (state is SSError) {
// //             return Center(child: Text(state.message));
// //           }
// //           return const SizedBox();
// //         },
// //       ),
// //     );
// //   }

// //   List<Widget> _buildField(dynamic q, BuildContext context) {
// //     final key = q.key as String;
// //     final text = q.text as String;
// //     switch (key) {
// //       case 'stress':
// //         return [
// //           Text(text, style: Theme.of(context).textTheme.titleMedium),
// //           ...['low', 'moderate', 'high'].map(
// //             (lvl) => RadioListTile<String>(
// //               title: Text(lvl[0].toUpperCase() + lvl.substring(1)),
// //               value: lvl,
// //               groupValue: _answers[key],
// //               onChanged: (v) => setState(() => _answers[key] = v),
// //             ),
// //           ),
// //         ];
// //       case 'sleephours':
// //       case 'extracurricular':
// //       case 'subjects_count':
// //         final ctr = _controllers.putIfAbsent(
// //           key,
// //           () => TextEditingController(),
// //         );
// //         return [
// //           TextField(
// //             controller: ctr,
// //             decoration: InputDecoration(labelText: text),
// //             keyboardType: TextInputType.number,
// //             onChanged: (v) => _answers[key] = v,
// //           ),
// //           const SizedBox(height: 12),
// //         ];
// //       case 'exam_soon':
// //         return [
// //           SwitchListTile(
// //             title: Text(text),
// //             value: _answers[key] == 'yes',
// //             onChanged: (v) => setState(() => _answers[key] = v ? 'yes' : 'no'),
// //           ),
// //           const SizedBox(height: 12),
// //         ];
// //       case 'subjects':
// //         final count = int.tryParse(_answers['subjects_count'] ?? '0') ?? 0;
// //         return [
// //           ElevatedButton(
// //             onPressed: count > 0
// //                 ? () async {
// //                     final result = await Navigator.pushNamed<
// //                         List<SubjectModel>>(context, '/details',
// //                       arguments: count,
// //                     );
// //                     if (result != null) {
// //                       setState(() => _subjects = result);
// //                     }
// //                   }
// //                 : null,
// //             child: Text(
// //               _subjects.isEmpty
// //                   ? 'Enter $count subject${count == 1 ? '' : 's'}'
// //                   : 'Subjects (${_subjects.length}/$count) ✓',
// //             ),
// //           ),
// //           const SizedBox(height: 12),
// //         ];
// //       default:
// //         return [];
// //     }
// //   }
// // }
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_5/features/study_schedule/presentation/pages/subject_details_page.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../data/models/schedule_request.dart';
// import '../../data/models/subject_model.dart';
// import '../cubit/study_schedule_cubit.dart';
// import '../cubit/study_schedule_state.dart';

// class QuestionsPage extends StatefulWidget {
//   const QuestionsPage({Key? key}) : super(key: key);

//   @override
//   State<QuestionsPage> createState() => _QuestionsPageState();
// }

// class _QuestionsPageState extends State<QuestionsPage> {
//   final Map<String, dynamic> _answers = {};
//   final Map<String, TextEditingController> _controllers = {};
//   List<SubjectModel> _subjects = [];

//   @override
//   void dispose() {
//     for (var ctr in _controllers.values) {
//       ctr.dispose();
//     }
//     super.dispose();
//   }

//   bool get _canSubmit {
//     const keys = [
//       'stress',
//       'sleephours',
//       'extracurricular',
//       'subjects_count',
//       'exam_soon',
//     ];
//     if (!keys.every((k) => _answers.containsKey(k))) return false;
//     final count = int.tryParse(_answers['subjects_count'] ?? '0') ?? 0;
//     return _subjects.length == count;
//   }

//   void _onSubmit() {
//     final req = ScheduleRequest(
//       stress: _answers['stress'] as String,
//       extracurricular: _answers['extracurricular'] as String,
//       sleephours: _answers['sleephours'] as String,
//       subjectsCount: _answers['subjects_count'] as String,
//       examSoon: _answers['exam_soon'] as String,
//       subjects: _subjects,
//     );
//     debugPrint(JsonEncoder.withIndent('  ').convert(req.toJson()));
//     context.read<StudyScheduleCubit>().sendAnswers(req);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Plan Your Day')),
//       body: BlocConsumer<StudyScheduleCubit, StudyScheduleState>(
//         listener: (context, state) {
//           if (state is SSSubmissionSuccess) {
//             Navigator.pushReplacementNamed(
//               context,
//               '/result',
//               arguments: state.response.schedule,
//             );
//           } else if (state is SSError) {
//             ScaffoldMessenger.of(context)
//                 .showSnackBar(SnackBar(content: Text(state.message)));
//           }
//         },
//         builder: (context, state) {
//           if (state is SSLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (state is SSQuestionsLoaded) {
//             return ListView(
//               padding: const EdgeInsets.all(16),
//               children: [
//                 for (var q in state.questions) ..._buildField(q, context),
//                 const SizedBox(height: 24),
//                 ElevatedButton(
//                   onPressed: _canSubmit ? _onSubmit : null,
//                   child: const Text('Submit'),
//                 ),
//               ],
//             );
//           }
//           if (state is SSError) {
//             return Center(child: Text(state.message));
//           }
//           return const SizedBox();
//         },
//       ),
//     );
//   }

//   List<Widget> _buildField(dynamic q, BuildContext context) {
//     final key = q.key as String;
//     final text = q.text as String;
//     switch (key) {
//       case 'stress':
//         return [
//           Text(text, style: Theme.of(context).textTheme.titleMedium),
//           ...['low', 'moderate', 'high'].map(
//             (lvl) => RadioListTile<String>(
//               title: Text(lvl[0].toUpperCase() + lvl.substring(1)),
//               value: lvl,
//               groupValue: _answers[key],
//               onChanged: (v) => setState(() => _answers[key] = v),
//             ),
//           ),
//         ];
//       case 'sleephours':
//       case 'extracurricular':
//       case 'subjects_count':
//         final ctr = _controllers.putIfAbsent(
//           key,
//           () => TextEditingController(),
//         );
//         return [
//           TextField(
//             controller: ctr,
//             decoration: InputDecoration(labelText: text),
//             keyboardType: TextInputType.number,
//             onChanged: (v) => _answers[key] = v,
//           ),
//           const SizedBox(height: 12),
//         ];
//       case 'exam_soon':
//         return [
//           SwitchListTile(
//             title: Text(text),
//             value: _answers[key] == 'yes',
//             onChanged: (v) => setState(() => _answers[key] = v ? 'yes' : 'no'),
//           ),
//           const SizedBox(height: 12),
//         ];
//       case 'subjects':
//         final count = int.tryParse(_answers['subjects_count'] ?? '0') ?? 0;
//         return [
//           ElevatedButton(
//             onPressed: count > 0
//               ? () async {
//                   final result = await Navigator.push<List<SubjectModel>>(  
//                     context,
//                     MaterialPageRoute<List<SubjectModel>>(
//                       builder: (_) => const SubjectDetailsPage(),
//                       settings: RouteSettings(arguments: count),
//                     ),
//                   );
//                   if (result != null) setState(() => _subjects = result);
//                 }
//               : null,
//             child: Text(
//               _subjects.isEmpty
//                 ? 'Enter $count subject${count == 1 ? '' : 's'}'
//                 : 'Subjects (${_subjects.length}/$count) ✓',
//             ),
//           ),
//           const SizedBox(height: 12),
//         ];
//       default:
//         return [];
//     }
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/schedule_request.dart';
import '../../data/models/subject_model.dart';
import '../cubit/study_schedule_cubit.dart';
import '../cubit/study_schedule_state.dart';
import 'subject_details_page.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({Key? key}) : super(key: key);

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  final Map<String, dynamic> _answers = {};
  final Map<String, TextEditingController> _controllers = {};
  List<SubjectModel> _subjects = [];

  @override
  void dispose() {
    _controllers.values.forEach((c) => c.dispose());
    super.dispose();
  }

  bool get _canSubmit {
    const keys = [
      'stress',
      'sleephours',
      'extracurricular',
      'subjects_count',
      'exam_soon',
    ];
    if (!keys.every((k) => _answers.containsKey(k))) return false;
    final count = int.tryParse(_answers['subjects_count'] ?? '') ?? 0;
    return _subjects.length == count;
  }

  void _onSubmit() {
    final req = ScheduleRequest(
      stress: _answers['stress'] as String,
      extracurricular: _answers['extracurricular'] as String,
      sleephours: _answers['sleephours'] as String,
      subjectsCount: _answers['subjects_count'] as String,
      examSoon: _answers['exam_soon'] as String,
      subjects: _subjects,
    );

    // —————————————————————————————
    // تأكد من الـ payload في الكونسول:
    debugPrint(const JsonEncoder.withIndent('  ').convert(req.toJson()));
    // مثال مطبوع:
    // {
    //   "stress": "moderate",
    //   "extracurricular": "2",
    //   "sleephours": "6",
    //   "subjects_count": "3",
    //   "exam_soon": "yes",
    //   "subjects": [
    //     { "name": "Math", "difficulty": 75, "understanding": 60 },
    //     …
    //   ]
    // }
    // —————————————————————————————

    context.read<StudyScheduleCubit>().sendAnswers(req);
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plan Your Day')),
      body: BlocConsumer<StudyScheduleCubit, StudyScheduleState>(
        listener: (ctx, state) {
          if (state is SSSubmissionSuccess) {
            Navigator.pushReplacementNamed(
              ctx,
              '/result',
              arguments: state.response.schedule,
            );
          } else if (state is SSError) {
            ScaffoldMessenger.of(ctx)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (ctx, state) {
          if (state is SSLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SSQuestionsLoaded) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                for (var q in state.questions) ..._buildField(q, ctx),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _canSubmit ? _onSubmit : null,
                    child: const Text('Submit'),
                  ),
                ),
              ],
            );
          }
          if (state is SSError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }

  List<Widget> _buildField(dynamic q, BuildContext ctx) {
    final key = q.key as String;
    final text = q.text as String;
    switch (key) {
      case 'stress':
        return [
          Text(text, style: Theme.of(ctx).textTheme.titleMedium),
          ...['low', 'moderate', 'high'].map(
            (lvl) => RadioListTile<String>(
              title: Text(lvl[0].toUpperCase() + lvl.substring(1)),
              value: lvl,
              groupValue: _answers[key],
              onChanged: (v) => setState(() => _answers[key] = v),
            ),
          ),
        ];
      case 'sleephours':
      case 'extracurricular':
      case 'subjects_count':
        final ctr = _controllers.putIfAbsent(
          key,
          () => TextEditingController(),
        );
        return [
          TextField(
            controller: ctr,
            decoration: InputDecoration(labelText: text),
            keyboardType: TextInputType.number,
            onChanged: (v) => _answers[key] = v,
          ),
          const SizedBox(height: 12),
        ];
      case 'exam_soon':
        return [
          SwitchListTile(
            title: Text(text),
            value: _answers[key] == 'yes',
            onChanged: (v) => setState(() => _answers[key] = v ? 'yes' : 'no'),
          ),
          const SizedBox(height: 12),
        ];
      case 'subjects':
        final count = int.tryParse(_answers['subjects_count'] ?? '0') ?? 0;
        return [
          ElevatedButton(
            onPressed: count > 0
                ? () async {
                    final result =
                        await Navigator.push<List<SubjectModel>>(
                      ctx,
                      MaterialPageRoute<List<SubjectModel>>(
                        builder: (_) => const SubjectDetailsPage(),
                        settings: RouteSettings(arguments: count),
                      ),
                    );
                    if (result != null) {
                      setState(() => _subjects = result);
                    }
                  }
                : null,
            child: Text(
              _subjects.isEmpty
                  ? 'Enter $count subject${count == 1 ? '' : 's'}'
                  : 'Subjects (${_subjects.length}/$count) ✓',
            ),
          ),
          const SizedBox(height: 12),
        ];
      default:
        return [];
    }
  }
}
