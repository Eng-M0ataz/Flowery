import 'package:flower_e_commerce_app/Feature/trackOrder/domain/entities/order_details_entity.dart';

abstract class TrackOrderRepo {
  Stream<OrderDetailsEntity> listenData(String path);
}
