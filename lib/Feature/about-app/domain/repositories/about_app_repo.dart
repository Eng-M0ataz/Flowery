import 'package:flower_e_commerce_app/Feature/about-app/domain/entities/about_app_entity.dart';

abstract class AboutAppRepository {
  Future<List<AboutAppEntity>> fetchSections(String locale);
}