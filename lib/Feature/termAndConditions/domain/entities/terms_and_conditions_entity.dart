import 'package:flower_e_commerce_app/Feature/termAndConditions/domain/entities/terms_and_conditions_style_entity.dart';

class TermsAndConditionsEntity {
  final String section;
  final String? title;
  final List<String> content;
  final TermsAndConditionsTextStyleEntity titleStyle;
  final TermsAndConditionsTextStyleEntity contentStyle;

  const TermsAndConditionsEntity({
    required this.section,
    this.title,
    required this.content,
    required this.titleStyle,
    required this.contentStyle,
  });
}