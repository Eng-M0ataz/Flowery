import 'package:flower_e_commerce_app/Feature/ordersPage/api/mappers/metadata_mapper.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/api/mappers/orders_mapper.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/api/models/response/orders_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/metadata_entity.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/order_entity.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/responseEntities/order_response_entity.dart';

extension OrderResponseMapper on OrdersResponseDto {
  OrdersResponseEntity toEntity() {
    return OrdersResponseEntity(
      message: message ?? '',
      metaData: metadata?.toEntity() ??
          MetadataEntity(
            totalPages: 1,
            totalItems: 0,
            limit: 0,
            currentPage: 1
          ),
      orders: orders?.map((o) => o.toEntity()).toList() ?? <OrdersEntity>[],
    );
  }
}