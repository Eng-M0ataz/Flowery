import 'package:dio/dio.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/api/models/response/orders_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../../../core/utils/Constantts/api_constants.dart';
part 'orders_service.g.dart';

@RestApi()
@injectable
abstract class OrdersApiService {
  @factoryMethod
  factory OrdersApiService(Dio dio) = _OrdersApiService;

  @GET(ApiConstants.orders)
  Future<OrdersResponseDto> getOrders();
}