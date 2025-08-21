import 'package:dio/dio.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/client/api_service.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/mapper/sign_up_response_dto_mapper.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/models/sign_up_request_dto.dart';
import 'package:flower_e_commerce_app/Feature/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/requestEntities/sign_up_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/resposneEntities/sign_up_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  ApiServices _apiServices;

  AuthRemoteDataSourceImpl({
    required ApiServices apiServicest,
  }) : _apiServices = apiServicest;
  @override
  Future<ApiResult<SignUpResponseEntity>> signup(
      SignUpRequestEntity signUpRequest) async {
    try {
      var response =
          await _apiServices.signUp(SignUpRequestDto.fromDomain(signUpRequest));
      return ApiSuccessResult(data: response.toEntity());
    } on DioException catch (dioError) {
      // Handle DioException specifically to extract proper error messages
      final failure = ServerFailure.fromDioError(dioException: dioError);
      return ApiErrorResult<SignUpResponseEntity>(failure: failure);
    } catch (e) {
      return ApiErrorResult<SignUpResponseEntity>(
          failure: ServerFailure(
              errorMessage: "Unexpected error occurred: ${e.toString()}"));
    }
  }
}
