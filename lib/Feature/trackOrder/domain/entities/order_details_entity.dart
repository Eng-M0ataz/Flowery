import 'driver_entity.dart';
import 'order_status_history_entity.dart';
import 'store_entity.dart';
import 'user_entity.dart';

class OrderDetailsEntity {
  final OrderStatusHistoryEntity? statusHistory;
  final DriverEntity? driver;
  final UserEntity? user;
  final StoreEntity? store;

  const OrderDetailsEntity({
    this.statusHistory,
    this.driver,
    this.user,
    this.store,
  });
}

