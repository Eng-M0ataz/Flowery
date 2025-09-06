// lib/test/Feature/auth/data/dataSources/auth_remote_data_source_impl_test.dart
import 'package:dio/dio.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/dataSources/auth_remote_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/client/api_service.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/model/requests/sign_in_request_dto.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/model/responses/sign_in_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/model/responses/user_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entity/request/sign_in_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entity/response/sign_in_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';

import 'auth_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late AuthRemoteDataSourceImpl authRemoteDataSource;
  late MockApiServices mockApiServices;

  setUp(() {
    mockApiServices = MockApiServices();
    authRemoteDataSource = AuthRemoteDataSourceImpl(mockApiServices);
  });

  group('AuthRemoteDataSourceImpl Tests', () {
    group('signin', () {
      test('should return ApiSuccessResult with SigninResponseEntity on successful signin', () async {
        // Arrange
        final requestEntity = SigninRequestEntity(
          email: 'test@example.com',
          password: 'password123',
        );

        final responseDto = SigninResponseDto(
          message: 'Login successful',
          token: 'test_token_123',
          user: UserDto(
            Id: '1',
            firstName: 'John',
            lastName: 'Doe',
            email: 'test@example.com',
            role: 'user',
          ),
        );

        when(mockApiServices.signIn(request: anyNamed('request')))
            .thenAnswer((_) async => responseDto);

        // Act
        final result = await authRemoteDataSource.signin(request: requestEntity);

        // Assert
        expect(result, isA<ApiSuccessResult<SigninResponseEntity>>());
        final successResult = result as ApiSuccessResult<SigninResponseEntity>;

        expect(successResult.data.message, equals('Login successful'));
        expect(successResult.data.token, equals('test_token_123'));
        expect(successResult.data.user?.email, equals('test@example.com'));
        expect(successResult.data.user?.firstName, equals('John'));

        verify(mockApiServices.signIn(request: anyNamed('request'))).called(1);
      });

      test('should return ApiErrorResult with ServerFailure when DioException occurs', () async {
        // Arrange
        final requestEntity = SigninRequestEntity(
          email: 'test@example.com',
          password: 'wrong_password',
        );

        final dioException = DioException(
          requestOptions: RequestOptions(path: '/signin'),
          message: 'Invalid credentials',
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: RequestOptions(path: '/signin'),
            statusCode: 401,
            data: {'message': 'Invalid credentials'},
          ),
        );

        when(mockApiServices.signIn(request: anyNamed('request')))
            .thenThrow(dioException);

        // Act
        final result = await authRemoteDataSource.signin(request: requestEntity);

        // Assert
        expect(result, isA<ApiErrorResult<SigninResponseEntity>>());
        final errorResult = result as ApiErrorResult<SigninResponseEntity>;

        expect(errorResult.failure, isA<ServerFailure>());
        verify(mockApiServices.signIn(request: anyNamed('request'))).called(1);
      });

      test('should return ApiErrorResult with generic Failure when other exception occurs', () async {
        // Arrange
        final requestEntity = SigninRequestEntity(
          email: 'test@example.com',
          password: 'password123',
        );

        const errorMessage = 'Unexpected error occurred';
        when(mockApiServices.signIn(request: anyNamed('request')))
            .thenThrow(Exception(errorMessage));

        // Act
        final result = await authRemoteDataSource.signin(request: requestEntity);

        // Assert
        expect(result, isA<ApiErrorResult<SigninResponseEntity>>());
        final errorResult = result as ApiErrorResult<SigninResponseEntity>;

        expect(errorResult.failure, isA<Failure>());
        expect(errorResult.failure.errorMessage, contains(errorMessage));
        verify(mockApiServices.signIn(request: anyNamed('request'))).called(1);
      });

      test('should call signIn with correct DTO converted from entity', () async {
        // Arrange
        final requestEntity = SigninRequestEntity(
          email: 'test@example.com',
          password: 'password123',
        );

        final responseDto = SigninResponseDto(
          message: 'Login successful',
          token: 'test_token_123',
          user: null,
        );

        when(mockApiServices.signIn(request: anyNamed('request')))
            .thenAnswer((_) async => responseDto);

        // Act
        await authRemoteDataSource.signin(request: requestEntity);

        // Assert
        final captured = verify(mockApiServices.signIn(request: captureAnyNamed('request'))).captured;
        final capturedDto = captured.first as SigninRequestDto;

        expect(capturedDto.email, equals('test@example.com'));
        expect(capturedDto.password, equals('password123'));
      });

      test('should handle null user in response correctly', () async {
        // Arrange
        final requestEntity = SigninRequestEntity(
          email: 'test@example.com',
          password: 'password123',
        );

        final responseDto = SigninResponseDto(
          message: 'Login successful',
          token: 'test_token_123',
          user: null,
        );

        when(mockApiServices.signIn(request: anyNamed('request')))
            .thenAnswer((_) async => responseDto);

        // Act
        final result = await authRemoteDataSource.signin(request: requestEntity);

        // Assert
        expect(result, isA<ApiSuccessResult<SigninResponseEntity>>());
        final successResult = result as ApiSuccessResult<SigninResponseEntity>;

        expect(successResult.data.message, equals('Login successful'));
        expect(successResult.data.token, equals('test_token_123'));
        expect(successResult.data.user, isNull);
      });
    });
  });
}