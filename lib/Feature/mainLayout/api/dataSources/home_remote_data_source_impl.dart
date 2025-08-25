import 'package:dio/dio.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/api/mapper/occasion_response_mapper.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/domain/entities/response/occasion_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/Errors/failure.dart';
import '../../data/dataSources/home_remote_data_source.dart';
import '../client/home_api_service.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final HomeApiService _apiService;

  HomeRemoteDataSourceImpl(this._apiService);

  @override
  Future<ApiResult<OccasionResponseEntity>> getAllOccasions() async {
    try {
      var result = await _apiService.getAllOccasions();
      return ApiSuccessResult<OccasionResponseEntity>(data: result.toEntity());
    } on DioException catch (e) {
      return ApiErrorResult<OccasionResponseEntity>(
        failure: ServerFailure.fromDioError(dioException: e),
      );
    } catch (e) {
      return ApiErrorResult<OccasionResponseEntity>(
        failure: Failure(errorMessage: e.toString()),
      );
    }
  }
}
