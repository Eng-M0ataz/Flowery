import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/repositories/address_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteAddressUseCase {
  final AddressRepo _addressRepo;

  DeleteAddressUseCase({required AddressRepo addressRepo})
      : _addressRepo = addressRepo;

  Future<ApiResult<void>> invoke(String addressId) {
    return _addressRepo.deleteAddress(addressId);
  }
}
