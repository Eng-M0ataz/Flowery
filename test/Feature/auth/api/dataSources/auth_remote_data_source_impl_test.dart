import 'package:dio/dio.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/client/api_service.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/dataSources/auth_remote_data_source_impl.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/model/responses/sign_in_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/model/responses/user_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entity/request/sign_in_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entity/response/sign_in_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late MockApiServices apiServices;
  late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;

  setUp((){
    apiServices = MockApiServices();
    authRemoteDataSourceImpl = AuthRemoteDataSourceImpl(apiServices);
  });

  group('signIn', (){
    final requestEntity = SigninRequestEntity(
      email: 'test@example.com',
      password: 'pass123456'
    );
    final responseDto = SigninResponseDto(
      message: 'success',
      token: 'auth_token_123',
      user: UserDto(
        Id: '1',
        firstName: 'yassen',
        lastName: 'Ahmed',
        gender: 'male',
        email: 'john@example.com',
        phone: '+1234567890',
        addresses: [],
        createdAt: DateTime(2023, 1, 1).toString(),
        photo: '',
        wishlist: [],
        role: 'customer',
      )
    );

    final responseEntity = responseDto.toEntity();

    test('should return ApiSuccessResult when api call is successful',
        () async{
          // Arrange
          when(apiServices.signIn(request: any)).thenAnswer((_) async => responseDto);

          // Act
          final result = await authRemoteDataSourceImpl.signin(request: requestEntity);

          // Assert
          expect(result, isA<ApiSuccessResult<SigninResponseEntity>>());
          final success = result as ApiSuccessResult<SigninResponseEntity>;
          expect(success.data.message, responseEntity.message);
          expect(success.data.user?.firstName, responseEntity.user?.firstName);
          expect(success.data.user?.lastName, responseEntity.user?.lastName);
          expect(success.data.user?.email, responseEntity.user?.email);
          expect(success.data.user?.gender, responseEntity.user?.gender);
          expect(success.data.user?.phone, responseEntity.user?.phone);
          expect(success.data.user?.role, responseEntity.user?.role);
          expect(success.data.token, responseEntity.token);
          
          verify(apiServices.signIn(request: any)).called(1);
        });
    
    test('should return ApiErrorResult with ServerFailure when DioException thrown',
        () async {
          //Arrange
          final dioException = DioException(
            requestOptions: RequestOptions(path: '/signin'),
            response: Response(
              requestOptions: RequestOptions(path: '/signin'),
              statusCode: 400,
              data: {'message': 'Email already exists'}
            ),
          );

          when(apiServices.signIn(request: any)).thenThrow(dioException);

          // Act
          final result = await authRemoteDataSourceImpl.signin(request: requestEntity);
          
          // Assert
          expect(result, isA<ApiErrorResult<SigninResponseEntity>>());
          final error = result as ApiErrorResult<SigninResponseEntity>;
          expect(error.failure, isA<ServerFailure>());
          
          verify(apiServices.signIn(request: any)).called(1);
        });
    
    test('should return ApiErrorResult with ServerFailure when generic exception thrown',
        () async{
          // Arrange
          when(apiServices.signIn(request: any))
              .thenThrow(Exception('Network connection failed'));

          // Act
          final result = await authRemoteDataSourceImpl.signin(request: requestEntity);

          // Assert
          expect(result, isA<ApiErrorResult<SigninResponseEntity>>());
          final error = result as ApiErrorResult<SigninResponseEntity>;
          expect(error.failure, isA<ServerFailure>());
          expect(error.failure.errorMessage, contains('Unexpected error occurred'));
          expect(error.failure.errorMessage, contains('Network connection failed'));

          verify(apiServices.signIn(request: any)).called(1);
        });

    test('should call signIn with correct SigninRequestDto', () async {
      // Arrange
      when(apiServices.signIn(request: any)).thenAnswer((_) async => responseDto);

      // Act
      await authRemoteDataSourceImpl.signin(request: requestEntity);

      // Assert
      final captured = verify(apiServices.signIn(request: captureAny)).captured;
      final capturedDto = captured.first as SigninRequestEntity;

      expect(capturedDto.email, requestEntity.email);
      expect(capturedDto.password, requestEntity.password);
    });

    test('should handle DioException with specific error response', () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/signin'),
        response: Response(
          requestOptions: RequestOptions(path: '/signin'),
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

      when(apiServices.signIn(request: any)).thenThrow(dioException);

      // Act
      final result = await authRemoteDataSourceImpl.signin(request: requestEntity);

      // Assert
      expect(result, isA<ApiErrorResult<SigninResponseEntity>>());
      final error = result as ApiErrorResult<SigninResponseEntity>;
      expect(error.failure, isA<ServerFailure>());
      // The exact error message will depend on your ServerFailure.fromDioError implementation

      verify(apiServices.signIn(request: any)).called(1);
    });
  });
}