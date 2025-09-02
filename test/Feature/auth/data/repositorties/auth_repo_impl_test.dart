import 'package:flower_e_commerce_app/Feature/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_e_commerce_app/Feature/auth/data/dataSources/auth_local_data_source.dart';
import 'package:flower_e_commerce_app/Feature/auth/data/repositories/auth_repo_impl.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entity/request/sign_in_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entity/response/sign_in_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entity/response/user_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import '../../../../test_helpers.dart';
import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource, AuthLocalDataSource])
void main() {
  setUpAll(() {
    setupDummyValues();
  });
  late AuthRepoImpl authRepo;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late MockAuthLocalDataSource mockAuthLocalDataSource;

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    mockAuthLocalDataSource = MockAuthLocalDataSource();
    authRepo = AuthRepoImpl(mockAuthRemoteDataSource, mockAuthLocalDataSource);
  });

  group('AuthRepoImpl Tests', () {
    group('signin', () {
      test('should return success result and save token when remote signin succeeds', () async {
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
          token: 'test_token_123',
        );

        final successResult = ApiSuccessResult<SigninResponseEntity>(data: responseEntity);

        when(mockAuthRemoteDataSource.signin(request: request))
            .thenAnswer((_) async => successResult);

        when(mockAuthLocalDataSource.writeToken(token: 'test_token_123'))
            .thenAnswer((_) async => ApiSuccessResult<void>(data: null));

        // Act
        final result = await authRepo.signin(
          request: request,
          rememberMeChecked: false,
        );

        // Assert
        expect(result, isA<ApiSuccessResult<SigninResponseEntity>>());
        expect(successResult.data.message, equals('Login successful'));
        expect(successResult.data.token, equals('test_token_123'));
        expect(successResult.data.user?.firstName, equals('John'));

        verify(mockAuthRemoteDataSource.signin(request: request)).called(1);
        verify(mockAuthLocalDataSource.writeToken(token: 'test_token_123')).called(1);
        verifyNever(mockAuthLocalDataSource.setRememberMe(rememberMe: anyNamed('rememberMe')));
      });

      test('should save token and set remember me when remember me is checked', () async {
        // Arrange
        final request = SigninRequestEntity(
          email: 'test@example.com',
          password: 'password123',
        );

        final responseEntity = SigninResponseEntity(
          message: 'Login successful',
          user: null,
          token: 'test_token_123',
        );

        final successResult = ApiSuccessResult<SigninResponseEntity>(data: responseEntity);

        when(mockAuthRemoteDataSource.signin(request: request))
            .thenAnswer((_) async => successResult);

        when(mockAuthLocalDataSource.writeToken(token: 'test_token_123'))
            .thenAnswer((_) async => ApiSuccessResult<void>(data: null));

        when(mockAuthLocalDataSource.setRememberMe(rememberMe: true))
            .thenAnswer((_) async => ApiSuccessResult<void>(data: null));

        // Act
        final result = await authRepo.signin(
          request: request,
          rememberMeChecked: true,
        );

        // Assert
        expect(result, isA<ApiSuccessResult<SigninResponseEntity>>());
        verify(mockAuthRemoteDataSource.signin(request: request)).called(1);
        verify(mockAuthLocalDataSource.writeToken(token: 'test_token_123')).called(1);
        verify(mockAuthLocalDataSource.setRememberMe(rememberMe: true)).called(1);
      });

      test('should not save token when token is null', () async {
        // Arrange
        final request = SigninRequestEntity(
          email: 'test@example.com',
          password: 'password123',
        );

        final responseEntity = SigninResponseEntity(
          message: 'Login successful',
          user: null,
          token: null,
        );

        final successResult = ApiSuccessResult<SigninResponseEntity>(data: responseEntity);

        when(mockAuthRemoteDataSource.signin(request: request))
            .thenAnswer((_) async => successResult);

        // Act
        final result = await authRepo.signin(
          request: request,
          rememberMeChecked: true,
        );

        // Assert
        expect(result, isA<ApiSuccessResult<SigninResponseEntity>>());
        verify(mockAuthRemoteDataSource.signin(request: request)).called(1);
        verifyNever(mockAuthLocalDataSource.writeToken(token: anyNamed('token')));
        verifyNever(mockAuthLocalDataSource.setRememberMe(rememberMe: anyNamed('rememberMe')));
      });

      test('should not save token when token is empty', () async {
        // Arrange
        final request = SigninRequestEntity(
          email: 'test@example.com',
          password: 'password123',
        );

        final responseEntity = SigninResponseEntity(
          message: 'Login successful',
          user: null,
          token: '',
        );

        final successResult = ApiSuccessResult<SigninResponseEntity>(data: responseEntity);

        when(mockAuthRemoteDataSource.signin(request: request))
            .thenAnswer((_) async => successResult);

        // Act
        final result = await authRepo.signin(
          request: request,
          rememberMeChecked: true,
        );

        // Assert
        expect(result, isA<ApiSuccessResult<SigninResponseEntity>>());
        verify(mockAuthRemoteDataSource.signin(request: request)).called(1);
        verifyNever(mockAuthLocalDataSource.writeToken(token: anyNamed('token')));
        verifyNever(mockAuthLocalDataSource.setRememberMe(rememberMe: anyNamed('rememberMe')));
      });

      test('should return error result when remote signin fails', () async {
        // Arrange
        final request = SigninRequestEntity(
          email: 'test@example.com',
          password: 'wrong_password',
        );

        final failure = Failure(errorMessage: 'Invalid credentials');
        final errorResult = ApiErrorResult<SigninResponseEntity>(failure: failure);

        when(mockAuthRemoteDataSource.signin(request: request))
            .thenAnswer((_) async => errorResult);

        // Act
        final result = await authRepo.signin(
          request: request,
          rememberMeChecked: false,
        );

        // Assert
        expect(result, isA<ApiErrorResult<SigninResponseEntity>>());
        final error = result as ApiErrorResult<SigninResponseEntity>;
        expect(error.failure.errorMessage, equals('Invalid credentials'));

        verify(mockAuthRemoteDataSource.signin(request: request)).called(1);
        verifyNever(mockAuthLocalDataSource.writeToken(token: anyNamed('token')));
        verifyNever(mockAuthLocalDataSource.setRememberMe(rememberMe: anyNamed('rememberMe')));
      });

      test('should still return success even if local storage operations fail', () async {
        // Arrange
        final request = SigninRequestEntity(
          email: 'test@example.com',
          password: 'password123',
        );

        final responseEntity = SigninResponseEntity(
          message: 'Login successful',
          user: null,
          token: 'test_token_123',
        );

        final successResult = ApiSuccessResult<SigninResponseEntity>(data: responseEntity);

        when(mockAuthRemoteDataSource.signin(request: request))
            .thenAnswer((_) async => successResult);

        when(mockAuthLocalDataSource.writeToken(token: 'test_token_123'))
            .thenThrow((_) async => ApiErrorResult<void>(failure: Failure(errorMessage: "Storage error")));

        // Act
        final result = await authRepo.signin(
          request: request,
          rememberMeChecked: false,
        );

        // Assert
        expect(result, isA<ApiSuccessResult<SigninResponseEntity>>());
        verify(mockAuthRemoteDataSource.signin(request: request)).called(1);
        verify(mockAuthLocalDataSource.writeToken(token: 'test_token_123')).called(1);
      });

      test('should handle remember me false correctly', () async {
        // Arrange
        final request = SigninRequestEntity(
          email: 'test@example.com',
          password: 'password123',
        );

        final responseEntity = SigninResponseEntity(
          message: 'Login successful',
          user: null,
          token: 'test_token_123',
        );

        final successResult = ApiSuccessResult<SigninResponseEntity>(data: responseEntity);

        when(mockAuthRemoteDataSource.signin(request: request))
            .thenAnswer((_) async => successResult);

        when(mockAuthLocalDataSource.writeToken(token: 'test_token_123'))
            .thenAnswer((_) async => ApiSuccessResult<void>(data: null));

        // Act
        final result = await authRepo.signin(
          request: request,
          rememberMeChecked: false,
        );

        // Assert
        expect(result, isA<ApiSuccessResult<SigninResponseEntity>>());
        verify(mockAuthRemoteDataSource.signin(request: request)).called(1);
        verify(mockAuthLocalDataSource.writeToken(token: 'test_token_123')).called(1);
        verifyNever(mockAuthLocalDataSource.setRememberMe(rememberMe: anyNamed('rememberMe')));
      });

      test('should use default remember me value when not provided', () async {
        // Arrange
        final request = SigninRequestEntity(
          email: 'test@example.com',
          password: 'password123',
        );

        final responseEntity = SigninResponseEntity(
          message: 'Login successful',
          user: null,
          token: 'test_token_123',
        );

        final successResult = ApiSuccessResult<SigninResponseEntity>(data: responseEntity);

        when(mockAuthRemoteDataSource.signin(request: request))
            .thenAnswer((_) async => successResult);

        when(mockAuthLocalDataSource.writeToken(token: 'test_token_123'))
            .thenAnswer((_) async => ApiSuccessResult<void>(data: null));

        // Act
        final result = await authRepo.signin(request: request);

        // Assert
        expect(result, isA<ApiSuccessResult<SigninResponseEntity>>());
        verify(mockAuthRemoteDataSource.signin(request: request)).called(1);
        verify(mockAuthLocalDataSource.writeToken(token: 'test_token_123')).called(1);
        verifyNever(mockAuthLocalDataSource.setRememberMe(rememberMe: anyNamed('rememberMe')));
      });
    });
  });
}