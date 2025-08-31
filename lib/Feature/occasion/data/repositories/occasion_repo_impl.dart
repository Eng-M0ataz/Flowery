import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/response/product_by_occasion_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/response/occasion_response_entity.dart';
import '../../domain/repositories/occasion_repo.dart';
import '../dataSources/occasion_remote_data_source.dart';

@Injectable(as: OccasionRepo)
class OccasionRepoImpl implements OccasionRepo {
  final OccasionRemoteDataSource _occasionRemoteDataSource;

  OccasionRepoImpl(this._occasionRemoteDataSource);

  @override
  Future<ApiResult<OccasionResponseEntity>> getAllOccasions() {
    return _occasionRemoteDataSource.getAllOccasions();
  }

  @override
  Future<ApiResult<ProductByOccasionResponseEntity>> getProductsByOccasion(String occasionId) {
    return _occasionRemoteDataSource.getProductsByOccasion(occasionId);
  }

}
