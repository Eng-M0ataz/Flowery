import 'dart:convert';
import 'package:flower_e_commerce_app/Feature/termAndConditions/data/dataSources/terms_and_conditions_local_data_source.dart';
import 'package:flower_e_commerce_app/Feature/termAndConditions/local/model/terms_and_conditions_model.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/app_constants.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TermsAndConditionsLocalDataSource)
class TermsAndConditionsLocalDataSourceImpl implements TermsAndConditionsLocalDataSource {
  @override
  Future<List<TermsAndConditionsModel>> getSections() async {
    final jsonString = await rootBundle.loadString(AppConstants.termsAndConditionsPath);
    final Map<String, dynamic> data = json.decode(jsonString);
    final List sections = data['terms_and_conditions'];
    return sections
        .map((e) => TermsAndConditionsModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}