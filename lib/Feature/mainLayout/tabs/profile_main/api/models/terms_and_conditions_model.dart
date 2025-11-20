import 'about_app_model.dart';

class TermsAndConditionsModel {
  final List<TermsSectionModel> termsAndConditions;

  const TermsAndConditionsModel({
    required this.termsAndConditions,
  });

  factory TermsAndConditionsModel.fromJson(Map<String, dynamic> json) {
    return TermsAndConditionsModel(
      termsAndConditions: (json['terms_and_conditions'] as List<dynamic>)
          .map(
            (e) => TermsSectionModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'terms_and_conditions':
          termsAndConditions.map((e) => e.toJson()).toList(),
    };
  }
}

class TermsSectionModel {
  final String section;
  final LocalizedTextModel? title;
  final LocalizedContentModel content;
  final SectionStyleModel style;

  const TermsSectionModel({
    required this.section,
    this.title,
    required this.content,
    required this.style,
  });

  factory TermsSectionModel.fromJson(Map<String, dynamic> json) {
    return TermsSectionModel(
      section: json['section'] as String,
      title: json['title'] != null
          ? LocalizedTextModel.fromJson(json['title'] as Map<String, dynamic>)
          : null,
      content: LocalizedContentModel.fromDynamic(json['content']),
      style: SectionStyleModel.fromJson(json['style'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'section': section,
      if (title != null) 'title': title!.toJson(),
      'content': content.toJson(),
      'style': style.toJson(),
    };
  }
}
