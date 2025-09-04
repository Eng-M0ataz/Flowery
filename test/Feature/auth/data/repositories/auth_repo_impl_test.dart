import 'package:flower_e_commerce_app/Feature/auth/data/repositories/auth_repo_impl.dart';
import 'package:flower_e_commerce_app/Feature/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/auth/data/dataSources/auth_local_data_source.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/request/forget_password_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/request/reset_password_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/request/verify_reset_code_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/request/sign_up_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/response/forget_password_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/response/reset_password_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/response/verify_reset_code_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/response/sign_up_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entity/request/sign_in_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entity/response/sign_in_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSource, AuthLocalDataSource])
void main() {
  late MockAuthRemoteDataSource mockRemote;
  late MockAuthLocalDataSource mockLocal;
  late AuthRepoImpl repo;

  setUpAll(() {
    provideDummy<ApiResult<ForgetPasswordResponseEntity>>(
      ApiSuccessResult<ForgetPasswordResponseEntity>(
        data: ForgetPasswordResponseEntity(message: '', info: ''),
      ),
    );
    provideDummy<ApiResult<VerifyResetCodeResponseEntity>>(
      ApiSuccessResult<VerifyResetCodeResponseEntity>(
        data: VerifyResetCodeResponseEntity(status: ''),
      ),
    );
    provideDummy<ApiResult<ResetPasswordResponseEntity>>(
      ApiSuccessResult<ResetPasswordResponseEntity>(
        data: ResetPasswordResponseEntity(message: '', token: ''),
      ),
    );
    provideDummy<ApiResult<SignUpResponseEntity>>(
      ApiSuccessResult<SignUpResponseEntity>(
        data: SignUpResponseEntity(message: '',
            token: '',
            user:
              UserEntity(
                id: 'id',
                firstName: 'firstName',
                lastName: 'lastName',
                email: 'email',
                gender: 'email',
                phone: 'phone',
                photo: 'photo',
                role: 'role',
                wishlist: [],
                addresses: [],
                createdAt: DateTime.now(),
              ),
        ),
      ),
    );
    provideDummy<ApiResult<SigninResponseEntity>>(
      ApiSuccessResult<SigninResponseEntity>(
        data: SigninResponseEntity(message: '', user: null, token: ''),
      ),
    );
    provideDummy<ApiResult<void>>(
      ApiSuccessResult<void>(data: null),
    );
  });

  setUp(() {
    mockRemote = MockAuthRemoteDataSource();
    mockLocal = MockAuthLocalDataSource();
    repo = AuthRepoImpl(
      authRemoteDataSource: mockRemote,
      authLocalDataSource: mockLocal,
    );
  });

  group('forgetPassword', () {
    final request = ForgetPasswordRequestEntity(email: 'test@example.com');
    final responseEntity =
    ForgetPasswordResponseEntity(message: 'Email sent', info: '');

    test('delegates to data source and returns success', () async {
      when(mockRemote.forgetPassword(any)).thenAnswer((_) async =>
          ApiSuccessResult<ForgetPasswordResponseEntity>(data: responseEntity));

      final result = await repo.forgetPassword(request);

      expect(result, isA<ApiSuccessResult<ForgetPasswordResponseEntity>>());
      final success = result as ApiSuccessResult<ForgetPasswordResponseEntity>;
      expect(success.data.message, responseEntity.message);

      verify(mockRemote.forgetPassword(request)).called(1);
    });

    test('delegates to data source and returns error', () async {
      final failure = Failure(errorMessage: 'Network');
      when(mockRemote.forgetPassword(any)).thenAnswer((_) async =>
          ApiErrorResult<ForgetPasswordResponseEntity>(failure: failure));

      final result = await repo.forgetPassword(request);

      expect(result, isA<ApiErrorResult<ForgetPasswordResponseEntity>>());
      final error = result as ApiErrorResult<ForgetPasswordResponseEntity>;
      expect(error.failure.errorMessage, 'Network');

      verify(mockRemote.forgetPassword(request)).called(1);
    });
  });

  group('verifyResetCode', () {
    final request = VerifyResetCodeRequestEntity(resetCode: '123456');
    final responseEntity =
    VerifyResetCodeResponseEntity(status: 'Code verified');

    test('delegates to data source and returns success', () async {
      when(mockRemote.verifyResetCode(any)).thenAnswer((_) async =>
          ApiSuccessResult<VerifyResetCodeResponseEntity>(
              data: responseEntity));

      final result = await repo.verifyResetCode(request);

      expect(result, isA<ApiSuccessResult<VerifyResetCodeResponseEntity>>());
      final success = result as ApiSuccessResult<VerifyResetCodeResponseEntity>;
      expect(success.data.status, responseEntity.status);

      verify(mockRemote.verifyResetCode(request)).called(1);
    });

    test('delegates to data source and returns error', () async {
      final failure = Failure(errorMessage: 'Unexpected error');
      when(mockRemote.verifyResetCode(any)).thenAnswer((_) async =>
          ApiErrorResult<VerifyResetCodeResponseEntity>(failure: failure));

      final result = await repo.verifyResetCode(request);

      expect(result, isA<ApiErrorResult<VerifyResetCodeResponseEntity>>());
      final error = result as ApiErrorResult<VerifyResetCodeResponseEntity>;
      expect(error.failure.errorMessage, 'Unexpected error');

      verify(mockRemote.verifyResetCode(request)).called(1);
    });
  });

  group('resetPassword', () {
    final request = ResetPasswordRequestEntity(
        email: 'test@example.com', newPassword: '123456');
    final responseEntity = ResetPasswordResponseEntity(
        message: 'Password reset successful', token: 'token');

    test('delegates to data source and returns success', () async {
      when(mockRemote.resetPassword(any)).thenAnswer((_) async =>
          ApiSuccessResult<ResetPasswordResponseEntity>(data: responseEntity));

      final result = await repo.resetPassword(request);

      expect(result, isA<ApiSuccessResult<ResetPasswordResponseEntity>>());
      final success = result as ApiSuccessResult<ResetPasswordResponseEntity>;
      expect(success.data.message, responseEntity.message);

      verify(mockRemote.resetPassword(request)).called(1);
    });

    test('delegates to data source and returns error', () async {
      final failure = Failure(errorMessage: 'ServerFailure');
      when(mockRemote.resetPassword(any)).thenAnswer((_) async =>
          ApiErrorResult<ResetPasswordResponseEntity>(failure: failure));

      final result = await repo.resetPassword(request);

      expect(result, isA<ApiErrorResult<ResetPasswordResponseEntity>>());
      final error = result as ApiErrorResult<ResetPasswordResponseEntity>;
      expect(error.failure.errorMessage, 'ServerFailure');

      verify(mockRemote.resetPassword(request)).called(1);
    });
  });

  group('signUp', () {
    final request = SignUpRequestEntity(

      firstName: 'Test First',
      lastName: 'Test Second',
      email: 'test@example.com',
      password: 'password123',
      rePassword: 'password123',
      phone: '1234567890',
      gender: 'Test Gender',
    );
    final responseEntity = SignUpResponseEntity(message: '',
      token: '',
      user:
      UserEntity(
        id: 'id',
        firstName: 'firstName',
        lastName: 'lastName',
        email: 'email',
        gender: 'email',
        phone: 'phone',
        photo: 'photo',
        role: 'role',
        wishlist: [],
        addresses: [],
        createdAt: DateTime.now(),
      ),
    );

    test('delegates to data source and returns success', () async {
      when(mockRemote.signup(any)).thenAnswer((_) async =>
          ApiSuccessResult<SignUpResponseEntity>(data: responseEntity));

      final result = await repo.signUp(request);

      expect(result, isA<ApiSuccessResult<SignUpResponseEntity>>());
      final success = result as ApiSuccessResult<SignUpResponseEntity>;
      expect(success.data.message, responseEntity.message);

      verify(mockRemote.signup(request)).called(1);
    });

    test('delegates to data source and returns error', () async {
      final failure = Failure(errorMessage: 'Validation error');
      when(mockRemote.signup(any)).thenAnswer((_) async =>
          ApiErrorResult<SignUpResponseEntity>(failure: failure));

      final result = await repo.signUp(request);

      expect(result, isA<ApiErrorResult<SignUpResponseEntity>>());
      final error = result as ApiErrorResult<SignUpResponseEntity>;
      expect(error.failure.errorMessage, 'Validation error');

      verify(mockRemote.signup(request)).called(1);
    });
  });

  group('signIn', () {
    const email = 'test@example.com';
    const password = 'password123';
    const token = 'auth_token_123';
    final responseEntity = SigninResponseEntity(
      message: 'Sign in successful',
      user: null,
      token: token,
    );

    test('delegates to remote data source and saves token locally on success', () async {
      // Mock remote sign in
      when(mockRemote.signin(
          request: SigninRequestEntity(
              email: email,
              password: password
          )
      ))
          .thenAnswer((_) async =>
          ApiSuccessResult<SigninResponseEntity>(data: responseEntity));

      // Mock local token storage
      when(mockLocal.writeToken(token: token))
          .thenAnswer((_) async => ApiSuccessResult<void>(data: null));

      final result = await repo.signin(
          request: SigninRequestEntity(
              email: email,
              password: password
          ),
        rememberMeChecked: await mockLocal.getRememberMe()
      );

      expect(result, isA<ApiSuccessResult<SigninResponseEntity>>());
      final success = result as ApiSuccessResult<SigninResponseEntity>;
      expect(success.data.message, responseEntity.message);
      expect(success.data.token, token);

      verify(mockRemote.signin(
        request: SigninRequestEntity(email: email, password: password)
      )).called(1);
      verify(mockLocal.writeToken(token: token)).called(1);
    });

    test('returns error when remote sign in fails', () async {
      final failure = Failure(errorMessage: 'Invalid credentials');
      when(mockRemote.signin(
        request: SigninRequestEntity(email: email, password: password)
      ))
          .thenAnswer((_) async =>
          ApiErrorResult<SigninResponseEntity>(failure: failure));

      final result = await repo.signin(
        request: SigninRequestEntity(email: email, password: password),
        rememberMeChecked:  await mockLocal.getRememberMe()
      );

      expect(result, isA<ApiErrorResult<SigninResponseEntity>>());
      final error = result as ApiErrorResult<SigninResponseEntity>;
      expect(error.failure.errorMessage, 'Invalid credentials');

      verify(mockRemote.signin(
        request: SigninRequestEntity(email: email, password: password)
      )).called(1);
      verifyNever(mockLocal.writeToken(token: anyNamed('token')));
    });

    test('returns error when local token storage fails', () async {
      // Mock successful remote sign in
      when(mockRemote.signin(
        request: SigninRequestEntity(email: email, password: password)
      ))
          .thenAnswer((_) async =>
          ApiSuccessResult<SigninResponseEntity>(data: responseEntity));

      // Mock local storage failure
      final localFailure = Failure(errorMessage: 'Storage error');
      when(mockLocal.writeToken(token: token))
          .thenAnswer((_) async => ApiErrorResult<void>(failure: localFailure));

      final result = await repo.signin(
        request: SigninRequestEntity(email: email, password: password),
            rememberMeChecked: await mockLocal.getRememberMe()
      );

      expect(result, isA<ApiErrorResult<SigninResponseEntity>>());
      final error = result as ApiErrorResult<SigninResponseEntity>;
      expect(error.failure.errorMessage, 'Storage error');

      verify(mockRemote.signin(
        request: SigninRequestEntity(email: email, password: password)
      )).called(1);
      verify(mockLocal.writeToken(token: token)).called(1);
    });
  });

  group('signUp', () {
    final request = SignUpRequestEntity(
      firstName: 'Test First',
      lastName: 'Test Second',
      email: 'test@example.com',
      password: 'password123',
      rePassword: 'password123',
      phone: '1234567890',
      gender: 'Test Gender',
    );
    final responseEntity = SignUpResponseEntity(message: '',
      token: '',
      user:
      UserEntity(
        id: 'id',
        firstName: 'firstName',
        lastName: 'lastName',
        email: 'email',
        gender: 'email',
        phone: 'phone',
        photo: 'photo',
        role: 'role',
        wishlist: [],
        addresses: [],
        createdAt: DateTime.now(),
      ),
    );

    test('delegates to data source and returns success', () async {
      when(mockRemote.signup(any)).thenAnswer((_) async =>
          ApiSuccessResult<SignUpResponseEntity>(data: responseEntity));

      final result = await repo.signUp(request);

      expect(result, isA<ApiSuccessResult<SignUpResponseEntity>>());
      final success = result as ApiSuccessResult<SignUpResponseEntity>;
      expect(success.data.message, responseEntity.message);

      verify(mockRemote.signup(request)).called(1);
    });

    test('delegates to data source and returns error', () async {
      final failure = Failure(errorMessage: 'Validation error');
      when(mockRemote.signup(any)).thenAnswer((_) async =>
          ApiErrorResult<SignUpResponseEntity>(failure: failure));

      final result = await repo.signUp(request);

      expect(result, isA<ApiErrorResult<SignUpResponseEntity>>());
      final error = result as ApiErrorResult<SignUpResponseEntity>;
      expect(error.failure.errorMessage, 'Validation error');

      verify(mockRemote.signup(request)).called(1);
    });
  });

  group('signIn', () {
    const email = 'test@example.com';
    const password = 'password123';
    const token = 'auth_token_123';
    final responseEntity = SigninResponseEntity(
      message: 'Sign in successful',
      user: null,
      token: token,
    );

    test('delegates to remote data source and saves token locally on success', () async {
      // Mock remote sign in
      when(mockRemote.signin(
        request: SigninRequestEntity(email: email, password: password)
      ))
          .thenAnswer((_) async =>
          ApiSuccessResult<SigninResponseEntity>(data: responseEntity));

      // Mock local token storage
      when(mockLocal.writeToken(token: token))
          .thenAnswer((_) async => ApiSuccessResult<void>(data: null));

      final result = await repo.signin(
        request:  SigninRequestEntity(email: email, password: password),
        rememberMeChecked: await mockLocal.getRememberMe()
      );

      expect(result, isA<ApiSuccessResult<SigninResponseEntity>>());
      final success = result as ApiSuccessResult<SigninResponseEntity>;
      expect(success.data.message, responseEntity.message);
      expect(success.data.token, token);

      verify(mockRemote.signin(
        request: SigninRequestEntity(email: email, password: password)
      )).called(1);
      verify(mockLocal.writeToken(token: token)).called(1);
    });

    test('returns error when remote sign in fails', () async {
      final failure = Failure(errorMessage: 'Invalid credentials');
      when(mockRemote.signin(
        request: SigninRequestEntity(email: email, password: password)
      ))
          .thenAnswer((_) async =>
          ApiErrorResult<SigninResponseEntity>(failure: failure));

      final result = await repo.signin(
        request: SigninRequestEntity(email: email, password: password),
        rememberMeChecked: await mockLocal.getRememberMe()
      );

      expect(result, isA<ApiErrorResult<SigninResponseEntity>>());
      final error = result as ApiErrorResult<SigninResponseEntity>;
      expect(error.failure.errorMessage, 'Invalid credentials');

      verify(mockRemote.signin(
          request: SigninRequestEntity(email: email, password: password)
      )).called(1);
      verifyNever(mockLocal.writeToken(token: anyNamed('token')));
    });

    test('still returns success when token is null or empty', () async {
      final responseWithoutToken = SigninResponseEntity(
        message: 'Sign in successful',
        user: null,
        token: null,
      );

      when(mockRemote.signin(
          request: SigninRequestEntity(email: email, password: password)
      ))
          .thenAnswer((_) async =>
          ApiSuccessResult<SigninResponseEntity>(data: responseWithoutToken));

      final result = await repo.signin(
          request: SigninRequestEntity(email: email, password: password),
          rememberMeChecked: await mockLocal.getRememberMe()
      );

      expect(result, isA<ApiSuccessResult<SigninResponseEntity>>());
      final success = result as ApiSuccessResult<SigninResponseEntity>;
      expect(success.data.message, responseWithoutToken.message);

      verify(mockRemote.signin(
          request: SigninRequestEntity(email: email, password: password)
      )).called(1);
      verifyNever(mockLocal.writeToken(token: anyNamed('token')));
    });
  });

  group('isGuest', () {
    test('delegates to local data source and returns success', () async {
      when(mockLocal.isGuest()).thenAnswer((_) async =>
          ApiSuccessResult<void>(data: null));

      final result = await repo.isGuest();

      expect(result, isA<ApiSuccessResult<void>>());

      verify(mockLocal.isGuest()).called(1);
    });

    test('delegates to local data source and returns error', () async {
      final failure = Failure(errorMessage: 'Storage error');
      when(mockLocal.isGuest()).thenAnswer((_) async =>
          ApiErrorResult<void>(failure: failure));

      final result = await repo.isGuest();

      expect(result, isA<ApiErrorResult<void>>());
      final error = result as ApiErrorResult<void>;
      expect(error.failure.errorMessage, 'Storage error');

      verify(mockLocal.isGuest()).called(1);
    });
  });
}