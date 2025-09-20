import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/address_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/repositories/address_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAddressesUseCase {
  final AddressRepo _addressRepo;

  GetAddressesUseCase({required AddressRepo addressRepo})
      : _addressRepo = addressRepo;

  Future<ApiResult<AddressResponseEntity>> invoke() {
    return _addressRepo.getAddresses();
  }
}
