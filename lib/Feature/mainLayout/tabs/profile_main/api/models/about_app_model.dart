class AboutAppModel {
  final List<AboutAppSectionModel> aboutApp;

  const AboutAppModel({
    required this.aboutApp,
  });

  factory AboutAppModel.fromJson(Map<String, dynamic> json) {
    return AboutAppModel(
      aboutApp: (json['about_app'] as List<dynamic>)
          .map((e) => AboutAppSectionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'about_app': aboutApp.map((e) => e.toJson()).toList(),
    };
  }
}

class AboutAppSectionModel {
  final String section;
  final LocalizedTextModel? title;
  final LocalizedContentModel content;
  final SectionStyleModel style;

  const AboutAppSectionModel({
    required this.section,
    this.title,
    required this.content,
    required this.style,
  });

  factory AboutAppSectionModel.fromJson(Map<String, dynamic> json) {
    return AboutAppSectionModel(
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

class LocalizedTextModel {
  final String en;
  final String ar;

  const LocalizedTextModel({
    required this.en,
    required this.ar,
  });

  factory LocalizedTextModel.fromJson(Map<String, dynamic> json) {
    return LocalizedTextModel(
      en: json['en'] as String,
      ar: json['ar'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'en': en,
      'ar': ar,
    };
  }
}

class LocalizedContentModel {
  final List<String> en;
  final List<String> ar;

  const LocalizedContentModel({
    required this.en,
    required this.ar,
  });

  factory LocalizedContentModel.fromDynamic(dynamic json) {
    if (json is Map<String, dynamic>) {
      final enValue = json['en'];
      final arValue = json['ar'];

      return LocalizedContentModel(
        en: enValue is List
            ? enValue.map((e) => e.toString()).toList()
            : [enValue.toString()],
        ar: arValue is List
            ? arValue.map((e) => e.toString()).toList()
            : [arValue.toString()],
      );
    }
    throw ArgumentError('Invalid content json');
  }

  Map<String, dynamic> toJson() {
    return {
      'en': en,
      'ar': ar,
    };
  }
}

class SectionStyleModel {
  final TextStyleModel? title;
  final TextStyleModel content;

  const SectionStyleModel({
    this.title,
    required this.content,
  });

  factory SectionStyleModel.fromJson(Map<String, dynamic> json) {
    if (json['title'] != null && json['content'] != null) {
      return SectionStyleModel(
        title: TextStyleModel.fromJson(json['title'] as Map<String, dynamic>),
        content:
        TextStyleModel.fromJson(json['content'] as Map<String, dynamic>),
      );
    } else {
      return SectionStyleModel(
        content: TextStyleModel.fromJson(json),
      );
    }
  }

  Map<String, dynamic> toJson() {
    if (title != null) {
      return {
        'title': title!.toJson(),
        'content': content.toJson(),
      };
    }
    return content.toJson();
  }
}

class TextStyleModel {
  final double fontSize;
  final String fontWeight;
  final String color;
  final LocalizedTextAlignModel textAlign;
  final String backgroundColor;

  const TextStyleModel({
    required this.fontSize,
    required this.fontWeight,
    required this.color,
    required this.textAlign,
    required this.backgroundColor,
  });

  factory TextStyleModel.fromJson(Map<String, dynamic> json) {
    return TextStyleModel(
      fontSize: (json['fontSize'] as num).toDouble(),
      fontWeight: json['fontWeight'] as String,
      color: json['color'] as String,
      textAlign: LocalizedTextAlignModel.fromJson(
        json['textAlign'] as Map<String, dynamic>,
      ),
      backgroundColor: json['backgroundColor'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fontSize': fontSize,
      'fontWeight': fontWeight,
      'color': color,
      'textAlign': textAlign.toJson(),
      'backgroundColor': backgroundColor,
    };
  }
}

class LocalizedTextAlignModel {
  final String en;
  final String ar;

  const LocalizedTextAlignModel({
    required this.en,
    required this.ar,
  });

  factory LocalizedTextAlignModel.fromJson(Map<String, dynamic> json) {
    return LocalizedTextAlignModel(
      en: json['en'] as String,
      ar: json['ar'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'en': en,
      'ar': ar,
    };
  }
}
