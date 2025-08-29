import 'package:flutter/material.dart';

abstract class AppConstants {
  static const List<Locale> supportedLocales = [Locale(en), Locale(ar)];
  static const String secureStorage = 'secureStorge';
  static const String isGuest= "isGuest";
  static const String inStock= "inStock";
  static const String Status= "Status";
  static const String Description= "Description";
  static const String outStock= "outStock";
  static const String addToCart= "add_to_cart";
  static const String en = 'en';
  static const String ar = 'ar';
  static const String assetsPath = 'assets/translations';
}
