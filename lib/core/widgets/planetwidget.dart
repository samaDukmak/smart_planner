// core/widgets/planetwidget.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_5/core/models/PlanetConfig.dart';

/// Places one planet in a Stack according to its [PlanetConfig].
class PlanetWidget extends StatelessWidget {
  final PlanetConfig config;
  final Size parentSize;

  const PlanetWidget({
    Key? key,
    required this.config,
    required this.parentSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left:   config.leftPct * parentSize.width,
      top:    config.topPct  * parentSize.height,
      width:  config.width,
      height: config.height,
      child: Image.asset(
        config.assetPath,
        fit: BoxFit.contain,
      ),
    );
  }
}
