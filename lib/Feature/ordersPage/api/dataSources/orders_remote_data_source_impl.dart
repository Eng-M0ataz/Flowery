
import 'package:dio/dio.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/api/client/orders_service.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/api/mappers/response/order_response_mapper.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/data/dataSources/orders_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/responseEntities/order_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrdersRemoteDataSource)
class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final OrdersService _apiService;
  OrdersRemoteDataSourceImpl(this._apiService);

  @override
  Future<ApiResult<OrdersResponseEntity>> getAllOrders() async {
    try {
      var response = await _apiService.getOrders();
        return ApiSuccessResult<OrdersResponseEntity>(data: response.toEntity());
    }on DioException catch (e) {
      return ApiErrorResult<OrdersResponseEntity>(
        failure: ServerFailure.fromDioError(dioException: e),
      );
    }  catch (e) {
      return ApiErrorResult(
        failure: Failure(errorMessage: e.toString()),
      );
    }
  }
}