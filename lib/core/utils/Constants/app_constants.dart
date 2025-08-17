import 'package:flutter/material.dart';

abstract class AppConstants {
  static const List<Locale> supportedLocales = [Locale(en), Locale(ar)];
  static const String secureStorge = 'secureStorge';
  static const String en = 'en';
  static const String ar = 'ar';
  static const String assetsPath = 'lib/core/translations/';
}
