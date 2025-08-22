import 'package:flower_e_commerce_app/Feature/auth/api/client/api_service.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/dataSources/auth_remote_data_source_impl.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/mapper/forget_password_dto_mapper.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/mapper/reset_password_dto_mapper.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/mapper/verify_reset_code_dto_mapper.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/models/response/forget_password_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/models/response/reset_password_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/models/response/verify_reset_code_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/request/forget_password_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/request/reset_password_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/request/verify_reset_code_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/response/forget_password_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/response/reset_password_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/response/verify_reset_code_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:dio/dio.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late MockApiServices mockApiServices;
  late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;

  setUp(() {
    mockApiServices = MockApiServices();
    authRemoteDataSourceImpl =
        AuthRemoteDataSourceImpl(apiServices: mockApiServices);
  });

  group('forgetPassword', () {
    final requestEntity =
        ForgetPasswordRequestEntity(email: 'test@example.com');
    final responseDto =
        ForgetPasswordResponseDto(message: "Email sent", info: '');
    final responseEntity = responseDto.toEntity();

    test('should return ApiSuccessResult when api call is successful',
        () async {
      when(mockApiServices.forgetPassword(any))
          .thenAnswer((_) async => responseDto);

      final result =
          await authRemoteDataSourceImpl.forgetPassword(requestEntity);

      expect(result, isA<ApiSuccessResult<ForgetPasswordResponseEntity>>());
      final success = result as ApiSuccessResult<ForgetPasswordResponseEntity>;
      expect(success.data.message, responseEntity.message);

      verify(mockApiServices.forgetPassword(any)).called(1);
    });

    test(
        'should return ApiErrorResult with ServerFailure when DioException thrown',
        () async {
      when(mockApiServices.forgetPassword(any)).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/forget')),
      );

      final result =
          await authRemoteDataSourceImpl.forgetPassword(requestEntity);

      expect(result, isA<ApiErrorResult<ForgetPasswordResponseEntity>>());
      final error = result as ApiErrorResult<ForgetPasswordResponseEntity>;
      expect(error.failure, isA<ServerFailure>());
    });

    test(
        'should return ApiErrorResult with Failure when generic exception thrown',
        () async {
      when(mockApiServices.forgetPassword(any))
          .thenThrow(Exception('Unexpected error'));

      final result =
          await authRemoteDataSourceImpl.forgetPassword(requestEntity);

      expect(result, isA<ApiErrorResult<ForgetPasswordResponseEntity>>());
      final error = result as ApiErrorResult<ForgetPasswordResponseEntity>;
      expect(error.failure.errorMessage, contains('Unexpected error'));
    });
  });

  group('verifyResetCode', () {
    final requestEntity =
        VerifyResetCodeRequestEntity(resetCode: '123456');
    final responseDto =
        VerifyResetCodeResponseDto(status: "Code verified");
    final responseEntity = responseDto.toEntity();

    test('should return ApiSuccessResult when api call is successful',
        () async {
      when(mockApiServices.verifyResetCode(any))
          .thenAnswer((_) async => responseDto);

      final result =
          await authRemoteDataSourceImpl.verifyResetCode(requestEntity);

      expect(result, isA<ApiSuccessResult<VerifyResetCodeResponseEntity>>());
      final success = result as ApiSuccessResult<VerifyResetCodeResponseEntity>;
      expect(success.data.status, responseEntity.status);

      verify(mockApiServices.verifyResetCode(any)).called(1);
    });

    test(
        'should return ApiErrorResult with ServerFailure when DioException thrown',
        () async {
      when(mockApiServices.verifyResetCode(any)).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/verify')),
      );

      final result =
          await authRemoteDataSourceImpl.verifyResetCode(requestEntity);

      expect(result, isA<ApiErrorResult<VerifyResetCodeResponseEntity>>());
      final error = result as ApiErrorResult<VerifyResetCodeResponseEntity>;
      expect(error.failure, isA<ServerFailure>());
    });

    test(
        'should return ApiErrorResult with Failure when generic exception thrown',
        () async {
      when(mockApiServices.verifyResetCode(any))
          .thenThrow(Exception('Unexpected error'));

      final result =
          await authRemoteDataSourceImpl.verifyResetCode(requestEntity);

      expect(result, isA<ApiErrorResult<VerifyResetCodeResponseEntity>>());
      final error = result as ApiErrorResult<VerifyResetCodeResponseEntity>;
      expect(error.failure.errorMessage, contains('Unexpected error'));
    });
  });

  group('resetPassword', () {
    final requestEntity = ResetPasswordRequestEntity(
        email: 'test@example.com', newPassword: '123456');
    final responseDto = ResetPasswordResponseDto(
        message: "Password reset successful", token: 'token');
    final responseEntity = responseDto.toEntity();

    test('should return ApiSuccessResult when api call is successful',
        () async {
      when(mockApiServices.resetPassword(any))
          .thenAnswer((_) async => responseDto);

      final result =
          await authRemoteDataSourceImpl.resetPassword(requestEntity);

      expect(result, isA<ApiSuccessResult<ResetPasswordResponseEntity>>());
      final success = result as ApiSuccessResult<ResetPasswordResponseEntity>;
      expect(success.data.message, responseEntity.message);

      verify(mockApiServices.resetPassword(any)).called(1);
    });

    test(
        'should return ApiErrorResult with ServerFailure when DioException thrown',
        () async {
      when(mockApiServices.resetPassword(any)).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/reset')),
      );

      final result =
          await authRemoteDataSourceImpl.resetPassword(requestEntity);

      expect(result, isA<ApiErrorResult<ResetPasswordResponseEntity>>());
      final error = result as ApiErrorResult<ResetPasswordResponseEntity>;
      expect(error.failure, isA<ServerFailure>());
    });

    test(
        'should return ApiErrorResult with Failure when generic exception thrown',
        () async {
      when(mockApiServices.resetPassword(any))
          .thenThrow(Exception('Unexpected error'));

      final result =
          await authRemoteDataSourceImpl.resetPassword(requestEntity);

      expect(result, isA<ApiErrorResult<ResetPasswordResponseEntity>>());
      final error = result as ApiErrorResult<ResetPasswordResponseEntity>;
      expect(error.failure.errorMessage, contains('Unexpected error'));
    });
  });
}
