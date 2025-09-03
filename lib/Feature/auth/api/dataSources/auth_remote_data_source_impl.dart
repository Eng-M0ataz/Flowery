import 'package:dio/dio.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/client/api_service.dart';
import 'package:flower_e_commerce_app/Feature/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entity/response/sign_in_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entity/request/sign_in_request_entity.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiServices _apiServices;
  AuthRemoteDataSourceImpl(this._apiServices);

  @override
  Future<ApiResult<SigninResponseEntity>> signin({
    required SigninRequestEntity request
  }) async {
    try{
      final response = await _apiServices.signIn(request: request.toDto());
      return ApiSuccessResult<SigninResponseEntity>(data: response.toEntity());
    } on DioException catch(e) {
      final failure = ServerFailure.fromDioError(dioException: e);
      return ApiErrorResult<SigninResponseEntity>(failure: failure);
    } catch(e) {
      final failure = Failure(errorMessage: e.toString());
      return ApiErrorResult<SigninResponseEntity>(failure: failure);
    }
  }
}
