// test/test_helpers.dart
import 'package:flower_e_commerce_app/Feature/auth/domain/entity/response/sign_in_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:mockito/mockito.dart';

// Provide dummy values for ApiResult types
void setupDummyValues() {
  // Dummy for ApiSuccessResult<void>
  provideDummy<ApiResult<void>>(ApiSuccessResult<void>(data: null));

  // Dummy for ApiSuccessResult<SigninResponseEntity>
  provideDummy<ApiResult<SigninResponseEntity>>(
    ApiSuccessResult<SigninResponseEntity>(
      data: SigninResponseEntity(
        message: '',
        user: null,
        token: '',
      ),
    ),
  );

  // Dummy for ApiErrorResult<SigninResponseEntity>
  provideDummy<ApiResult<SigninResponseEntity>>(
    ApiErrorResult<SigninResponseEntity>(
      failure: Failure(errorMessage: ''),
    ),
  );
}