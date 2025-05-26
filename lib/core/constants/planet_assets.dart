// core/constants/planet_assets.dart
// class PlanetAssets {
//   static const lightBlue     = 'assets/Lightblue.webp';
//   static const turquoise     = 'assets/Turquoise_plant.webp';
//   static const orange        = 'assets/orange_plant.webp';
//   static const purpleStar    = 'assets/purple_star.webp';
//   static const blue          = 'assets/blue.webp';
// static const wave         = 'assets/wave.svg';
//  static const plants = 'assets/plants.webp';

// }
// lib/core/constants/planet_assets.dart

class PlanetAssets {

  static const lightBlue     = 'assets/Lightblue.webp';
  static const turquoise     = 'assets/Turquoise_plant.webp';
  static const orange        = 'assets/orange_plant.webp';
  static const purpleStar    = 'assets/purple_star.webp';
  static const blue          = 'assets/blue.webp';
static const wave         = 'assets/wave.svg';
 static const plants = 'assets/plants.webp';



  /// خريطة تربط المفتاح (اسم الكوكب بصيغة lowercase_underscore) بمسار الصورة
  // static const Map<String, String> _map = {
  //   'blue'             : 'assets/blue.webp',
  //   'orange_plant'     : 'assets/orange_plant.webp',
  //   'light_blue'       : 'assets/light_blue.webp',
  //   'purple_star'      : 'assets/purple_star.webp',
  //   'turquoise'        : 'assets/turquoise_plant.webp',
  //   'purple_plant'     : 'assets/purple_plant.webp',
  // };

  // /// يُرجع مسار الصورة بناءً على اسم الكوكب الوارد من السيرفر
  // static String assetForName(String planetName) {
  //   final key = planetName.toLowerCase().replaceAll(' ', '_');
  //   return _map[key] ?? _map.values.first;
  // }
  // lib/core/constants/planet_assets.dart


  /// خريطة اسم الكوكب كما هو وارد من السيرفر → مسار ملف الأصول
  static const Map<String, String> _map = {
    'blue'           : 'assets/blue.webp',
    'orange plant'   : 'assets/orange_plant.webp',
    'light blue'     : 'assets/light_blue.webp',
    'turquoise'      : 'assets/turquoise_plant.webp',
    // إذا أضفت كواكب ثانية من الباك، ضيف هنا اسمها المفتاح والمسار المناسب
  };

  /// يأخذ الاسم تماماً كما جالك من الباك (case-insensitive)
  /// ويرجّع مسار الأصول، أو default إذا ما وجد
  static String assetForName(String planetName) {
    final key = planetName.toLowerCase();
    return _map[key] ?? 'assets/blue.webp';
  }
}


