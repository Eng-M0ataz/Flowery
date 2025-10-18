import 'package:flower_e_commerce_app/Feature/ordersPage/api/mappers/order_items_mapper.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/api/models/orders_dto.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/order_entity.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/order_items.dart';

extension OrdersMapper on OrdersDto {
  OrdersEntity toEntity() {
    return OrdersEntity(
      id: id,
      orderNumber: orderNumber,
      updatedAt: updatedAt,
      createdAt: createdAt,
      state: state,
      isDelivered: isDelivered,
      isPaid: isPaid,
      paymentType: paymentType,
      totalPrice: totalPrice,
      orderItems: orderItems?.map((i) =>i.toEntity()).toList() ?? <OrderItemsEntity>[],
      user: user,
    );
  }
}