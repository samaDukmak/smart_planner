// core/widgets/curved_white_panel.dart
// // import 'package:flutter/material.dart';

// // class CurvedWhitePanel extends StatelessWidget {
// //   final Widget child;
// //   const CurvedWhitePanel({required this.child, Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext ctx) {
// //     final height = MediaQuery.of(ctx).size.height * 0.6;
// //     return Align(
// //       alignment: Alignment.bottomCenter,
// //       child: Container(
// //         height: height,
// //         width: double.infinity,
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
// //         ),
// //         child: Padding(
// //           padding: const EdgeInsets.all(16),
// //           child: child,
// //         ),
// //       ),
// //     );
// //   }
// // }
// // lib/widgets/curved_white_panel.dart
// import 'package:flutter/material.dart';

// /// بانلٍ أبيضٍ منحنيٍ من الأعلى يغطي نسبة من ارتفاع الشاشة
// class CurvedWhitePanel extends StatelessWidget {
//   final Widget child;
//   /// النسبة من ارتفاع الشاشة (0.0–1.0)
//   final double heightFactor;
//   const CurvedWhitePanel({
//     required this.child,
//     this.heightFactor = 0.5,  // بدل 0.6 خليه 0.5
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext ctx) {
//     final height = MediaQuery.of(ctx).size.height * heightFactor;
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Container(
//         height: height,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: child,
//         ),
//       ),
//     );
//   }
// }
 import 'package:flutter/material.dart';

class CurvedWhitePanel extends StatelessWidget {
  final Widget child;
  final double heightFactor;
  const CurvedWhitePanel({
    required this.child,
    this.heightFactor = 0.55,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    final h = MediaQuery.of(ctx).size.height * heightFactor;
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: h,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          child: Container(
            color: Colors.white,
            child: child,
          ),
        ),
      ),
    );
  }
}
