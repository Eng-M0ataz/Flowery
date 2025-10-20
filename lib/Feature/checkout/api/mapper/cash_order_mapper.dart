import '../../domain/entities/response/cash_order_entity.dart';
import '../models/response/cash_order_dto.dart';

extension CashOrderMapper on CashOrderDto {
  CashOrderEntity toEntity() {
    return CashOrderEntity(
      message: message??'',
      orderId: order?.id??'',
    );
  }
}
