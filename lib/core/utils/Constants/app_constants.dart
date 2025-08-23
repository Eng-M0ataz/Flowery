import 'package:flutter/material.dart';

abstract class AppConstants {
  static const List<Locale> supportedLocales = [Locale(en), Locale(ar)];
  static const String secureStorage = 'secureStorage';
  static const String en = 'en';
  static const String ar = 'ar';
  static const String assetsPath = 'assets/translations';
  static const String loading = 'loading';
  static const String error = 'error';
  static const String success = 'success';
  static const int mainDuration = 10;
  static const int resendDuration = 3;
}
