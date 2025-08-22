import 'package:dio/dio.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/client/api_service.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/model/requests/sign_in_request_dto.dart';
import 'package:flower_e_commerce_app/Feature/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/Entity/sign_in_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiServices _apiServices;
  AuthRemoteDataSourceImpl(this._apiServices);

  @override
  Future<ApiResult<SigninResponseEntity>> signin({
    required String email,
    required String password
  }) async {
    try{
      final request = SigninRequestDto(email: email, password: password);

      final response = await _apiServices.signIn(request: request);

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
