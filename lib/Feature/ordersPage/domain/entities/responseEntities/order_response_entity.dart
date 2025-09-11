import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/metadata_entity.dart';
import '../order_entity.dart';

class OrdersResponseEntity {
  final String? message;
  final List<OrdersEntity>? orders;
  final MetadataEntity? metaData;

  OrdersResponseEntity({
    this.message,
    this.metaData,
    this.orders
  });
}