
import 'package:dio/dio.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/api/models/response/orders_response_dto.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'orders_service.g.dart';

@RestApi()
@injectable
abstract class OrdersService {
  @factoryMethod
  factory OrdersService(Dio dio) = _OrdersService;

  @GET(ApiConstants.orders)
  Future<OrdersResponseDto> getOrders();
}