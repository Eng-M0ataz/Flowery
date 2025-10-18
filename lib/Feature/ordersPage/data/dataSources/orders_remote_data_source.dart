import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/responseEntities/order_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';

abstract interface class OrdersRemoteDataSource {
  Future<ApiResult<OrdersResponseEntity>> getAllOrders();
}