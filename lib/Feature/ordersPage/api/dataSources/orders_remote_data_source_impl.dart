import 'package:flower_e_commerce_app/Feature/ordersPage/api/client/orders_service.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/api/mappers/response/order_response_mapper.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/data/dataSources/orders_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/responseEntities/order_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/execute_api.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrdersRemoteDataSource)
class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final OrdersApiService _apiService;
  OrdersRemoteDataSourceImpl(this._apiService);

  @override
  Future<ApiResult<OrdersResponseEntity>> getAllOrders() async {
    return executeApi(
      request: () => _apiService.getOrders(),
      mapper: (response) => response.toEntity(),
    );
  }
}