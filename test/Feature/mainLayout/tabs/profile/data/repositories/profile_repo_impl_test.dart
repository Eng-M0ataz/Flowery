import 'dart:io';

import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/data/dataSources/profile_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/data/repositories/profile_repo_impl.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/request/edit_profile_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/edit_profile_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/logged_user_data_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/upload_photo_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_repo_impl_test.mocks.dart';

@GenerateMocks([ProfileRemoteDataSource])
void main() {
  late ProfileRepoImpl repoImpl;
  late MockProfileRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockProfileRemoteDataSource();
    repoImpl = ProfileRepoImpl(profileRemoteDataSource: mockDataSource);

    //Add these lines to provide dummy values
    provideDummy<ApiResult<EditProfileResponseEntity>>(
      ApiSuccessResult(
          data: EditProfileResponseEntity(message: '', user: null)),
    );
    provideDummy<ApiResult<LoggedUserDataResponseEntity>>(
      ApiSuccessResult(
          data: LoggedUserDataResponseEntity(message: '', user: null)),
    );
    provideDummy<ApiResult<UploadPhotoResponseEntity>>(
      ApiSuccessResult(data: UploadPhotoResponseEntity(message: '')),
    );
  });

  group('ProfileRepoImpl', () {
    group('editProfile', () {
      final editProfileRequest = EditProfileRequestEntity(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        phone: '+1234567890',
      );
      final successResult = ApiSuccessResult<EditProfileResponseEntity>(
        data: EditProfileResponseEntity(
          message: 'Profile updated successfully',
          user: null, // Mocks don't need full object mapping
        ),
      );
      final errorResult = ApiErrorResult<EditProfileResponseEntity>(
        failure: Failure(errorMessage: 'Network error'),
      );

      test('should return success result when data source call is successful',
          () async {
        // Arrange
        when(mockDataSource.editProfile(editProfileRequest))
            .thenAnswer((_) async => successResult);

        // Act
        final result = await repoImpl.editProfile(editProfileRequest);

        // Assert
        expect(result, isA<ApiSuccessResult<EditProfileResponseEntity>>());
        verify(mockDataSource.editProfile(editProfileRequest)).called(1);
      });

      test('should return error result when data source call fails', () async {
        // Arrange
        when(mockDataSource.editProfile(editProfileRequest))
            .thenAnswer((_) async => errorResult);

        // Act
        final result = await repoImpl.editProfile(editProfileRequest);

        // Assert
        expect(result, isA<ApiErrorResult<EditProfileResponseEntity>>());
        verify(mockDataSource.editProfile(editProfileRequest)).called(1);
      });
    });

    group('getLoggedUserData', () {
      final successResult = ApiSuccessResult<LoggedUserDataResponseEntity>(
        data: const LoggedUserDataResponseEntity(
          message: 'User data retrieved successfully',
          user: null, // Mocks don't need full object mapping
        ),
      );
      final errorResult = ApiErrorResult<LoggedUserDataResponseEntity>(
        failure: Failure(errorMessage: 'User not found'),
      );

      test('should return success result when data source call is successful',
          () async {
        // Arrange
        when(mockDataSource.getLoggedUserData())
            .thenAnswer((_) async => successResult);

        // Act
        final result = await repoImpl.getLoggedUserData();

        // Assert
        expect(result, isA<ApiSuccessResult<LoggedUserDataResponseEntity>>());
        verify(mockDataSource.getLoggedUserData()).called(1);
      });

      test('should return error result when data source call fails', () async {
        // Arrange
        when(mockDataSource.getLoggedUserData())
            .thenAnswer((_) async => errorResult);

        // Act
        final result = await repoImpl.getLoggedUserData();

        // Assert
        expect(result, isA<ApiErrorResult<LoggedUserDataResponseEntity>>());
        verify(mockDataSource.getLoggedUserData()).called(1);
      });
    });

    group('uploadProfilePhoto', () {
      final mockFile = File('test_image.jpg');
      final successResult = ApiSuccessResult<UploadPhotoResponseEntity>(
        data: UploadPhotoResponseEntity(message: 'Photo uploaded successfully'),
      );
      final errorResult = ApiErrorResult<UploadPhotoResponseEntity>(
        failure: Failure(errorMessage: 'Upload failed'),
      );

      test('should return success result when data source call is successful',
          () async {
        // Arrange
        when(mockDataSource.uploadProfilePhoto(mockFile))
            .thenAnswer((_) async => successResult);

        // Act
        final result = await repoImpl.uploadProfilePhoto(mockFile);

        // Assert
        expect(result, isA<ApiSuccessResult<UploadPhotoResponseEntity>>());
        verify(mockDataSource.uploadProfilePhoto(mockFile)).called(1);
      });

      test('should return error result when data source call fails', () async {
        // Arrange
        when(mockDataSource.uploadProfilePhoto(mockFile))
            .thenAnswer((_) async => errorResult);

        // Act
        final result = await repoImpl.uploadProfilePhoto(mockFile);

        // Assert
        expect(result, isA<ApiErrorResult<UploadPhotoResponseEntity>>());
        verify(mockDataSource.uploadProfilePhoto(mockFile)).called(1);
      });
    });
  });
}
