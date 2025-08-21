// import 'package:flower_e_commerce_app/Feature/auth/data/repositories/auth_repo_impl.dart';
// import 'package:flower_e_commerce_app/Feature/auth/data/dataSources/auth_remote_data_source.dart';
// import 'package:flower_e_commerce_app/Feature/auth/domain/entities/request/forget_password_request_entity.dart';
// import 'package:flower_e_commerce_app/Feature/auth/domain/entities/request/reset_password_request_entity.dart';
// import 'package:flower_e_commerce_app/Feature/auth/domain/entities/request/verify_reset_code_request_entity.dart';
// import 'package:flower_e_commerce_app/Feature/auth/domain/entities/response/forget_password_response_entity.dart';
// import 'package:flower_e_commerce_app/Feature/auth/domain/entities/response/reset_password_response_entity.dart';
// import 'package:flower_e_commerce_app/Feature/auth/domain/entities/response/verify_reset_code_response_entity.dart';
// import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
// import 'package:flower_e_commerce_app/core/Errors/failure.dart';
// import 'package:test/test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import 'auth_repo_impl_test.mocks.dart';



// @GenerateMocks([AuthRemoteDataSource])
// void main() {
//   late MockAuthRemoteDataSource mockRemote;
//   late AuthRepoImpl repo;

//   setUpAll(() {
//     provideDummy<ApiResult<ForgetPasswordResponseEntity>>(
//       ApiSuccessResult<ForgetPasswordResponseEntity>(
//         data: ForgetPasswordResponseEntity(message: '', info: ''),
//       ),
//     );
//     provideDummy<ApiResult<VerifyResetCodeResponseEntity>>(
//       ApiSuccessResult<VerifyResetCodeResponseEntity>(
//         data: VerifyResetCodeResponseEntity(status: ''),
//       ),
//     );
//     provideDummy<ApiResult<ResetPasswordResponseEntity>>(
//       ApiSuccessResult<ResetPasswordResponseEntity>(
//         data: ResetPasswordResponseEntity(message: '', token: ''),
//       ),
//     );
//   });

//   setUp(() {
//     mockRemote = MockAuthRemoteDataSource();
//     repo = AuthRepoImpl(authRemoteDataSource: mockRemote);
//   });

//   group('forgetPassword', () {
//     final request = ForgetPasswordRequestEntity(email: 'test@example.com');
//     final responseEntity =
//         ForgetPasswordResponseEntity(message: 'Email sent', info: '');

//     test('delegates to data source and returns success', () async {
//       when(mockRemote.forgetPassword(any)).thenAnswer((_) async =>
//           ApiSuccessResult<ForgetPasswordResponseEntity>(
//               data: responseEntity));

//       final result = await repo.forgetPassword(request);

//       expect(result, isA<ApiSuccessResult<ForgetPasswordResponseEntity>>());
//       final success = result as ApiSuccessResult<ForgetPasswordResponseEntity>;
//       expect(success.data.message, responseEntity.message);

//       verify(mockRemote.forgetPassword(request)).called(1);
//     });

//     test('delegates to data source and returns error', () async {
//       final failure = Failure(errorMessage: 'Network');
//       when(mockRemote.forgetPassword(any)).thenAnswer((_) async =>
//           ApiErrorResult<ForgetPasswordResponseEntity>(failure: failure));

//       final result = await repo.forgetPassword(request);

//       expect(result, isA<ApiErrorResult<ForgetPasswordResponseEntity>>());
//       final error = result as ApiErrorResult<ForgetPasswordResponseEntity>;
//       expect(error.failure.errorMessage, 'Network');

//       verify(mockRemote.forgetPassword(request)).called(1);
//     });
//   });

//   group('verifyResetCode', () {
//     final request = VerifyResetCodeRequestEntity(resetCode: '123456');
//     final responseEntity =
//         VerifyResetCodeResponseEntity(status: 'Code verified');

//     test('delegates to data source and returns success', () async {
//       when(mockRemote.verifyResetCode(any)).thenAnswer((_) async =>
//           ApiSuccessResult<VerifyResetCodeResponseEntity>(
//               data: responseEntity));

//       final result = await repo.verifyResetCode(request);

//       expect(result, isA<ApiSuccessResult<VerifyResetCodeResponseEntity>>());
//       final success = result as ApiSuccessResult<VerifyResetCodeResponseEntity>;
//       expect(success.data.status, responseEntity.status);

//       verify(mockRemote.verifyResetCode(request)).called(1);
//     });

//     test('delegates to data source and returns error', () async {
//       final failure = Failure(errorMessage: 'Unexpected error');
//       when(mockRemote.verifyResetCode(any)).thenAnswer((_) async =>
//           ApiErrorResult<VerifyResetCodeResponseEntity>(failure: failure));

//       final result = await repo.verifyResetCode(request);

//       expect(result, isA<ApiErrorResult<VerifyResetCodeResponseEntity>>());
//       final error = result as ApiErrorResult<VerifyResetCodeResponseEntity>;
//       expect(error.failure.errorMessage, 'Unexpected error');

//       verify(mockRemote.verifyResetCode(request)).called(1);
//     });
//   });

//   group('resetPassword', () {
//     final request = ResetPasswordRequestEntity(
//         email: 'test@example.com', newPassword: '123456');
//     final responseEntity = ResetPasswordResponseEntity(
//         message: 'Password reset successful', token: 'token');

//     test('delegates to data source and returns success', () async {
//       when(mockRemote.resetPassword(any)).thenAnswer((_) async =>
//           ApiSuccessResult<ResetPasswordResponseEntity>(
//               data: responseEntity));

//       final result = await repo.resetPassword(request);

//       expect(result, isA<ApiSuccessResult<ResetPasswordResponseEntity>>());
//       final success = result as ApiSuccessResult<ResetPasswordResponseEntity>;
//       expect(success.data.message, responseEntity.message);

//       verify(mockRemote.resetPassword(request)).called(1);
//     });

//     test('delegates to data source and returns error', () async {
//       final failure = Failure(errorMessage: 'ServerFailure');
//       when(mockRemote.resetPassword(any)).thenAnswer((_) async =>
//           ApiErrorResult<ResetPasswordResponseEntity>(failure: failure));

//       final result = await repo.resetPassword(request);

//       expect(result, isA<ApiErrorResult<ResetPasswordResponseEntity>>());
//       final error = result as ApiErrorResult<ResetPasswordResponseEntity>;
//       expect(error.failure.errorMessage, 'ServerFailure');

//       verify(mockRemote.resetPassword(request)).called(1);
//     });
//   });
// }
