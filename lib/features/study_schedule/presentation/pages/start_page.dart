// features/study_schedule/presentation/pages/start_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_5/core/constants/planet_assets.dart';
import 'package:flutter_application_5/core/models/PlanetConfig.dart';
import 'package:flutter_application_5/core/widgets/custom_shapes/star_background.dart';
import 'package:flutter_application_5/core/widgets/planetwidget.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    final size = MediaQuery.of(ctx).size;
    final bigPlanet = PlanetConfig(
      assetPath: PlanetAssets.orange,
      leftPct: 0.5,
      topPct: 0.25,
      width: 150,
      height: 150,
    );

    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: RandomStarBackground(starCount: 60, color: Colors.white24),
          ),
          PlanetWidget(config: bigPlanet, parentSize: size),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Ready to Plan Your Day?',
                  style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  "Answer a few questions and we'll build your study galaxy.",
                  style: Theme.of(ctx).textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(ctx, '/questions');
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Start', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
