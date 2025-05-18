// Core/widgets/custom_shapes/star_background.dart
// import 'package:flutter/material.dart';
// import 'package:smart_study_planner/Core/constants/app_colors.dart';

// class StarBackground extends StatelessWidget {
//   const StarBackground({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: _StarPainter(),
//     );
//   }
// }

// class _StarPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()..color = AppColors.white.withOpacity(0.8);
//     final stars = <Offset>[
//       const Offset(40, 90),
//       const Offset(100, 40),
//       const Offset(180, 160),
//       const Offset(260, 70),
//       const Offset(300, 140),
//       const Offset(60, 230),
//       const Offset(10, 70),
//       const Offset(30, 40),
//       const Offset(60, 10),
//       const Offset(260, 70),
//       const Offset(20, 180),
//       const Offset(280, 190),
//       const Offset(150, 30),
//       const Offset(200, 110),
//       const Offset(120, 250),
//       const Offset(240, 40),
//       const Offset(320, 180),
//       const Offset(90, 200),
//       const Offset(170, 100),
//       const Offset(220, 240),
//     ];
//     for (final star in stars) {
//       canvas.drawCircle(star, 2, paint);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }


import 'dart:math';
import 'package:flutter/material.dart';

/// يولّد [count] نقطة عشوائية ضمن حجم [size]
List<Offset> generateRandomPoints(int count, Size size) {
  final rand = Random();
  return List.generate(count, (_) {
    final dx = rand.nextDouble() * size.width;
    final dy = rand.nextDouble() * size.height;
    return Offset(dx, dy);
  });
}

/// ويدجت تحتوي الـ CustomPaint مع النجوم
class RandomStarBackground extends StatefulWidget {
  final int starCount;
  final Color color;
  const RandomStarBackground({
    Key? key,
    this.starCount = 50,
    this.color = Colors.white54,
  }) : super(key: key);

  @override
  _RandomStarBackgroundState createState() => _RandomStarBackgroundState();
}

class _RandomStarBackgroundState extends State<RandomStarBackground> {
  List<Offset>? _points;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // نولّد النقاط مرة واحدة عندما نعرف الحجم
      _points ??= generateRandomPoints(
        widget.starCount,
        Size(constraints.maxWidth, constraints.maxHeight),
      );

      return CustomPaint(
        size: Size(constraints.maxWidth, constraints.maxHeight),
        painter: _StarPainter(_points!, widget.color),
      );
    });
  }
}

class _StarPainter extends CustomPainter {
  final List<Offset> points;
  final Color color;
  _StarPainter(this.points, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    for (final p in points) {
      canvas.drawCircle(p, 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StarPainter old) {
    // لا نعيد الرسم إلا إذا تغيّرت النقاط أو اللون
    return old.points != points || old.color != color;
  }
}
