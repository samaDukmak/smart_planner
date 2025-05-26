// features/study_schedule/presentation/pages/subject_details_page.dart

// }
import 'package:flutter/material.dart';
import 'package:flutter_application_5/core/constants/planet_assets.dart';
import 'package:flutter_application_5/core/models/PlanetConfig.dart';
import 'package:flutter_application_5/core/widgets/curved_white_panel.dart';
import 'package:flutter_application_5/core/widgets/custom_shapes/star_background.dart';
import 'package:flutter_application_5/core/widgets/planetwidget.dart';
import '../../data/models/subject_model.dart';


class SubjectDetailsPage extends StatefulWidget {
  const SubjectDetailsPage({Key? key}) : super(key: key);

  @override
  State<SubjectDetailsPage> createState() => _SubjectDetailsPageState();
}

class _SubjectDetailsPageState extends State<SubjectDetailsPage> {
  late int _total;
  bool _hasInit = false;               // حماية من تهيئة متكررة
  final List<SubjectModel> _subjects = [];
  final TextEditingController _nameCtrl = TextEditingController();
  double _difficulty = 0, _understanding = 0;
  int _index = 0;




  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasInit) {
      _total = ModalRoute.of(context)!.settings.arguments as int;
      _hasInit = true;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  void _saveAndNext() {
    _subjects.add(SubjectModel(
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
      Navigator.pop(context, _subjects);
    }
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
      PlanetConfig(
        assetPath: PlanetAssets.turquoise,
        leftPct: 24.0 / 393.0,
        topPct: 38.45 / 852.0,
        width: 78,
        height: 78,
      ),
      PlanetConfig(
        assetPath: PlanetAssets.orange,
        leftPct: 128.0 / 393.0,
        topPct: 173.0 / 852.0,
        width: 123,
        height: 80,
      ),
      PlanetConfig(
        assetPath: PlanetAssets.lightBlue,
        leftPct: 286.0 / 393.0,
        topPct: 173.0 / 852.0,
        width: 62,
        height: 61,
      ),
      PlanetConfig(
        assetPath: PlanetAssets.turquoise,
        leftPct: 6.0 / 393.0,
        topPct: 372.31 / 852.0,
        width: 53.19,
        height: 44.05,
      ),
      PlanetConfig(
        assetPath: PlanetAssets.purpleStar,
        leftPct: 152.0 / 393.0,
        topPct: 443.0 / 852.0,
        width: 85,
        height: 86,
      ),
      PlanetConfig(
        assetPath: PlanetAssets.purpleStar,
        leftPct: 317.0 / 393.0,
        topPct: 4.0 / 852.0,
        width: 67.2,
        height: 68,
      ),
      PlanetConfig(
        assetPath: PlanetAssets.blue,
        leftPct: 245.0 / 393.0,
        topPct: 578.0 / 852.0,
        width: 95,
        height: 96,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const Positioned.fill(
            child: RandomStarBackground(
              starCount: 60,
              color: Colors.white24,
            ),
          ),
          for (var cfg in planets)
            PlanetWidget(config: cfg, parentSize: size),
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
          CurvedWhitePanel(
            heightFactor: 0.5,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Subject ${_index + 1} of $_total',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _nameCtrl,
                    decoration: InputDecoration(
                      labelText: 'Subject Name',
                      labelStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Difficulty: ${_difficulty.round()}',
                    style: const TextStyle(color: Colors.black),
                  ),
                  Slider(
                    value: _difficulty,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: _difficulty.round().toString(),
                    onChanged: (v) => setState(() => _difficulty = v),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Understanding: ${_understanding.round()}',
                    style: const TextStyle(color: Colors.black),
                  ),
                  Slider(
                    value: _understanding,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: _understanding.round().toString(),
                    onChanged: (v) => setState(() => _understanding = v),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 231,
                        child: ElevatedButton(
                          onPressed: _nameCtrl.text.trim().isEmpty
                              ? null
                              : _saveAndNext,
                          child: Text(
                            _index + 1 < _total ? 'Next' : 'Done',
                            style: const TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:  const Color.fromARGB(
                                          255, 100, 129, 202),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
