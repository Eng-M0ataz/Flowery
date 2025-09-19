import 'dart:convert';
import 'package:flower_e_commerce_app/Feature/about-app/data/dataSources/about_app_local_data_source.dart';
import 'package:flower_e_commerce_app/Feature/about-app/local/model/about_app_model.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/app_constants.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AboutAppLocalDataSource)
class AboutAppLocalDataSourceImpl implements AboutAppLocalDataSource {
  @override
  Future<List<AboutAppModel>> getSections() async {
    final jsonString = await rootBundle.loadString(AppConstants.aboutAppPath);
    final Map<String, dynamic> data = json.decode(jsonString);
    final List sections = data['about_app'];
    return sections
        .map((e) => AboutAppModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}