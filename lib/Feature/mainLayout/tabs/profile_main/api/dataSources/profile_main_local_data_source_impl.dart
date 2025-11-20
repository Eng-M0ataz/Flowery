import 'dart:convert';

import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile_main/api/dataSources/profile_main_local_data_source.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/utils/Constantts/app_constants.dart';
import '../models/about_app_model.dart';
import '../models/terms_and_conditions_model.dart';

@Injectable(as: ProfileMainLocalDataSource)
class ProfileMainLocalDataSourceImpl implements ProfileMainLocalDataSource {
  const ProfileMainLocalDataSourceImpl();

  @override
  Future<TermsAndConditionsModel> getTermsAndConditions() async {
    final String jsonString =
        await rootBundle.loadString(AppConstants.termsPath);

    final Map<String, dynamic> data =
        json.decode(jsonString) as Map<String, dynamic>;

    return TermsAndConditionsModel.fromJson(data);
  }

  @override
  Future<AboutAppModel> getAboutApp() async {
    final String jsonString = await rootBundle.loadString(
      AppConstants.aboutPath,
    );

    final Map<String, dynamic> data =
        json.decode(jsonString) as Map<String, dynamic>;

    return AboutAppModel.fromJson(data);
  }
}
