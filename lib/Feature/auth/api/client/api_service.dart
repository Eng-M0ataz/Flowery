import 'package:dio/dio.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/model/requests/sign_in_request_dto.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/model/responses/sign_in_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../../../core/utils/constants/api_constants.dart';
import '../models/request/forget_password_request.dart';
import '../models/request/reset_password_request.dart';
import '../models/request/verify_reset_code_request.dart';
import '../models/response/forget_password_response_dto.dart';
import '../models/response/reset_password_response_dto.dart';
import '../models/response/verify_reset_code_response_dto.dart';
part 'api_service.g.dart';

@singleton
@RestApi()
abstract class ApiServices {
  @factoryMethod
  factory ApiServices(Dio dio) = _ApiServices;

  @POST(ApiConstants.signIn)
  Future<SigninResponseDto> signIn({@Body() required SigninRequestDto request});

  @POST(ApiConstants.forgotPassword)
  Future<ForgetPasswordResponseDto> forgetPassword(
      @Body() ForgetPasswordRequest forgetPasswordRequest);

  @POST(ApiConstants.verifyResetCode)
  Future<VerifyResetCodeResponseDto> verifyResetCode(
      @Body() VerifyResetCodeRequest verifyResetCodeRequest);

  @PUT(ApiConstants.resetPassword)
  Future<ResetPasswordResponseDto> resetPassword(
      @Body() ResetPasswordRequest resetPasswordRequest);
}
