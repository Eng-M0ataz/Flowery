import 'package:dio/dio.dart';
import 'package:flower_e_commerce_app/Feature/occasion/api/mapper/occasion_response_mapper.dart';
import 'package:flower_e_commerce_app/Feature/occasion/api/mapper/product_by_occasion_mapper.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/Errors/failure.dart';
import '../../data/dataSources/occasion_remote_data_source.dart';
import '../../domain/entities/response/occasion_response_entity.dart';
import '../../domain/entities/response/product_by_occasion_response_entity.dart';
import '../client/occasion_api_service.dart';

@Injectable(as: OccasionRemoteDataSource)
class OccasionRemoteDataSourceImpl implements OccasionRemoteDataSource {
  final OccasionApiService _apiService;

  OccasionRemoteDataSourceImpl(this._apiService);

  @override
  Future<ApiResult<OccasionResponseEntity>> getAllOccasions() async {
    try {
      final result = await _apiService.getAllOccasions();
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

  @override
  Future<ApiResult<ProductByOccasionResponseEntity>> getProductsByOccasion(
      String occasionId) async {
    try {
      final result = await _apiService.getProductsByOccasion(occasionId);
      return ApiSuccessResult<ProductByOccasionResponseEntity>(
          data: result.toEntity());
    } on DioException catch (e) {
      return ApiErrorResult<ProductByOccasionResponseEntity>(
        failure: ServerFailure.fromDioError(dioException: e),
      );
    } catch (e) {
      return ApiErrorResult<ProductByOccasionResponseEntity>(
        failure: Failure(errorMessage: e.toString()),
      );
    }
  }
}
