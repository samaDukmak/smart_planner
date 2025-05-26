// features/study_schedule/presentation/pages/completion_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_5/core/constants/planet_assets.dart';
import 'package:flutter_application_5/core/widgets/custom_shapes/star_background.dart';

class CompletionPage extends StatelessWidget {
  final String planetName;
  final bool   hasStar; // راح نبقيها لو احتجتها لاحقاً

  const CompletionPage({
    Key? key,
    required this.planetName,
    required this.hasStar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final asset = PlanetAssets.assetForName(planetName);

    return Scaffold(
      // نجمة الخلفية كاملة
      body: Stack(
        children: [
          const Positioned.fill(
            child: RandomStarBackground(starCount: 80, color: Colors.white54),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Well Done!',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'You completed this session!',
                  style: TextStyle(
                    fontSize:  16, 
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 24),

                // صورة الكوكب
                Image.asset(
                  asset,
                  width: 160,
                  height: 160,
                  fit: BoxFit.contain,
                  errorBuilder: (_,__,___) =>
                      const Icon(Icons.public, size: 160, color: Colors.white24),
                ),

                const SizedBox(height: 16),
                const Text(
                  'Great job!',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 32),
                // زر Take Quiz
                SizedBox(
                  width: 180,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Navigate to quiz page
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7C90F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Take Quiz',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 12),
                // زر Cancel
                SizedBox(
                  width: 180,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF7C90F6)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Cancel',
                        style: TextStyle(fontSize: 16, color: Color(0xFF7C90F6))),
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

