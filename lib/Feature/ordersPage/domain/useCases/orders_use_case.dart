import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/responseEntities/order_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/repositories/orders_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrdersUseCase{
  final OrdersRepo _ordersRepo;
  OrdersUseCase(this._ordersRepo);

  Future <ApiResult<OrdersResponseEntity>> invoke() async {
    return _ordersRepo.getOrders();
  }
}