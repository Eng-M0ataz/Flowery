import 'package:flower_e_commerce_app/Feature/about-app/domain/entities/about_app_style_entity.dart';

class AboutAppEntity {
  final String section;
  final String? title;
  final List<String> content;
  final AboutAppTextStyleEntity titleStyle;
  final AboutAppTextStyleEntity contentStyle;

  const AboutAppEntity({
    required this.section,
    this.title,
    required this.content,
    required this.titleStyle,
    required this.contentStyle,
  });
}