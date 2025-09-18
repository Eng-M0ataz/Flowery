import 'package:dio/dio.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/mapper/forget_password_dto_mapper.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/mapper/reset_password_dto_mapper.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/mapper/verify_reset_code_dto_mapper.dart';
import 'package:flower_e_commerce_app/Feature/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/Errors/api_results.dart';
import '../../../../core/Errors/failure.dart';
import '../../domain/entities/request/forget_password_request_entity.dart';
import '../../domain/entities/request/reset_password_request_entity.dart';
import '../../domain/entities/request/verify_reset_code_request_entity.dart';
import '../../domain/entities/response/forget_password_response_entity.dart';
import '../../domain/entities/response/reset_password_response_entity.dart';
import '../../domain/entities/response/verify_reset_code_response_entity.dart';
import '../client/api_service.dart';
import '../models/request/forget_password_request.dart';
import '../models/request/reset_password_request.dart';
import '../models/request/verify_reset_code_request.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiServices _apiServices;

  AuthRemoteDataSourceImpl({required ApiServices apiServices})
      : _apiServices = apiServices;

  @override
  Future<ApiResult<ForgetPasswordResponseEntity>> forgetPassword(
    ForgetPasswordRequestEntity request,
  ) async {
    try {
      final dto = ForgetPasswordRequest.fromDomain(request);
      var response = await _apiServices.forgetPassword(dto);
      return ApiSuccessResult<ForgetPasswordResponseEntity>(
        data: response.toEntity(),
      );
    } on DioException catch (e) {
      return ApiErrorResult<ForgetPasswordResponseEntity>(
        failure: ServerFailure.fromDioError(dioException: e),
      );
    } catch (e) {
      return ApiErrorResult<ForgetPasswordResponseEntity>(
        failure: Failure(errorMessage: e.toString()),
      );
    }
  }

  @override
  Future<ApiResult<VerifyResetCodeResponseEntity>> verifyResetCode(
    VerifyResetCodeRequestEntity request,
  ) async {
    try {
      final dto = VerifyResetCodeRequest.fromDomain(request);
      final response = await _apiServices.verifyResetCode(dto);
      return ApiSuccessResult<VerifyResetCodeResponseEntity>(
        data: response.toEntity(),
      );
    } on DioException catch (e) {
      return ApiErrorResult<VerifyResetCodeResponseEntity>(
        failure: ServerFailure.fromDioError(dioException: e),
      );
    } catch (e) {
      return ApiErrorResult<VerifyResetCodeResponseEntity>(
        failure: Failure(errorMessage: e.toString()),
      );
    }
  }

  @override
  Future<ApiResult<ResetPasswordResponseEntity>> resetPassword(
    ResetPasswordRequestEntity request,
  ) async {
    try {
      final dto = ResetPasswordRequest.fromDomain(request);
      final response = await _apiServices.resetPassword(dto);
      return ApiSuccessResult<ResetPasswordResponseEntity>(
        data: response.toEntity(),
      );
    } on DioException catch (e) {
      return ApiErrorResult<ResetPasswordResponseEntity>(
        failure: ServerFailure.fromDioError(dioException: e),
      );
    } catch (e) {
      return ApiErrorResult<ResetPasswordResponseEntity>(
        failure: Failure(errorMessage: e.toString()),
      );
    }
  }
}
