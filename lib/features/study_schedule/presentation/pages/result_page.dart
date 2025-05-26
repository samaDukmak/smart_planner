// features/study_schedule/presentation/pages/result_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_5/core/constants/planet_assets.dart';
import 'package:flutter_application_5/core/models/PlanetConfig.dart';
import 'package:flutter_application_5/core/widgets/curved_white_panel.dart';
import 'package:flutter_application_5/core/widgets/custom_shapes/star_background.dart';
import 'package:flutter_application_5/core/widgets/planetwidget.dart';
import 'package:flutter_application_5/features/study_schedule/data/models/schedule_response.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final entries = ModalRoute.of(context)!.settings.arguments as List<ScheduleEntry>;
     final size = MediaQuery.of(context).size;
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
            child: RandomStarBackground(starCount: 60, color: Colors.white24),
          ),
           for (var cfg in planets)
            PlanetWidget(config: cfg, parentSize: size),
          CurvedWhitePanel(
            heightFactor: 0.5,
           // radius: 24,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Here's your study plan for today:",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: entries.length,
                      itemBuilder: (_, i) {
                        final e = entries[i];
                        return Card(
                          color: const Color.fromARGB(255, 211, 205, 205),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            title: Text(e.name, style: const TextStyle(color: Colors.black)),
                            trailing: Text('${e.time} min', style: const TextStyle(color: Colors.black)),
                          ),
                        );
                      },
                    ),
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        
                        width: 231,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                          },
                          child: const Text('Confirm', style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(
                                          255, 100, 129, 202),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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