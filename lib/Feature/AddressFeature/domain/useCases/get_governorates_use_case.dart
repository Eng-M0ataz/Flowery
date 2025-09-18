import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/governorate_entity.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/repositories/address_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetGovernoratesUseCase {
  final AddressRepo _repository;
  GetGovernoratesUseCase({required AddressRepo repository})
      : _repository = repository;

  Future<List<GovernorateEntity>> call() async {
    return await _repository.getGovernorates();
  }
}
