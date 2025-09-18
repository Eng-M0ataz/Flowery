import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/city_entity.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/repositories/address_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCitiesByGovernorateUseCase {
  final AddressRepo _repository;
  GetCitiesByGovernorateUseCase({required AddressRepo repository})
      : _repository = repository;

  Future<List<CityEntity>> call(int governorateId) async {
    return await _repository.getCitiesByGovernorateId(governorateId);
  }
}
