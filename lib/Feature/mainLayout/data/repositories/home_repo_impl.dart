import 'package:flower_e_commerce_app/Feature/mainLayout/data/dataSources/home_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/domain/entities/response/occasion_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/domain/repositories/home_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource _authRemoteDataSource;

  HomeRepoImpl(this._authRemoteDataSource);

  @override
  Future<ApiResult<OccasionResponseEntity>> getAllOccasions() {
    return _authRemoteDataSource.getAllOccasions();
  }
}
