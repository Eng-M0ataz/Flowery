
import 'package:flower_e_commerce_app/Feature/ordersPage/data/dataSources/orders_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/responseEntities/order_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/repositories/orders_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrdersRepo)
class OrdersRepoImpl implements OrdersRepo {
  final OrdersRemoteDataSource _dataSource;
  OrdersRepoImpl(this._dataSource);

  @override
  Future <ApiResult<OrdersResponseEntity>> getOrders() {
    return _dataSource.getAllOrders();
  }
}