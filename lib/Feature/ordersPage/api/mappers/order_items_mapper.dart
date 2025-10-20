import 'package:flower_e_commerce_app/Feature/ordersPage/api/mappers/product_mapper.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/api/models/order_items_dto.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/order_items.dart';
import 'package:flower_e_commerce_app/core/models/product_details_model.dart';

extension OrderItemsMapper on OrderItemsDto {
  OrderItemsEntity toEntity() {
    return OrderItemsEntity(
      product: productDto?.toEntity() ?? ProductDetailsModel(id: '', title: '', images: [], price: 0, description: '', quantity: 0, priceAfterDiscount: 0.0, imageCover: ''),
      price: price ?? 0,
      quantity: quantity ?? 0,
      id: id ?? '',
    );
  }
}