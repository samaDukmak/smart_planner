// features/study_schedule/presentation/pages/result_page.dart
// // import 'package:flutter/material.dart';

// // class ResultPage extends StatelessWidget {
// //   const ResultPage({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext ctx) {
// //     final schedule =
// //         ModalRoute.of(ctx)!.settings.arguments as List<Map<String, dynamic>>;

// //     final columns = schedule.isNotEmpty
// //         ? schedule.first.keys.toList()
// //         : <String>[];

// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Your Schedule')),
// //       body: schedule.isEmpty
// //           ? const Center(child: Text('No schedule returned.'))
// //           : SingleChildScrollView(
// //               padding: const EdgeInsets.all(16),
// //               child: DataTable(
// //                 columns: columns
// //                     .map((c) => DataColumn(label: Text(c.toUpperCase())))
// //                     .toList(),
// //                 rows: schedule
// //                     .map((row) => DataRow(
// //                           cells: columns
// //                               .map((c) => DataCell(Text(row[c].toString())))
// //                               .toList(),
// //                         ))
// //                     .toList(),
// //               ),
// //             ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';

// class ResultPage extends StatelessWidget {
//   const ResultPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext ctx) {
//     final schedule =
//         ModalRoute.of(ctx)!.settings.arguments as List<dynamic>;
//     final rows = schedule.cast<Map<String, dynamic>>();

//     return Scaffold(
//       appBar: AppBar(title: const Text('Your Schedule')),
//       body: rows.isEmpty
//           ? const Center(child: Text('No schedule returned.'))
//           : SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: DataTable(
//                 columns: const [
//                   DataColumn(label: Text('Name')),
//                   DataColumn(label: Text('Time')), 
//                 ],
//                 rows: rows
//                     .map(
//                       (r) => DataRow(cells: [
//                         DataCell(Text(r['name'].toString())),
//                         DataCell(Text(r['time'].toString())),
//                       ]),
//                     )
//                     .toList(),
//               ),
//             ),
//     );
//   }
// }
// features/study_schedule/presentation/pages/result_page.dart

import 'package:flutter/material.dart';
import '../../data/models/schedule_response.dart'; // تأكد من استيراد هذا

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    // هنا نستعيد قائمة ScheduleEntry مباشرة
    final entries = ModalRoute.of(ctx)!.settings.arguments 
      as List<ScheduleEntry>;

    return Scaffold(
      appBar: AppBar(title: const Text('Your Schedule')),
      body: entries.isEmpty
          ? const Center(child: Text('No schedule returned.'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Time (min)')),
                ],
                rows: entries.map((e) {
                  return DataRow(cells: [
                    DataCell(Text(e.name)),
                    DataCell(Text(e.time.toString())),
                  ]);
                }).toList(),
              ),
            ),
    );
  }
}
