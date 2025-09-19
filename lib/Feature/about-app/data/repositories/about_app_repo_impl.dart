import 'package:flower_e_commerce_app/Feature/about-app/data/dataSources/about_app_local_data_source.dart';
import 'package:flower_e_commerce_app/Feature/about-app/domain/entities/about_app_entity.dart';
import 'package:flower_e_commerce_app/Feature/about-app/domain/repositories/about_app_repo.dart';
import 'package:flower_e_commerce_app/Feature/about-app/local/mapper/about_app_mapper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AboutAppRepository)
class AboutRepositoryImpl implements AboutAppRepository {
  final AboutAppLocalDataSource _aboutAppLocalDataSource;

  AboutRepositoryImpl(this._aboutAppLocalDataSource);

  @override
  Future<List<AboutAppEntity>> fetchSections(String locale) async {
    final models = await _aboutAppLocalDataSource.getSections();
    return models
        .map((m) => AboutMapper.toEntity(m, locale))
        .toList();
  }
}