// features/study_schedule/presentation/pages/timer_page.dart

import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_application_5/core/widgets/custom_shapes/star_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../cubit/tasks_cubit.dart';

class TimerPage extends StatefulWidget {
  final int totalMinutes;
  final int taskId;
  const TimerPage({Key? key, required this.totalMinutes, required this.taskId})
      : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late Duration _remaining;
  Timer? _ticker;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _remaining = Duration(minutes: widget.totalMinutes);
    _startCountdown();
  }

  void _startCountdown() {
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) async {
      if (_remaining.inSeconds == 0) {
        _ticker?.cancel();
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token') ?? '';
        final giftMap = await context.read<TasksCubit>()
                              .completeTask(widget.taskId, token);
        if (giftMap != null && mounted) {
          final planetName = (giftMap['planet'] as Map<String, dynamic>)['name'] as String;
          final hasStar    = giftMap['has_star'] as bool;
          Navigator.of(context).pushReplacementNamed(
            '/completion',
            arguments: {
              'planetName': planetName,
              'hasStar'   : hasStar,
            },
          );
        }
      } else {
        setState(() => _remaining -= const Duration(seconds: 1));
      }
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  String _fmt(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60).toString().padLeft(2,'0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2,'0');
    return h > 0 ? '$h:$m:$s' : '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final totalSecs = widget.totalMinutes * 60;
    final progress  = _remaining.inSeconds / totalSecs.clamp(1, double.infinity);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const Positioned.fill(child: RandomStarBackground(starCount: 80)),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _PlanetWithRing(progress),
                const SizedBox(height: 40),
                Text(_fmt(_remaining),
                    style: const TextStyle(fontSize: 48, color: Colors.white)),
                const SizedBox(height: 40),
                _buildControls(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls() => SizedBox(
        width: 160,
        child: Column(
          children: [
            OutlinedButton(
              onPressed: _handleGiveUp,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white),
                foregroundColor: Colors.white,
              ),
              child: const Text('Give up'),
            ),
            const SizedBox(height: 40),
            OutlinedButton(
              onPressed: _handlePauseResume,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white),
                foregroundColor: Colors.white,
              ),
              child: Text(_isPaused ? 'Resume' : 'Pause'),
            ),
          ],
        ),
      );

  Future<void> _handlePauseResume() async {
    if (_isPaused) {
      _startCountdown();
      setState(() => _isPaused = false);
      return;
    }
    _ticker?.cancel();
    setState(() => _isPaused = true);
    final minsLeft = (_remaining.inSeconds / 60).ceil();
    final prefs    = await SharedPreferences.getInstance();
    final token    = prefs.getString('token') ?? '';
    await context.read<TasksCubit>().pauseTask(widget.taskId, minsLeft, token);
  }

  Future<void> _handleGiveUp() async {
    _ticker?.cancel();
    final minsLeft = (_remaining.inSeconds / 60).ceil();
    final prefs    = await SharedPreferences.getInstance();
    final token    = prefs.getString('token') ?? '';
    final res      = await context.read<TasksCubit>()
                           .giveUpTask(widget.taskId, minsLeft, token);
    if (res != null && mounted) Navigator.pop(context);
  }
}

class _PlanetWithRing extends StatelessWidget {
  final double progress;
  const _PlanetWithRing(this.progress);

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 260,
        height: 260,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(size: const Size(220, 220), painter: _Ring(progress)),
            Image.asset('assets/purple_star.webp', width: 160),
          ],
        ),
      );
}

class _Ring extends CustomPainter {
  final double p;
  _Ring(this.p);

  @override
  void paint(Canvas c, Size s) {
    final center = Offset(s.width / 2, s.height / 2);
    final r      = s.width / 2 - 4;
    const stroke = 10.0;

    final bg = Paint()
      ..color = Colors.grey[700]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;
    c.drawCircle(center, r, bg);

    final fg = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;
    c.drawArc(Rect.fromCircle(center: center, radius: r),
        -math.pi / 2, 2 * math.pi * p, false, fg);
  }

  @override
  bool shouldRepaint(covariant _Ring old) => old.p != p;
}
