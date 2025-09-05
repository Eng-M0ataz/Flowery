
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/api/client/profile_api_service.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/api/dataSources/profile_remote_data_source_impl.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/api/models/response/edit_profile_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/api/models/response/logged_user_data_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/api/models/response/upload_photo_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/request/edit_profile_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/edit_profile_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/logged_user_data_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/upload_photo_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/model/responses/user_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/api/models/logged_user_dto.dart';


import 'profile_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ProfileApiService])
void main() {

  late MockProfileApiService mockApiService;
  late ProfileRemoteDataSourceImpl dataSource;

  setUp(() {
    mockApiService = MockProfileApiService();
    dataSource = ProfileRemoteDataSourceImpl(
      profileApiService: mockApiService,

    );
  });


    group('editProfile', () {
      final editProfileRequest = EditProfileRequestEntity(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        phone: '+1234567890',
      );

      final mockResponseDto = EditProfileResponseDto(
        message: 'Profile updated successfully',
        user: UserDto(
          firstName: 'John',
          lastName: 'Doe',
          email: 'john.doe@example.com',
          gender: 'male',
          phone: '+1234567890',
          photo: 'photo.jpg',
          role: 'user',
          wishlist: [],
          addresses: [],
          createdAt: '2025-01-01',
        ),
      );

      test('should return success when API call is successful', () async {
        // Arrange
        when(mockApiService.editProfile(any))
            .thenAnswer((_) async => mockResponseDto);

        // Act
        final result = await dataSource.editProfile(editProfileRequest);

        // Assert
        expect(result, isA<ApiSuccessResult<EditProfileResponseEntity>>());
        if (result is ApiSuccessResult<EditProfileResponseEntity>) {
          expect(result.data.message, equals(mockResponseDto.message));
          expect(result.data.user?.firstName,
              equals(mockResponseDto.user!.firstName));
        } else {
          fail('Expected success but got failure');
        }
        verify(mockApiService.editProfile(any)).called(1);
      });

      test('should return error when DioException occurs', () async {
        // Arrange
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/profile'),
          response: Response(
            requestOptions: RequestOptions(path: '/profile'),
            statusCode: 500,
          ),
        );
        when(mockApiService.editProfile(any)).thenThrow(dioException);

        // Act
        final result = await dataSource.editProfile(editProfileRequest);

        // Assert
        expect(result, isA<ApiErrorResult<EditProfileResponseEntity>>());
        if (result is ApiErrorResult<EditProfileResponseEntity>) {
          expect(result.failure, isA<Failure>());
        }
        verify(mockApiService.editProfile(any)).called(1);
      });

      test('should return error when other Exception occurs', () async {
        // Arrange
        when(mockApiService.editProfile(any))
            .thenThrow(Exception('Network error'));

        // Act
        final result = await dataSource.editProfile(editProfileRequest);

        // Assert
        expect(result, isA<ApiErrorResult<EditProfileResponseEntity>>());
        if (result is ApiErrorResult<EditProfileResponseEntity>) {
          expect(
              result.failure.errorMessage, equals('Exception: Network error'));
        }
        verify(mockApiService.editProfile(any)).called(1);
      });
    });

    group('getLoggedUserData', () {
      final mockResponseDto = LoggedUserDataResponseDto(
        message: 'User data retrieved successfully',
        user: LoggedUserDto(
          id: 'user123',
          firstName: 'John',
          lastName: 'Doe',
          email: 'john.doe@example.com',
          gender: 'male',
          phone: '+1234567890',
          photo: 'profile.jpg',
          role: 'user',
          wishlist: [],
          addresses: [],
          createdAt: '2025-01-01',
          passwordResetCode: null,
          passwordResetExpires: null,
          resetCodeVerified: null,
        ),
      );

      test('should return success when API call is successful', () async {
        // Arrange
        when(mockApiService.getLoggedUserData())
            .thenAnswer((_) async => mockResponseDto);

        // Act
        final result = await dataSource.getLoggedUserData();

        // Assert
        expect(result, isA<ApiSuccessResult<LoggedUserDataResponseEntity>>());
        if (result is ApiSuccessResult<LoggedUserDataResponseEntity>) {
          expect(result.data.message, equals(mockResponseDto.message));
          expect(result.data.user?.email, equals(mockResponseDto.user!.email));
        } else {
          fail('Expected success but got failure');
        }
        verify(mockApiService.getLoggedUserData()).called(1);
      });

      test('should return error when DioException occurs', () async {
        // Arrange
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/user-data'),
          response: Response(
            requestOptions: RequestOptions(path: '/user-data'),
            statusCode: 404,
          ),
        );
        when(mockApiService.getLoggedUserData()).thenThrow(dioException);

        // Act
        final result = await dataSource.getLoggedUserData();

        // Assert
        expect(result, isA<ApiErrorResult<LoggedUserDataResponseEntity>>());
        if (result is ApiErrorResult<LoggedUserDataResponseEntity>) {
          expect(result.failure, isA<Failure>());
        }
        verify(mockApiService.getLoggedUserData()).called(1);
      });
    });

    group('uploadProfilePhoto', () {
      final mockFile = File('test_image.jpg');
      final mockResponseDto = UploadPhotoResponseDto(
        message: 'Photo uploaded successfully',
      );

      test('should return success when API call is successful', () async {
        // Arrange
        when(mockApiService.uploadProfilePhoto(any))
            .thenAnswer((_) async => mockResponseDto);

        // Act
        final result = await dataSource.uploadProfilePhoto(mockFile);

        // Assert
        expect(result, isA<ApiSuccessResult<UploadPhotoResponseEntity>>());
        if (result is ApiSuccessResult<UploadPhotoResponseEntity>) {
          expect(result.data.message, equals(mockResponseDto.message));
        } else {
          fail('Expected success but got failure');
        }
        verify(mockApiService.uploadProfilePhoto(mockFile)).called(1);
      });

      test('should return error when DioException occurs', () async {
        // Arrange
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/upload-photo'),
          response: Response(
            requestOptions: RequestOptions(path: '/upload-photo'),
            statusCode: 500,
          ),
        );
        when(mockApiService.uploadProfilePhoto(any)).thenThrow(dioException);

        // Act
        final result = await dataSource.uploadProfilePhoto(mockFile);

        // Assert
        expect(result, isA<ApiErrorResult<UploadPhotoResponseEntity>>());
        if (result is ApiErrorResult<UploadPhotoResponseEntity>) {
          expect(result.failure, isA<Failure>());
        }
        verify(mockApiService.uploadProfilePhoto(mockFile)).called(1);
      });

    });
  });
}