import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/logged_user_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/logged_user_data_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/useCases/get_logged_user_use_case.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'profile_view_model_test.mocks.dart';

@GenerateMocks([GetLoggedUserUseCase])
void main() {
  late MockGetLoggedUserUseCase mockGetLoggedUserUseCase;

  final testUserEntity = LoggedUserDataResponseEntity(
    message: "Success",
    user: LoggedUserEntity(
      id: '123',
      firstName: 'Test User',
      email: 'test@example.com',
      phone: '0123456789',
      photo: 'https://example.com/user.jpg',
    ),
  );

  final testFailure = ServerFailure(errorMessage: "Server Error");

  setUp(() {
    mockGetLoggedUserUseCase = MockGetLoggedUserUseCase();
    provideDummy<ApiResult<LoggedUserDataResponseEntity>>(
      ApiSuccessResult(data: testUserEntity),
    );
  });

  group('GetLoggedUserUseCase Tests', () {
    test('success case for getLoggedUserData', () async {
      // arrange
      when(mockGetLoggedUserUseCase.call())
          .thenAnswer((_) async => ApiSuccessResult(data: testUserEntity));

      // act
      final result = await mockGetLoggedUserUseCase.call();

      // assert
      expect(result, isA<ApiSuccessResult<LoggedUserDataResponseEntity>>());
      final success = result as ApiSuccessResult<LoggedUserDataResponseEntity>;
      expect(success.data.user?.firstName, 'Test User');
      expect(success.data.user?.email, 'test@example.com');
    });

    test('failure case for getLoggedUserData', () async {
      // arrange
      when(mockGetLoggedUserUseCase.call())
          .thenAnswer((_) async => ApiErrorResult(failure: testFailure));

      // act
      final result = await mockGetLoggedUserUseCase.call();

      // assert
      expect(result, isA<ApiErrorResult>());
      final failure = result as ApiErrorResult<LoggedUserDataResponseEntity>;
      expect(failure.failure, testFailure);
    });
  });
}
