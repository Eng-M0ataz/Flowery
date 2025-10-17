import 'package:flutter/material.dart';

abstract class AppConstants {
  static const List<Locale> supportedLocales = [Locale(en), Locale(ar)];

  static const String secureStorage = 'secureStorage';
  static const String en = 'en';
  static const String ar = 'ar';
  static const String assetsPath = 'assets/translations';
  static const String token = 'token';
  static const String rememberMe = 'remember_me';
  static const String gender = 'gender';
  static const String male = 'male';
  static const String female = 'female';
  static const String femaleValue = 'Female';
  static const String allId = 'all';
  static const String noProduct = 'No Product';
  static const String guest = 'guest';
  static const String isTrue = 'true';
  static const String loading = 'loading';
  static const String error = 'error';
  static const String success = 'success';
  static const int mainDuration = 10;
  static const int resendDuration = 3;
  static const String orderSuccessImage = 'assets/images/success_logo.svg';

}
