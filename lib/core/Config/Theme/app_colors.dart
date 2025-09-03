import 'package:flutter/material.dart';

abstract class AppColorsLight {
  static const Color red = Color(0xffCC1010);
  static const Color lightPink = Color(0xffF9ECF0);
  static const Color gray = Color(0xff535353);
  static const Color green = Color(0xff0CB359);
  static const Color white_70 = Color(0xFFa6a6a6);
  static const Color shimmerColor = Color(0xffebebf4);
  static const Color whiteColor=Color(0xFFFFFFFF);

  static const MaterialColor pink = MaterialColor(0xFFD21E6A, <int, Color>{
    0: Color(0xFFD21E6A),
    10: Color(0xFFf6d2e1),
    20: Color(0xFFf0b4cd),
    30: Color(0xFFe98fb5),
    40: Color(0xFFe1699c),
    50: Color(0xFFda4483),
    60: Color(0xFFaf1958),
    70: Color(0xFF8c1447),
    80: Color(0xFF690f35),
    90: Color(0xFF460a23),
    100: Color(0xFF2a0615),
  });
  static const MaterialColor black = MaterialColor(0xFF0c1015, <int, Color>{
    0: Color(0xFF0c1015), // base color
    10: Color(0xFFcecfd0),
    20: Color(0xFFaeafb1),
    30: Color(0xFF86888a),
    40: Color(0xFF5d6063),
    50: Color(0xFF34383c),
    60: Color(0xFF0a0d12),
    70: Color(0xFF080b0e),
    80: Color(0xFF06080b),
    90: Color(0xFF040507),
    100: Color(0xFF020304),
  });
  static const MaterialColor white = MaterialColor(0xFFf9f9f9, <int, Color>{
    0: Color(0xFFf9f9f9), // base color
    10: Color(0xFFfefefe),
    20: Color(0xFFfdfdfd),
    30: Color(0xFFfcfcfc),
    40: Color(0xFFfbfbfb),
    50: Color(0xFFfafafa),
    60: Color(0xFFd0d0d0),
    70: Color(0xFFa6a6a6),
    80: Color(0xFF7d7d7d),
    90: Color(0xFF535353),
    100: Color(0xFF323232),
  });
}
