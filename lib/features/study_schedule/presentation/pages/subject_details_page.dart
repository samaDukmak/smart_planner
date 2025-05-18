// features/study_schedule/presentation/pages/subject_details_page.dart
// // // import 'package:flutter/material.dart';
// // // import '../../data/models/subject_model.dart';

// // // class SubjectDetailsPage extends StatefulWidget {
// // //   const SubjectDetailsPage({Key? key}) : super(key: key);

// // //   @override
// // //   State<SubjectDetailsPage> createState() => _SubjectDetailsPageState();
// // // }

// // // class _SubjectDetailsPageState extends State<SubjectDetailsPage> {
// // //   late final int _total;
// // //   final List<SubjectModel> _subjects = [];
// // //   final _nameCtrl = TextEditingController();
// // //   double _difficulty = 0;
// // //   double _understanding = 0;
// // //   int _index = 0;

// // //   @override
// // //   void didChangeDependencies() {
// // //     super.didChangeDependencies();
// // //     _total = ModalRoute.of(context)!.settings.arguments as int;
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _nameCtrl.dispose();
// // //     super.dispose();
// // //   }

// // //   void _saveAndNext() {
// // //     _subjects.add(SubjectModel(
// // //       name: _nameCtrl.text.trim(),
// // //       difficulty: _difficulty,
// // //       understanding: _understanding,
// // //     ));
// // //     if (_index + 1 < _total) {
// // //       setState(() {
// // //         _index++;
// // //         _nameCtrl.clear();
// // //         _difficulty = 0;
// // //         _understanding = 0;
// // //       });
// // //     } else {
// // //       Navigator.pop(context, _subjects);
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext ctx) {
// // //     return Scaffold(
// // //       appBar: AppBar(title: Text('Subject ${_index+1} of $_total')),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(16),
// // //         child: Column(
// // //           children: [
// // //             TextField(
// // //               controller: _nameCtrl,
// // //               decoration: const InputDecoration(labelText: 'Subject name'),
// // //             ),
// // //             const SizedBox(height: 16),
// // //             Text('Difficulty: ${_difficulty.round()}'),
// // //             Slider(
// // //               value: _difficulty,
// // //               min: 0, max: 100,
// // //               onChanged: (v) => setState(() => _difficulty = v),
// // //             ),
// // //             const SizedBox(height: 16),
// // //             Text('Understanding: ${_understanding.round()}'),
// // //             Slider(
// // //               value: _understanding,
// // //               min: 0, max: 100,
// // //               onChanged: (v) => setState(() => _understanding = v),
// // //             ),
// // //             const SizedBox(height: 24),
// // //             ElevatedButton(
// // //               onPressed: _nameCtrl.text.trim().isEmpty ? null : _saveAndNext,
// // //               child: Text(_index+1 < _total ? 'Next' : 'Done'),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'package:flutter/material.dart';
// // import '../../data/models/subject_model.dart';

// // class SubjectDetailsPage extends StatefulWidget {
// //   const SubjectDetailsPage({Key? key}) : super(key: key);

// //   @override
// //   State<SubjectDetailsPage> createState() => _SubjectDetailsPageState();
// // }

// // class _SubjectDetailsPageState extends State<SubjectDetailsPage> {
// //   late final int _total;
// //   final List<SubjectModel> _subjects = [];
// //   final _nameCtrl = TextEditingController();
// //   double _difficulty = 0;
// //   double _understanding = 0;
// //   int _index = 0;

// //   @override
// //   void didChangeDependencies() {
// //     super.didChangeDependencies();
// //     // the number of subjects is passed via RouteSettings.arguments
// //     _total = ModalRoute.of(context)!.settings.arguments as int;
// //   }

// //   @override
// //   void dispose() {
// //     _nameCtrl.dispose();
// //     super.dispose();
// //   }

// //   void _saveAndNext() {
// //     // add the current subject
// //     _subjects.add(SubjectModel(
// //       name: _nameCtrl.text.trim(),
// //       difficulty: _difficulty,
// //       understanding: _understanding,
// //     ));

// //     if (_index + 1 < _total) {
// //       // prepare for next subject
// //       setState(() {
// //         _index++;
// //         _nameCtrl.clear();
// //         _difficulty = 0;
// //         _understanding = 0;
// //       });
// //     } else {
// //       // done: pop back with the full list
// //       Navigator.pop(context, _subjects);
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext ctx) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Subject ${_index + 1} of $_total'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16),
// //         child: Column(
// //           children: [
// //             TextField(
// //               controller: _nameCtrl,
// //               decoration: const InputDecoration(
// //                 labelText: 'Subject name',
// //               ),
// //             ),
// //             const SizedBox(height: 24),

// //             Text('Difficulty: ${_difficulty.round()}'),
// //             Slider(
// //               value: _difficulty,
// //               min: 0,
// //               max: 100,
// //               divisions: 100, // ensure integer steps
// //               label: _difficulty.round().toString(),
// //               onChanged: (v) => setState(() => _difficulty = v),
// //             ),
// //             const SizedBox(height: 24),

// //             Text('Understanding: ${_understanding.round()}'),
// //             Slider(
// //               value: _understanding,
// //               min: 0,
// //               max: 100,
// //               divisions: 100, // ensure integer steps
// //               label: _understanding.round().toString(),
// //               onChanged: (v) => setState(() => _understanding = v),
// //             ),
// //             const SizedBox(height: 32),

// //             ElevatedButton(
// //               onPressed: _nameCtrl.text.trim().isEmpty ? null : _saveAndNext,
// //               child: Text(
// //                 _index + 1 < _total ? 'Next' : 'Done',
// //                 style: const TextStyle(fontSize: 16),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import '../../data/models/subject_model.dart';

// class SubjectDetailsPage extends StatefulWidget {
//   const SubjectDetailsPage({Key? key}) : super(key: key);

//   @override
//   State<SubjectDetailsPage> createState() => _SubjectDetailsPageState();
// }

// class _SubjectDetailsPageState extends State<SubjectDetailsPage> {
//   late final int _total;
//   final List<SubjectModel> _subs = [];
//   final _name = TextEditingController();
//   double _diff = 0, _under = 0;
//   int _idx = 0;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _total = ModalRoute.of(context)!.settings.arguments as int;
//   }

//   @override
//   void dispose() {
//     _name.dispose();
//     super.dispose();
//   }

//   void _saveNext() {
//     _subs.add(SubjectModel(
//       name: _name.text.trim(),
//       difficulty: _diff,
//       understanding: _under,
//     ));
//     if (_idx + 1 < _total) {
//       setState(() {
//         _idx++;
//         _name.clear();
//         _diff = 0;
//         _under = 0;
//       });
//     } else {
//       Navigator.pop(context, _subs);
//     }
//   }

//   @override
//   Widget build(BuildContext ctx) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Subject ${_idx+1} of $_total')),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(children: [
//           TextField(
//             controller: _name,
//             decoration: const InputDecoration(labelText: 'Subject name'),
//           ),
//           const SizedBox(height: 24),
//           Text('Difficulty: ${_diff.round()}'),
//           Slider(
//             value: _diff,
//             min: 0, max: 100,
//             divisions: 100,
//             label: _diff.round().toString(),
//             onChanged: (v) => setState(() => _diff = v),
//           ),
//           const SizedBox(height: 24),
//           Text('Understanding: ${_under.round()}'),
//           Slider(
//             value: _under,
//             min: 0, max: 100,
//             divisions: 100,
//             label: _under.round().toString(),
//             onChanged: (v) => setState(() => _under = v),
//           ),
//           const SizedBox(height: 32),
//           ElevatedButton(
//             onPressed: _name.text.trim().isEmpty ? null : _saveNext,
//             child: Text(_idx + 1 < _total ? 'Next' : 'Done'),
//           ),
//         ]),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../data/models/subject_model.dart';

class SubjectDetailsPage extends StatefulWidget {
  const SubjectDetailsPage({Key? key}) : super(key: key);

  @override
  State<SubjectDetailsPage> createState() => _SubjectDetailsPageState();
}

class _SubjectDetailsPageState extends State<SubjectDetailsPage> {
  late final int _total;
  final List<SubjectModel> _subs = [];
  final _nameCtrl = TextEditingController();
  double _difficulty = 0, _understanding = 0;
  int _index = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _total = ModalRoute.of(context)!.settings.arguments as int;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  void _saveAndNext() {
    _subs.add(SubjectModel(
      name: _nameCtrl.text.trim(),
      difficulty: _difficulty,
      understanding: _understanding,
    ));
    if (_index + 1 < _total) {
      setState(() {
        _index++;
        _nameCtrl.clear();
        _difficulty = 0;
        _understanding = 0;
      });
    } else {
      Navigator.pop(context, _subs);
    }
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(title: Text('Subject ${_index + 1} of $_total')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Subject name'),
            ),
            const SizedBox(height: 24),
            Text('Difficulty: ${_difficulty.round()}'),
            Slider(
              value: _difficulty,
              min: 0,
              max: 100,
              divisions: 100,
              label: _difficulty.round().toString(),
              onChanged: (v) => setState(() => _difficulty = v),
            ),
            const SizedBox(height: 24),
            Text('Understanding: ${_understanding.round()}'),
            Slider(
              value: _understanding,
              min: 0,
              max: 100,
              divisions: 100,
              label: _understanding.round().toString(),
              onChanged: (v) => setState(() => _understanding = v),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed:
                  _nameCtrl.text.trim().isEmpty ? null : _saveAndNext,
              child: Text(
                  _index + 1 < _total ? 'Next' : 'Done'),
            ),
          ],
        ),
      ),
    );
  }
}
