import 'package:flower_e_commerce_app/Feature/checkout/api/client/checkout_api_service.dart';
import 'package:flower_e_commerce_app/Feature/checkout/api/mapper/shipping_address_mapper.dart';
import 'package:flower_e_commerce_app/Feature/checkout/api/mapper/user_address_response_mapper.dart';
import 'package:flower_e_commerce_app/Feature/checkout/api/mapper/visa_order_mapper.dart';
import 'package:flower_e_commerce_app/Feature/checkout/domain/entities/response/user_address_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Functions/execute_api.dart';
import 'package:injectable/injectable.dart';
import '../../data/dataSources/checkout_remote_data_source.dart';
import '../../domain/entities/request/shipping_address_entity.dart';
import '../../domain/entities/response/visa_order_entity.dart';
import '../models/response/user_address_dto.dart';
import '../models/response/visa_order_dto.dart';

@Injectable(as: CheckoutRemoteDataSource)
class CheckoutRemoteDataSourceImpl implements CheckoutRemoteDataSource {
  final CheckoutApiService _apiService;

  CheckoutRemoteDataSourceImpl(this._apiService);

  @override
  Future<ApiResult<void>> createCashOrder({
    required ShippingAddressEntity addressRequest,
  }) async {
    return executeApi<dynamic, void>(
      request: () => _apiService.createCashOrder(addressRequest.toDto()),
      mapper: (_) {},
    );
  }

  @override
  Future<ApiResult<VisaOrderEntity>> createVisaOrder(
      {required ShippingAddressEntity addressRequest}) async {
    return executeApi<VisaOrderDto, VisaOrderEntity>(
      request: () => _apiService.createVisaOrder(addressRequest.toDto()),
      mapper: (dto) => dto.toEntity(),
    );
  }

  @override
  Future<ApiResult<UserAddressResponseEntity>> getUserAddress() async {
    return executeApi<UserAddressDto, UserAddressResponseEntity>(
      request: () => _apiService.getUserAddress(),
      mapper: (dto) => dto.toEntity(),
    );
  }
}
