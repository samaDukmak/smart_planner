// core/widgets/NoGlowScrollBehavior.dart
import 'package:flutter/widgets.dart';

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext c, Widget child, ScrollableDetails d) {
    return child; // يلغّي الـ glow عند السحب
  }
}
