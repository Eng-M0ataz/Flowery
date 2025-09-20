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

import 'package:flower_e_commerce_app/Feature/auth/api/mapper/sign_up_response_dto_mapper.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/models/response/sign_up_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/models/sign_up_request_model.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/models/user_dto.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/requestEntities/sign_up_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/resposneEntities/sign_up_response_entity.dart';

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

        AuthRemoteDataSourceImpl(apiServicest: mockApiServices);
  });
  group('signUp', () {
    final requestEntity = SignUpRequestEntity(
      firstName: 'John',
      lastName: 'Doe',
      gender: 'male',
      email: 'john@example.com',
      password: 'password123',
      rePassword: 'password123',
      phone: '+1234567890',
    );

    final responseDto = SignUpResponseDto(
      message: "User registered successfully",
      user: UserDto(
        id: '1',
        firstName: 'John',
        lastName: 'Doe',
        gender: 'male',
        email: 'john@example.com',
        phone: '+1234567890',
        addresses: [],
        createdAt: DateTime(2023, 1, 1),
        photo: '',
        wishlist: [],
        role: 'customer',
      ),
      token: 'auth_token_123',
    );

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

      // Arrange
      when(mockApiServices.signUp(any)).thenAnswer((_) async => responseDto);

      // Act
      final result = await authRemoteDataSourceImpl.signup(requestEntity);

      // Assert
      expect(result, isA<ApiSuccessResult<SignUpResponseEntity>>());
      final success = result as ApiSuccessResult<SignUpResponseEntity>;
      expect(success.data.message, responseEntity.message);
      expect(success.data.user?.firstName, responseEntity.user?.firstName);
      expect(success.data.user?.lastName, responseEntity.user?.lastName);
      expect(success.data.user?.email, responseEntity.user?.email);
      expect(success.data.user?.gender, responseEntity.user?.gender);
      expect(success.data.token, responseEntity.token);

      verify(mockApiServices.signUp(any)).called(1);

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

      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/signup'),
        response: Response(
          requestOptions: RequestOptions(path: '/signup'),
          statusCode: 400,
          data: {'message': 'Email already exists'},
        ),
      );

      when(mockApiServices.signUp(any)).thenThrow(dioException);

      // Act
      final result = await authRemoteDataSourceImpl.signup(requestEntity);

      // Assert
      expect(result, isA<ApiErrorResult<SignUpResponseEntity>>());
      final error = result as ApiErrorResult<SignUpResponseEntity>;
      expect(error.failure, isA<ServerFailure>());

      verify(mockApiServices.signUp(any)).called(1);
    });

    test(
        'should return ApiErrorResult with ServerFailure when generic exception thrown',
        () async {
      // Arrange
      when(mockApiServices.signUp(any))
          .thenThrow(Exception('Network connection failed'));

      // Act
      final result = await authRemoteDataSourceImpl.signup(requestEntity);

      // Assert
      expect(result, isA<ApiErrorResult<SignUpResponseEntity>>());
      final error = result as ApiErrorResult<SignUpResponseEntity>;
      expect(error.failure, isA<ServerFailure>());
      expect(error.failure.errorMessage, contains('Unexpected error occurred'));
      expect(error.failure.errorMessage, contains('Network connection failed'));

      verify(mockApiServices.signUp(any)).called(1);
    });

    test('should call signUp with correct SignUpRequestDto', () async {
      // Arrange
      when(mockApiServices.signUp(any)).thenAnswer((_) async => responseDto);

      // Act
      await authRemoteDataSourceImpl.signup(requestEntity);

      // Assert
      final captured = verify(mockApiServices.signUp(captureAny)).captured;
      final capturedDto = captured.first as SignUpRequestModel;

      expect(capturedDto.firstName, requestEntity.firstName);
      expect(capturedDto.lastName, requestEntity.lastName);
      expect(capturedDto.gender, requestEntity.gender);
      expect(capturedDto.email, requestEntity.email);
      expect(capturedDto.password, requestEntity.password);
      expect(capturedDto.rePassword, requestEntity.rePassword);
      expect(capturedDto.phone, requestEntity.phone);
    });

    test('should handle DioException with specific error response', () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/signup'),
        response: Response(
          requestOptions: RequestOptions(path: '/signup'),
          statusCode: 422,
          data: {
            'message': 'Validation failed',
            'errors': {
              'email': ['The email field is required.'],
              'password': ['The password must be at least 8 characters.']
            }
          },
        ),
      );

      when(mockApiServices.signUp(any)).thenThrow(dioException);

      // Act
      final result = await authRemoteDataSourceImpl.signup(requestEntity);

      // Assert
      expect(result, isA<ApiErrorResult<SignUpResponseEntity>>());
      final error = result as ApiErrorResult<SignUpResponseEntity>;
      expect(error.failure, isA<ServerFailure>());
      // The exact error message will depend on your ServerFailure.fromDioError implementation

      verify(mockApiServices.signUp(any)).called(1);

    });
  });
}
