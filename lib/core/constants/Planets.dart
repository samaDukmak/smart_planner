// core/constants/Planets.dart



import 'package:flutter_application_5/core/constants/planet_assets.dart';
import 'package:flutter_application_5/core/models/PlanetConfig.dart';

/// قائمة كواكب شاشة الـ Splash
const List<PlanetConfig> splashPlanets = [
  // Light-blue planet (يسار منتصف الشاشة)
  PlanetConfig(
    assetPath: PlanetAssets.lightBlue,
    leftPct: 0.0     / 393.0,
    topPct : 173.0   / 852.0,
    width  : 95,
    height : 96,
  ),

  // Turquoise plant (أعلى يسار)
  PlanetConfig(
    assetPath: PlanetAssets.turquoise,
    leftPct: 24.0    / 393.0,
    topPct : 38.45   / 852.0,
    width  : 78,
    height : 78,
  ),

  // Orange plant (وسط تقريباً)
  PlanetConfig(
    assetPath: PlanetAssets.orange,
    leftPct: 128.0   / 393.0,
    topPct : 173.0   / 852.0,
    width  : 123,
    height : 80,
  ),

  // Light-blue planet (أعلى يمين)
  PlanetConfig(
    assetPath: PlanetAssets.lightBlue,
    leftPct: 286.0   / 393.0,
    topPct : 173.0   / 852.0,
    width  : 62,
    height : 61,
  ),

  // Turquoise plant (أسفل يسار)
  PlanetConfig(
    assetPath: PlanetAssets.turquoise,
    leftPct: 6.0     / 393.0,
    topPct : 372.31  / 852.0,
    width  : 53.19,
    height : 44.05,
  ),

  // Purple star (وسط سفلي)
  PlanetConfig(
    assetPath: PlanetAssets.purpleStar,
    leftPct: 152.0   / 393.0,
    topPct : 443.0   / 852.0,
    width  : 85,
    height : 86,
  ),

  // Purple star (أعلى يمين حافة الشاشة)
  PlanetConfig(
    assetPath: PlanetAssets.purpleStar,
    leftPct: 317.0   / 393.0,
    topPct : 4.0     / 852.0,
    width  : 67.2,
    height : 68,
  ),

  // Blue planet (قُرب أسفل يمين)
  PlanetConfig(
    assetPath: PlanetAssets.blue,
    leftPct: 245.0   / 393.0,
    topPct : 578.0   / 852.0,
    width  : 95,
    height : 96,
  ),
  
];

/// كوكب كبير واحد (يُستخدم في صفحات Login / Sign-up)
PlanetConfig centerFlowers = PlanetConfig(
  assetPath: PlanetAssets.plants,
  leftPct: 71 / 393.0,
  topPct : 55.5 / 852.0,
  width  : 250,
  height : 280,
);
