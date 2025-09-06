import 'package:flower_e_commerce_app/Feature/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entity/request/sign_in_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entity/response/sign_in_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entity/response/user_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/repositories/auth_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';

import 'sign_in_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late SigninUseCase signinUseCase;
  late MockAuthRepo mockAuthRepo;

  setUp(() {
    mockAuthRepo = MockAuthRepo();
    signinUseCase = SigninUseCase(authRepo: mockAuthRepo);
  });

  group('SigninUseCase Tests', () {
    group('invoke', () {
      test('should return success result when repository signin succeeds', () async {
        // Arrange
        final request = SigninRequestEntity(
          email: 'test@example.com',
          password: 'password123',
        );

        final userEntity = UserEntity(
          Id: '1',
          firstName: 'John',
          lastName: 'Doe',
          email: 'test@example.com',
          role: 'user',
        );

        final responseEntity = SigninResponseEntity(
          message: 'Login successful',
          user: userEntity,
          token: 'jwt_token_123',
        );

        final successResult = ApiSuccessResult<SigninResponseEntity>(data: responseEntity);

        when(mockAuthRepo.signin(
          request: request,
          rememberMeChecked: false,
        )).thenAnswer((_) async => successResult);

        // Act
        final result = await signinUseCase.invoke(
          request: request,
          rememberMeChecked: false,
        );

        // Assert
        expect(result, isA<ApiSuccessResult<SigninResponseEntity>>());
        final success = result as ApiSuccessResult<SigninResponseEntity>;
        expect(success.data.message, equals('Login successful'));
        expect(success.data.token, equals('jwt_token_123'));
        expect(success.data.user?.firstName, equals('John'));
        expect(success.data.user?.email, equals('test@example.com'));

        verify(mockAuthRepo.signin(
          request: request,
          rememberMeChecked: false,
        )).called(1);
      });

      test('should return error result when repository signin fails', () async {
        // Arrange
        final request = SigninRequestEntity(
          email: 'test@example.com',
          password: 'wrong_password',
        );

        final failure = Failure(errorMessage: 'Invalid credentials');
        final errorResult = ApiErrorResult<SigninResponseEntity>(failure: failure);

        when(mockAuthRepo.signin(
          request: request,
          rememberMeChecked: false,
        )).thenAnswer((_) async => errorResult);

        // Act
        final result = await signinUseCase.invoke(
          request: request,
          rememberMeChecked: false,
        );

        // Assert
        expect(result, isA<ApiErrorResult<SigninResponseEntity>>());
        final error = result as ApiErrorResult<SigninResponseEntity>;
        expect(error.failure.errorMessage, equals('Invalid credentials'));

        verify(mockAuthRepo.signin(
          request: request,
          rememberMeChecked: false,
        )).called(1);
      });

      test('should pass remember me true correctly to repository', () async {
        // Arrange
        final request = SigninRequestEntity(
          email: 'test@example.com',
          password: 'password123',
        );

        final responseEntity = SigninResponseEntity(
          message: 'Login successful',
          token: 'jwt_token_123',
        );

        final successResult = ApiSuccessResult<SigninResponseEntity>(data: responseEntity);

        when(mockAuthRepo.signin(
          request: request,
          rememberMeChecked: true,
        )).thenAnswer((_) async => successResult);

        // Act
        final result = await signinUseCase.invoke(
          request: request,
          rememberMeChecked: true,
        );

        // Assert
        expect(result, isA<ApiSuccessResult<SigninResponseEntity>>());
        verify(mockAuthRepo.signin(
          request: request,
          rememberMeChecked: true,
        )).called(1);
      });

      test('should use default remember me value when not provided', () async {
        // Arrange
        final request = SigninRequestEntity(
          email: 'test@example.com',
          password: 'password123',
        );

        final responseEntity = SigninResponseEntity(
          message: 'Login successful',
          token: 'jwt_token_123',
        );

        final successResult = ApiSuccessResult<SigninResponseEntity>(data: responseEntity);

        when(mockAuthRepo.signin(
          request: request,
          rememberMeChecked: false,
        )).thenAnswer((_) async => successResult);

        // Act
        final result = await signinUseCase.invoke(request: request);

        // Assert
        expect(result, isA<ApiSuccessResult<SigninResponseEntity>>());
        verify(mockAuthRepo.signin(
          request: request,
          rememberMeChecked: false,
        )).called(1);
      });

      test('should handle null remember me parameter correctly', () async {
        // Arrange
        final request = SigninRequestEntity(
          email: 'test@example.com',
          password: 'password123',
        );

        final responseEntity = SigninResponseEntity(
          message: 'Login successful',
          token: 'jwt_token_123',
        );

        final successResult = ApiSuccessResult<SigninResponseEntity>(data: responseEntity);

        when(mockAuthRepo.signin(
          request: request,
          rememberMeChecked: null,
        )).thenAnswer((_) async => successResult);

        // Act
        final result = await signinUseCase.invoke(
          request: request,
          rememberMeChecked: null,
        );

        // Assert
        expect(result, isA<ApiSuccessResult<SigninResponseEntity>>());
        verify(mockAuthRepo.signin(
          request: request,
          rememberMeChecked: null,
        )).called(1);
      });

      test('should propagate server failure correctly', () async {
        // Arrange
        final request = SigninRequestEntity(
          email: 'test@example.com',
          password: 'password123',
        );

        final serverFailure = ServerFailure(
          errorMessage: 'Server error',
          code:'500',
        );
        final errorResult = ApiErrorResult<SigninResponseEntity>(failure: serverFailure);

        when(mockAuthRepo.signin(
          request: request,
          rememberMeChecked: false,
        )).thenAnswer((_) async => errorResult);

        // Act
        final result = await signinUseCase.invoke(
          request: request,
          rememberMeChecked: false,
        );

        // Assert
        expect(result, isA<ApiErrorResult<SigninResponseEntity>>());
        final error = result as ApiErrorResult<SigninResponseEntity>;
        expect(error.failure, isA<ServerFailure>());
        expect(error.failure.errorMessage, equals('Server error'));

        if (error.failure is ServerFailure) {
          final serverError = error.failure as ServerFailure;
          expect(serverError.errorMessage, equals(500));
        }
      });

      test('should handle different request entities correctly', () async {
        // Arrange
        final request1 = SigninRequestEntity(
          email: 'user1@example.com',
          password: 'password1',
        );

        final request2 = SigninRequestEntity(
          email: 'user2@example.com',
          password: 'password2',
        );

        final response1 = SigninResponseEntity(message: 'Success 1', token: 'token1');
        final response2 = SigninResponseEntity(message: 'Success 2', token: 'token2');

        when(mockAuthRepo.signin(
          request: request1,
          rememberMeChecked: false,
        )).thenAnswer((_) async => ApiSuccessResult<SigninResponseEntity>(data: response1));

        when(mockAuthRepo.signin(
          request: request2,
          rememberMeChecked: false,
        )).thenAnswer((_) async => ApiSuccessResult<SigninResponseEntity>(data: response2));

        // Act
        final result1 = await signinUseCase.invoke(request: request1);
        final result2 = await signinUseCase.invoke(request: request2);

        // Assert
        expect(result1, isA<ApiSuccessResult<SigninResponseEntity>>());
        expect(result2, isA<ApiSuccessResult<SigninResponseEntity>>());

        final success1 = result1 as ApiSuccessResult<SigninResponseEntity>;
        final success2 = result2 as ApiSuccessResult<SigninResponseEntity>;

        expect(success1.data.message, equals('Success 1'));
        expect(success1.data.token, equals('token1'));
        expect(success2.data.message, equals('Success 2'));
        expect(success2.data.token, equals('token2'));

        verify(mockAuthRepo.signin(request: request1, rememberMeChecked: false)).called(1);
        verify(mockAuthRepo.signin(request: request2, rememberMeChecked: false)).called(1);
      });

      test('should maintain use case state correctly between calls', () async {
        // Arrange
        final request = SigninRequestEntity(
          email: 'test@example.com',
          password: 'password123',
        );

        final responseEntity = SigninResponseEntity(
          message: 'Login successful',
          token: 'jwt_token_123',
        );

        final successResult = ApiSuccessResult<SigninResponseEntity>(data: responseEntity);

        when(mockAuthRepo.signin(
          request: request,
          rememberMeChecked: false,
        )).thenAnswer((_) async => successResult);

        // Act - Call multiple times
        final result1 = await signinUseCase.invoke(request: request);
        final result2 = await signinUseCase.invoke(request: request);

        // Assert
        expect(result1, isA<ApiSuccessResult<SigninResponseEntity>>());
        expect(result2, isA<ApiSuccessResult<SigninResponseEntity>>());

        verify(mockAuthRepo.signin(
          request: request,
          rememberMeChecked: false,
        )).called(2);
      });
    });
  });
}