import 'package:flower_e_commerce_app/Feature/about-app/domain/entities/about_app_entity.dart';
import 'package:flower_e_commerce_app/Feature/about-app/domain/repositories/about_app_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AboutAppUseCase {
  final AboutAppRepository repo;
  AboutAppUseCase(this.repo);

  Future<List<AboutAppEntity>> invoke(String locale) {
    return repo.fetchSections(locale);
  }
}