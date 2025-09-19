import 'package:flower_e_commerce_app/Feature/termAndConditions/data/dataSources/terms_and_conditions_local_data_source.dart';
import 'package:flower_e_commerce_app/Feature/termAndConditions/domain/entities/terms_and_conditions_entity.dart';
import 'package:flower_e_commerce_app/Feature/termAndConditions/domain/repositories/terms_and_conditions_repo.dart';
import 'package:flower_e_commerce_app/Feature/termAndConditions/local/mapper/terms_and_conditions_mapper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TermsAndConditionsRepository)
class TermsAndConditionsRepositoryImpl implements TermsAndConditionsRepository {
  final TermsAndConditionsLocalDataSource _termsAndConditionsLocalDataSource;

  TermsAndConditionsRepositoryImpl(this._termsAndConditionsLocalDataSource);

  @override
  Future<List<TermsAndConditionsEntity>> fetchSections(String locale) async {
    final models = await _termsAndConditionsLocalDataSource.getSections();
    return models
        .map((m) => TermsAndConditionsMapper.toEntity(m, locale))
        .toList();
  }
}