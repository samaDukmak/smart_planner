// features/study_schedule/presentation/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_5/core/constants/planet_assets.dart';
import 'package:flutter_application_5/core/models/PlanetConfig.dart';
import 'package:flutter_application_5/core/widgets/curved_white_panel.dart';
import 'package:flutter_application_5/core/widgets/custom_shapes/star_background.dart';
import 'package:flutter_application_5/core/widgets/planetwidget.dart';
import 'package:flutter_application_5/features/study_schedule/data/models/task_model.dart';
import 'package:flutter_application_5/features/study_schedule/data/data_sources/tasks_api.dart';
import 'package:flutter_application_5/features/study_schedule/domain/repositories/tasks_repository_impl.dart';
import 'package:flutter_application_5/features/study_schedule/presentation/cubit/tasks_cubit.dart';
import 'package:flutter_application_5/features/study_schedule/presentation/cubit/tasks_state.dart';
import 'package:flutter_application_5/features/study_schedule/presentation/pages/start_page.dart';
import 'package:flutter_application_5/features/study_schedule/presentation/pages/timer_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TasksCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = TasksCubit(TasksRepositoryImpl(TasksApi()));
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    _cubit.loadTasks(token);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final planets = [
      PlanetConfig(
          assetPath: PlanetAssets.lightBlue,
          leftPct: 0.00,
          topPct: 0.05,
          width: 60,
          height: 250),
      PlanetConfig(
          assetPath: PlanetAssets.purpleStar,
          leftPct: 0.19,
          topPct: 0.02,
          width: 60,
          height: 300),
      PlanetConfig(
          assetPath: PlanetAssets.orange,
          leftPct: 0.37,
          topPct: 0.05,
          width: 80,
          height: 250),
      PlanetConfig(
          assetPath: PlanetAssets.lightBlue,
          leftPct: 0.60,
          topPct: 0.03,
          width: 60,
          height: 290),
      PlanetConfig(
          assetPath: PlanetAssets.turquoise,
          leftPct: 0.80,
          topPct: 0.05,
          width: 70,
          height: 250),
    ];

    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          if (state is TasksLoading) {
            return const Scaffold(
              backgroundColor: Colors.black,
              body:
                  Center(child: CircularProgressIndicator(color: Colors.white)),
            );
          } else if (state is TasksEmpty) {
            return const StartPage();
          } else if (state is TasksError) {
            return Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: Text(state.message,
                    style: const TextStyle(color: Colors.redAccent)),
              ),
            );
          } else if (state is TasksLoaded) {
            final tasks = state.tasks;
            return Scaffold(
              backgroundColor: Colors.black,
              body: Stack(
                children: [
                  // starry background
                  const Positioned.fill(
                    child: RandomStarBackground(
                        starCount: 60, color: Colors.white24),
                  ),

                  // planets
                  for (var cfg in planets)
                    PlanetWidget(config: cfg, parentSize: size),

                  // curved white panel
                  CurvedWhitePanel(
                    heightFactor: 0.6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 24),
                      child: Column(
                        children: [
                          const Text(
                            'Your Achievement Galaxy',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Each planet = one goal competed',
                            style:
                                TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                          const SizedBox(height: 18),
                          Expanded(
                            child: ListView.builder(
                              itemCount: tasks.length,
                              itemBuilder: (_, i) =>
                                  _TaskCard(task: tasks[i]),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: 220,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () => Navigator.pushNamed(
                                  context, '/view-progress'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF7C90F6),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              child: const Text('View Progress',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  final TaskModel task;
  const _TaskCard({required this.task, Key? key}) : super(key: key);

  String _formatDuration(int totalMinutes) {
    final d = Duration(minutes: totalMinutes);
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    // حالات الزر
    final isDone    = task.status == 'completed';
    final isGiveUp  = task.status == 'give_up';
    final locked    = isDone || isGiveUp;

    // نصّ الزر
    final btnText = isDone
        ? 'Done'
        : isGiveUp
            ? 'Give up'
            : 'Start';

    // لون الزر
    final btnColor = isDone
        ? const Color(0xFF4CD6C0) // أخضر للـ Done
        : isGiveUp
            ? Colors.redAccent
            : const Color(0xFF9F91EF);

    // لون البطاقة
    final cardColor =
        isGiveUp ? const Color(0xFFFFF3F3) : const Color(0xFFF4F2FF);

    final displayMinutes =
        task.remainingMinutes ?? task.subject.time;
    final durationStr    =
        _formatDuration(displayMinutes);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: cardColor,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        title: Text(
          task.subject.name,
          style: const TextStyle(
              fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        subtitle: Text(
          '$durationStr\n${task.status}',
          style: const TextStyle(height: 1.5, color: Colors.black54),
        ),

        trailing: ElevatedButton(
          onPressed: locked
              ? null
              : () async {
                  final prefs =
                      await SharedPreferences.getInstance();
                  final token = prefs.getString('token') ?? '';
                  final cubit = context.read<TasksCubit>();
                  // إذا الحالة pending —> start أولاً
                  if (task.status == 'pending') {
                    final ok =
                        await cubit.startTask(task.id, token);
                    if (!ok || !context.mounted) return;
                  }
                  // بعد start نفتح المؤقت
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: cubit,
                        child: TimerPage(
                          totalMinutes: displayMinutes,
                          taskId: task.id,
                        ),
                      ),
                    ),
                  );
                  // بعد الرجوع —> reload
                  if (context.mounted) {
                    final tok = (await SharedPreferences
                            .getInstance())
                        .getString('token')!;
                    cubit.loadTasks(tok);
                  }
                },
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(btnColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
          ),
          child:
              Text(btnText, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
