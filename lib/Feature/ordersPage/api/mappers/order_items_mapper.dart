import 'package:flower_e_commerce_app/Feature/ordersPage/api/mappers/product_mapper.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/api/models/order_items_dto.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/order_items.dart';

extension OrderItemsMapper on OrderItemsDto {
  OrderItemsEntity toEntity() {
    return OrderItemsEntity(
      product: productDto!.toEntity(),
      price: price,
      quantity: quantity,
      id: id,
    );
  }
}