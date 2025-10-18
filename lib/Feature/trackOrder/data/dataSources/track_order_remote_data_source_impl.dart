import 'package:flower_e_commerce_app/Feature/trackOrder/data/dataSources/track_order_remote_data_source.dart';
import 'package:flower_e_commerce_app/core/Services/real_time_database_service.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/app_constants.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TrackOrderRemoteDataSource)
class TrackOrderRemoteDataSourceImpl implements TrackOrderRemoteDataSource {
  TrackOrderRemoteDataSourceImpl(
    @Named(AppConstants.firebaseRealTimeDatabase) this._realTimeDataBaseService,
  );

  final RealTimeDataBaseService _realTimeDataBaseService;

  @override
  Stream<Map<String, dynamic>> listenData(String path) {
    return _realTimeDataBaseService
        .listenData(path)
        .handleError((error, stackTrace) {
      throw Exception('Failed to listen to order updates');
    });
  }
}
