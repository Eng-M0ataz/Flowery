import 'package:flower_e_commerce_app/Feature/auth/api/dataSources/auth_local_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:flower_e_commerce_app/core/Services/storage_interface.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/app_constants.dart';

import 'auth_local_data_source_impl_test.mocks.dart';

@GenerateMocks([Storage])
void main() {
  late AuthLocalDataSourceImpl authLocalDataSource;
  late MockStorage mockStorage;

  setUp(() {
    mockStorage = MockStorage();
    authLocalDataSource = AuthLocalDataSourceImpl(mockStorage);
  });

  group('AuthLocalDataSourceImpl Tests', () {
    group('writeToken', () {
      test('should write token successfully and return ApiSuccessResult',
          () async {
        // Arrange
        const token = 'test_token_123';
        when(mockStorage.write(key: AppConstants.token, value: token))
            .thenAnswer((_) async => {});

        // Act
        final result = await authLocalDataSource.writeToken(token: token);

        // Assert
        expect(result, isA<ApiSuccessResult<void>>());
        verify(mockStorage.write(key: AppConstants.token, value: token))
            .called(1);
      });

      test('should return ApiErrorResult when storage write fails', () async {
        // Arrange
        const token = 'test_token_123';
        const errorMessage = 'Storage write failed';
        when(mockStorage.write(key: AppConstants.token, value: token))
            .thenThrow(Exception(errorMessage));

        // Act
        final result = await authLocalDataSource.writeToken(token: token);

        // Assert
        expect(result, isA<ApiErrorResult<void>>());
        final error = result as ApiErrorResult<void>;
        expect(error.failure.errorMessage, contains(errorMessage));
        verify(mockStorage.write(key: AppConstants.token, value: token))
            .called(1);
      });
    });

    group('setRememberMe', () {
      test('should set remember me to true and return ApiSuccessResult',
          () async {
        // Arrange
        const rememberMe = true;
        when(mockStorage.write(key: AppConstants.rememberMe, value: 'true'))
            .thenAnswer((_) async => {});

        // Act
        final result =
            await authLocalDataSource.setRememberMe(rememberMe: rememberMe);

        // Assert
        expect(result, isA<ApiSuccessResult<void>>());
        verify(mockStorage.write(key: AppConstants.rememberMe, value: 'true'))
            .called(1);
      });

      test('should set remember me to false and return ApiSuccessResult',
          () async {
        // Arrange
        const rememberMe = false;
        when(mockStorage.write(key: AppConstants.rememberMe, value: 'false'))
            .thenAnswer((_) async => {});

        // Act
        final result =
            await authLocalDataSource.setRememberMe(rememberMe: rememberMe);

        // Assert
        expect(result, isA<ApiSuccessResult<void>>());
        verify(mockStorage.write(key: AppConstants.rememberMe, value: 'false'))
            .called(1);
      });

      test('should return ApiErrorResult when storage write fails', () async {
        // Arrange
        const rememberMe = true;
        const errorMessage = 'Storage write failed';
        when(mockStorage.write(key: AppConstants.rememberMe, value: 'true'))
            .thenThrow(Exception(errorMessage));

        // Act
        final result =
            await authLocalDataSource.setRememberMe(rememberMe: rememberMe);

        // Assert
        expect(result, isA<ApiErrorResult<void>>());
        final error = result as ApiErrorResult<void>;
        expect(error.failure.errorMessage, contains(errorMessage));
      });
    });

    group('getRememberMe', () {
      test('should return true when stored value is "true"', () async {
        // Arrange
        when(mockStorage.read(key: AppConstants.rememberMe))
            .thenAnswer((_) async => 'true');

        // Act
        final result = await authLocalDataSource.getRememberMe();

        // Assert
        expect(result, isTrue);
        verify(mockStorage.read(key: AppConstants.rememberMe)).called(1);
      });

      test('should return true when stored value is "TRUE" (case insensitive)',
          () async {
        // Arrange
        when(mockStorage.read(key: AppConstants.rememberMe))
            .thenAnswer((_) async => 'TRUE');

        // Act
        final result = await authLocalDataSource.getRememberMe();

        // Assert
        expect(result, isTrue);
      });

      test('should return false when stored value is "false"', () async {
        // Arrange
        when(mockStorage.read(key: AppConstants.rememberMe))
            .thenAnswer((_) async => 'false');

        // Act
        final result = await authLocalDataSource.getRememberMe();

        // Assert
        expect(result, isFalse);
        verify(mockStorage.read(key: AppConstants.rememberMe)).called(1);
      });

      test('should return false when stored value is not "true"', () async {
        // Arrange
        when(mockStorage.read(key: AppConstants.rememberMe))
            .thenAnswer((_) async => 'some_other_value');

        // Act
        final result = await authLocalDataSource.getRememberMe();

        // Assert
        expect(result, isFalse);
      });
    });
  });
}
