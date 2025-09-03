import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/data/dataSources/profile_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/data/repositories/profile_repo_impl.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/logged_user_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/logged_user_data_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_repo_impl_test.mocks.dart';

@GenerateMocks([ProfileRemoteDataSource])
void main() {
  late ProfileRepoImpl repo;
  late MockProfileRemoteDataSource mockRemoteDataSource;
  late LoggedUserDataResponseEntity mockUserEntity;

  setUp(() {
    mockRemoteDataSource = MockProfileRemoteDataSource();
    repo = ProfileRepoImpl(mockRemoteDataSource);

    mockUserEntity = LoggedUserDataResponseEntity(
      message: 'Success',
      user: LoggedUserEntity(
        id: '123',
        firstName: 'Test User',
        email: 'test@example.com',
        phone: '0123456789',
        photo: 'https://example.com/user.jpg',
      ),
    );

    provideDummy<ApiResult<LoggedUserDataResponseEntity>>(
      ApiSuccessResult(
        data: LoggedUserDataResponseEntity(
          message: "success",
          user: null,
        ),
      ),
    );
  });

  group('ProfileRepoImpl tests', () {
    test('success case for getLoggedUserData', () async {
      // arrange
      when(mockRemoteDataSource.getLoggedUserData())
          .thenAnswer((_) async => ApiSuccessResult(data: mockUserEntity));

      // act
      final result = await repo.getLoggedUserData();

      // assert
      expect(result, isA<ApiSuccessResult<LoggedUserDataResponseEntity>>());
      final success = result as ApiSuccessResult<LoggedUserDataResponseEntity>;
      expect(success.data.user?.firstName, 'Test User');
    });

    test('failure case for getLoggedUserData', () async {
      // arrange
      when(mockRemoteDataSource.getLoggedUserData()).thenAnswer(
        (_) async => ApiErrorResult(
          failure: Failure(errorMessage: "Server error"),
        ),
      );

      // act
      final result = await repo.getLoggedUserData();

      // assert
      expect(result, isA<ApiErrorResult<LoggedUserDataResponseEntity>>());
    });
  });
}
