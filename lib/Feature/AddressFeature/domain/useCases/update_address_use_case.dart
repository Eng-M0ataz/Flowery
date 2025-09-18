import 'package:flower_e_commerce_app/Feature/AddressFeature/api/models/request/add_address_request_model.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/repositories/address_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateAddressUseCase {
  final AddressRepo _addressRepo;

  UpdateAddressUseCase(this._addressRepo);

  Future<ApiResult<void>> call(
      {required String addressId,required AddAddressRequestModel requestModel}) {
    return _addressRepo.updateAddress(addressId, requestModel);
  }
}
