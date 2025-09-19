import 'package:flower_e_commerce_app/Feature/termAndConditions/domain/entities/terms_and_conditions_entity.dart';
import 'package:flower_e_commerce_app/Feature/termAndConditions/domain/entities/terms_and_conditions_style_entity.dart';
import 'package:flower_e_commerce_app/Feature/termAndConditions/local/model/terms_and_conditions_model.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsMapper {
  static TermsAndConditionsEntity toEntity(
      TermsAndConditionsModel model,
      String locale,
      ) {
    TermsAndConditionsTextStyleEntity parseStyle(Map<String, dynamic> styleMap) {
      double fs = (styleMap['fontSize'] as num?)?.toDouble() ?? 16;
      FontWeight fw = (styleMap['fontWeight'] == 'bold')
          ? FontWeight.bold
          : FontWeight.normal;
      Color color = _hexToColor(styleMap['color']);
      Color bg = _hexToColor(styleMap['backgroundColor']);
      final alignKey = styleMap['textAlign']?[locale] ?? 'left';
      TextAlign ta = _textAlignFromString(alignKey);
      return TermsAndConditionsTextStyleEntity(
        fontSize: fs,
        fontWeight: fw,
        color: color,
        textAlign: ta,
        backgroundColor: bg,
      );
    }

    List<String> contentList() {
      final val = model.content[locale];
      if (val is String) return [val];
      if (val is List) return val.cast<String>();
      return [];
    }

    final String? titleText = model.title?[locale];

    Map<String, dynamic> style = model.style;
    final titleStyleMap = style['title'] ?? style;
    final contentStyleMap = style['content'] ?? style;

    return TermsAndConditionsEntity(
      section: model.section,
      title: titleText,
      content: contentList(),
      titleStyle: parseStyle(Map<String, dynamic>.from(titleStyleMap)),
      contentStyle: parseStyle(Map<String, dynamic>.from(contentStyleMap)),
    );
  }

  static Color _hexToColor(String? hex) =>
      Color(int.parse((hex ?? '#000000').replaceFirst('#', '0xff')));

  static TextAlign _textAlignFromString(String s) {
    switch (s) {
      case 'right':
        return TextAlign.right;
      case 'center':
        return TextAlign.center;
      default:
        return TextAlign.left;
    }
  }
}