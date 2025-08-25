import 'package:dio/dio.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/bestSellerFeature/api/client/api_service.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/bestSellerFeature/api/mapper/best_seller_response_dto_mapper.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/bestSellerFeature/domain/entities/responseEntities/best_seller_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:injectable/injectable.dart';
import '../../data/dataSource/best_seller_remote_data_source.dart';

@Injectable(as: BestSellerRemoteDataSource)
class BestSellerRemoteDataSourceImpl implements BestSellerRemoteDataSource {
  final ApiServices apiServices;
  BestSellerRemoteDataSourceImpl({required this.apiServices});

  @override
  Future<ApiResult<BestSellerResponseEntity>> getAllBestSeller() async {
    try{
      var response = await apiServices.getBestSeller();
      return ApiSuccessResult<BestSellerResponseEntity>(
          data: response.toEntity());
    }on DioException catch (dioError){
      final failure = ServerFailure.fromDioError(dioException: dioError);
      return ApiErrorResult<BestSellerResponseEntity>(failure: failure);
    }catch (e){
      return ApiErrorResult<BestSellerResponseEntity>(
          failure: ServerFailure(errorMessage: e.toString()));
    }
  }
}