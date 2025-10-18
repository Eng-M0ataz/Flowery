import 'package:flower_e_commerce_app/Feature/trackOrder/data/dataSources/track_order_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/data/mappers/order_details_mapper.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/data/models/order_details_model.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/domain/entities/order_details_entity.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/domain/repositories/track_order_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TrackOrderRepo)
class TrackOrderRepoImpl implements TrackOrderRepo {
  TrackOrderRepoImpl(this._trackOrderRemoteDataSource);

  final TrackOrderRemoteDataSource _trackOrderRemoteDataSource;

  @override
  Stream<OrderDetailsEntity> listenData(String path) {
    return _trackOrderRemoteDataSource.listenData(path).map((jsonData) {
      if (jsonData.isEmpty) {
        return const OrderDetailsEntity();
      }

      try {
        final normalized = _normalizeJsonMap(jsonData);
        final model = OrderDetailsModel.fromJson(normalized);
        return model.toEntity();
      } catch (e) {
        // Return empty entity on parsing error
        return const OrderDetailsEntity();
      }
    });
  }

  Map<String, dynamic> _normalizeJsonMap(Map<dynamic, dynamic> source) {
    final Map<String, dynamic> result = <String, dynamic>{};
    source.forEach((key, value) {
      final String stringKey = key.toString();
      result[stringKey] = _normalizeJsonValue(value);
    });
    return result;
  }

  dynamic _normalizeJsonValue(dynamic value) {
    if (value is Map) {
      return _normalizeJsonMap(value);
    }
    if (value is List) {
      return value.map(_normalizeJsonValue).toList();
    }
    return value;
  }
}
