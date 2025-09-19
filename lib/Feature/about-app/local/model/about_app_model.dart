import 'package:flutter/material.dart';

class AboutAppModel {
  final String section;
  final Map<String, dynamic> content;
  final Map<String, dynamic>? title;
  final Map<String, dynamic> style;

  AboutAppModel({
    required this.section,
    required this.content,
    this.title,
    required this.style,
  });

  factory AboutAppModel.fromJson(Map<String, dynamic> json) {
    return AboutAppModel(
      section: json['section'] as String,
      content: Map<String, dynamic>.from(json['content'] ?? {}),
      title: json['title'] != null ? Map<String, dynamic>.from(json['title']) : null,
      style: Map<String, dynamic>.from(json['style'] ?? {}),
    );
  }

  List<String> getContent(String locale) {
    final val = content[locale];
    if (val is String) return [val];
    if (val is List) return val.cast<String>();
    return [];
  }

  String? getTitle(String locale) {
    if (title == null) return null;
    return title![locale] as String?;
  }

  static Color parseColor(String? hex) =>
      Color(int.parse((hex ?? '#000000').replaceFirst('#', '0xff')));

  Map<String, dynamic> effectiveStyle({bool isTitle = false}) {
    if (style.containsKey('title') || style.containsKey('content')) {
      return Map<String, dynamic>.from(
          style[isTitle ? 'title' : 'content'] ?? {});
    }
    return style;
  }

  TextStyle textStyle(String locale, {bool isTitle = false}) {
    final s = effectiveStyle(isTitle: isTitle);
    final fontSize = (s['fontSize'] as num?)?.toDouble() ?? 16;
    final weight =
    (s['fontWeight'] == 'bold') ? FontWeight.bold : FontWeight.normal;
    final color = parseColor(s['color']);
    return TextStyle(fontSize: fontSize, fontWeight: weight, color: color);
  }

  TextAlign textAlign(String locale, {bool isTitle = false}) {
    final s = effectiveStyle(isTitle: isTitle);
    final ta = (s['textAlign']?[locale] ?? 'left').toString();
    switch (ta) {
      case 'right':
        return TextAlign.right;
      case 'center':
        return TextAlign.center;
      default:
        return TextAlign.left;
    }
  }
}
