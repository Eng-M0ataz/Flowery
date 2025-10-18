import 'package:flower_e_commerce_app/Feature/trackOrder/domain/entities/order_details_entity.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/domain/repositories/track_order_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class TrackOrderUseCase {
  TrackOrderUseCase(this._trackOrderRepo);

  final TrackOrderRepo _trackOrderRepo;

  Stream<OrderDetailsEntity> listenData(String path) {
    return _trackOrderRepo.listenData(path);
  }
}
