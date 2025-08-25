import 'package:dio/dio.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/client/api_service.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/mapper/category_response_dto_mapper.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/data/dataSources/categories_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/resposneEntities/categories_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CategoriesRemoteDataSource)
class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final ApiServices _apiServices;

  CategoriesRemoteDataSourceImpl({
    required ApiServices apiServicest,
  }) : _apiServices = apiServicest;

  @override
  Future<ApiResult<CategoryResponseEntity>> getAllCategories() async {
    try {
      var response = await _apiServices.getAllCategories();
      return ApiSuccessResult<CategoryResponseEntity>(
          data: response.toEntity());
    } on DioException catch (dioError) {
      final failure = ServerFailure.fromDioError(dioException: dioError);
      return ApiErrorResult<CategoryResponseEntity>(failure: failure);
    } catch (e) {
      return ApiErrorResult<CategoryResponseEntity>(
          failure: ServerFailure(errorMessage: e.toString()));
    }
  }
}
