import 'package:flutter/material.dart';

abstract class AppConstants {
  static const List<Locale> supportedLocales = [Locale(en), Locale(ar)];
  static const String secureStorage = 'secureStorge';
  static const String isGuest= "isGuest";
  static const String en = 'en';
  static const String ar = 'ar';
  static const String assetsPath = 'assets/translations';
}
