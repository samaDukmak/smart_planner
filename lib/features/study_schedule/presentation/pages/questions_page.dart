// features/study_schedule/presentation/pages/questions_page.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_5/core/constants/planet_assets.dart';
import 'package:flutter_application_5/core/models/PlanetConfig.dart';
import 'package:flutter_application_5/core/widgets/planetwidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_5/core/widgets/curved_white_panel.dart';
import 'package:flutter_application_5/core/widgets/custom_shapes/star_background.dart';
import 'package:flutter_application_5/features/study_schedule/data/models/schedule_request.dart';
import 'package:flutter_application_5/features/study_schedule/data/models/subject_model.dart';
import 'package:flutter_application_5/features/study_schedule/presentation/cubit/study_schedule_cubit.dart';
import 'package:flutter_application_5/features/study_schedule/presentation/cubit/study_schedule_state.dart';
import 'subject_details_page.dart'; // إضافة import

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({Key? key}) : super(key: key);

  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  final Map<String, dynamic> _answers = {};
  final Map<String, TextEditingController> _controllers = {};
  List<SubjectModel> _subjects = [];

  bool get _canSubmit {
    const keys = [
      'stress',
      'sleephours',
      'extracurricular',
      'subjects_count',
      'exam_soon'
    ];
    if (!keys.every((k) => _answers.containsKey(k))) return false;
    final count = int.tryParse(_answers['subjects_count'] ?? '') ?? 0;
    return _subjects.length == count;
  }

  void _onSubmit() {
    final req = ScheduleRequest(
      stress: _answers['stress'],
      extracurricular: _answers['extracurricular'],
      sleephours: _answers['sleephours'],
      subjectsCount: _answers['subjects_count'],
      examSoon: _answers['exam_soon'],
      subjects: _subjects,
    );
    debugPrint(const JsonEncoder.withIndent('  ').convert(req.toJson()));
    context.read<StudyScheduleCubit>().sendAnswers(req);
  }

  @override
  void dispose() {
    _controllers.values.forEach((c) => c.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    final size = MediaQuery.of(ctx).size;
    final planets = [
      PlanetConfig(
        assetPath: PlanetAssets.lightBlue,
        leftPct: 0.0 / 393.0,
        topPct: 173.0 / 852.0,
        width: 95,
        height: 96,
      ),

      // Turquoise plant (أعلى يسار)
      PlanetConfig(
        assetPath: PlanetAssets.turquoise,
        leftPct: 24.0 / 393.0,
        topPct: 38.45 / 852.0,
        width: 78,
        height: 78,
      ),

      // Orange plant (وسط تقريباً)
      PlanetConfig(
        assetPath: PlanetAssets.orange,
        leftPct: 128.0 / 393.0,
        topPct: 173.0 / 852.0,
        width: 123,
        height: 80,
      ),

      // Light-blue planet (أعلى يمين)
      PlanetConfig(
        assetPath: PlanetAssets.lightBlue,
        leftPct: 286.0 / 393.0,
        topPct: 173.0 / 852.0,
        width: 62,
        height: 61,
      ),

      // Turquoise plant (أسفل يسار)
      PlanetConfig(
        assetPath: PlanetAssets.turquoise,
        leftPct: 6.0 / 393.0,
        topPct: 372.31 / 852.0,
        width: 53.19,
        height: 44.05,
      ),

      // Purple star (وسط سفلي)
      PlanetConfig(
        assetPath: PlanetAssets.purpleStar,
        leftPct: 152.0 / 393.0,
        topPct: 443.0 / 852.0,
        width: 85,
        height: 86,
      ),

      // Purple star (أعلى يمين حافة الشاشة)
      PlanetConfig(
        assetPath: PlanetAssets.purpleStar,
        leftPct: 317.0 / 393.0,
        topPct: 4.0 / 852.0,
        width: 67.2,
        height: 68,
      ),

      // Blue planet (قُرب أسفل يمين)
      PlanetConfig(
        assetPath: PlanetAssets.blue,
        leftPct: 245.0 / 393.0,
        topPct: 578.0 / 852.0,
        width: 95,
        height: 96,
      ),
    ];

    /// كوكب كبير واحد (يُستخدم في صفحات Login / Sign-up)

    return Scaffold(
      backgroundColor: Theme.of(ctx).scaffoldBackgroundColor,
      body: Stack(
        children: [
          const Positioned.fill(
            child: RandomStarBackground(starCount: 60, color: Colors.white24),
          ),
          for (var cfg in planets) PlanetWidget(config: cfg, parentSize: size),
          Positioned(
            top: 320,
            left: 0,
            right: 0,
            child: Text(
              "Answer a few questions to get started",
              style: const TextStyle(
                  color: Color.fromARGB(255, 253, 251, 251), fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          CurvedWhitePanel(
            heightFactor: 0.5,
            child: BlocConsumer<StudyScheduleCubit, StudyScheduleState>(
              listener: (context, state) {
                if (state is SSSubmissionSuccess) {
                  Navigator.pushReplacementNamed(
                    context,
                    '/result',
                    arguments: state.response.schedule,
                  );
                } else if (state is SSError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                if (state is SSLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is SSQuestionsLoaded) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: ListView(
                      children: [
                        // Text(
                        //   "Answer a few questions to get started",
                        //   style: const TextStyle(
                        //       color: Colors.black, fontSize: 18),
                        //   textAlign: TextAlign.center,
                        // ),
                        // const SizedBox(height: 16),
                        // stress
                        Text(
                          state.questions
                              .firstWhere((q) => q.key == 'stress')
                              .text,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ...['low', 'moderate', 'high'].map(
                          (lvl) => RadioListTile<String>(
                            title: Text(lvl,
                                style: const TextStyle(color: Colors.black)),
                            value: lvl,
                            groupValue: _answers['stress'],
                            onChanged: (v) =>
                                setState(() => _answers['stress'] = v),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // number fields
                        ...['extracurricular', 'sleephours', 'subjects_count']
                            .map((k) {
                          final q =
                              state.questions.firstWhere((q) => q.key == k);
                          final ctr = _controllers.putIfAbsent(
                              k, () => TextEditingController());
                          return Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: TextField(
                              controller: ctr,
                              decoration: InputDecoration(
                                labelText: q.text,
                                labelStyle: const TextStyle(
                                    color: Colors.black, fontSize: 13),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              keyboardType: TextInputType.number,
                              style: const TextStyle(color: Colors.black),
                              onChanged: (v) => _answers[k] = v,
                            ),
                          );
                        }),
                        const SizedBox(height: 16),
                        // exam soon
                        SwitchListTile(
                          title: Text(
                            state.questions
                                .firstWhere((q) => q.key == 'exam_soon')
                                .text,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14),
                          ),
                          value: _answers['exam_soon'] == 'yes',
                          onChanged: (v) => setState(
                              () => _answers['exam_soon'] = v ? 'yes' : 'no'),
                        ),
                        const SizedBox(height: 12),
                        // subjects button
                        Builder(
                          builder: (c) {
                            final count = int.tryParse(
                                    _answers['subjects_count'] ?? '') ??
                                0;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 231,
                                  child: ElevatedButton(
                                    onPressed: count > 0
                                        ? () async {
                                            final result = await Navigator.push<
                                                List<SubjectModel>>(
                                              c,
                                              MaterialPageRoute<
                                                  List<SubjectModel>>(
                                                builder: (_) =>
                                                    const SubjectDetailsPage(),
                                                settings: RouteSettings(
                                                    arguments: count),
                                              ),
                                            );
                                            if (result != null)
                                              setState(
                                                  () => _subjects = result);
                                          }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 100, 129, 202),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                    ),
                                    child: Text(
                                      _subjects.isEmpty
                                          ? 'Enter $count subject${count == 1 ? '' : 's'}'
                                          : 'Subjects (${_subjects.length}/$count) ✓',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 231,
                              child: ElevatedButton(
                                onPressed: _canSubmit ? _onSubmit : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 100, 129, 202),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                ),
                                child: const Text('Submit',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
