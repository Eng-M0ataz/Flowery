import '../../domain/entities/response/visa_order_entity.dart';
import '../models/response/visa_order_dto.dart';

extension VisaOrderMapper on VisaOrderDto {
  VisaOrderEntity toEntity() {
    return VisaOrderEntity(
      message: message??'',
      url: session?.url??'',
    );
  }
}
