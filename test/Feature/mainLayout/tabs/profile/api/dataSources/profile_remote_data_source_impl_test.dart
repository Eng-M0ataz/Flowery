import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/api/client/profile_api_service.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/api/dataSources/profile_remote_data_source_impl.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/api/models/logged_user_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/api/models/response/logged_user_data_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/logged_user_data_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ProfileApiService])
void main() {
  late ProfileRemoteDataSourceImpl dataSource;
  late MockProfileApiService mockApiService;
  late LoggedUserDataResponseDto mockLoggedUserResponse;

  setUp(() {
    mockApiService = MockProfileApiService();
    dataSource = ProfileRemoteDataSourceImpl(mockApiService);

    mockLoggedUserResponse = LoggedUserDataResponseDto(
      message: 'Success',
      user: LoggedUserDto(
        id: '123',
        firstName: 'Test User',
        email: 'test@example.com',
        phone: '0123456789',
        photo: 'https://example.com/user.jpg',
      ),
    );
  });

  group('ProfileRemoteDataSourceImpl', () {
    test('success case for getLoggedUserData', () async {
      // arrange
      when(mockApiService.getLoggedUserData())
          .thenAnswer((_) async => mockLoggedUserResponse);

      // act
      final result = await dataSource.getLoggedUserData();

      // assert
      expect(result, isA<ApiSuccessResult<LoggedUserDataResponseEntity>>());

      final success = result as ApiSuccessResult<LoggedUserDataResponseEntity>;
      expect(success.data.user?.firstName, 'Test User');
      expect(success.data.user?.email, 'test@example.com');
    });

    test('failure case for getLoggedUserData throws exception', () async {
      // arrange
      when(mockApiService.getLoggedUserData())
          .thenThrow(Exception('Server error'));

      // act
      final result = await dataSource.getLoggedUserData();

      // assert
      expect(result, isA<ApiErrorResult>());
    });
  });
}
