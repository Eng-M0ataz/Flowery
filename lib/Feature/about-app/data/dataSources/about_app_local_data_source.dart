import 'package:flower_e_commerce_app/Feature/about-app/local/model/about_app_model.dart';

abstract class AboutAppLocalDataSource {
  Future<List<AboutAppModel>> getSections();
}