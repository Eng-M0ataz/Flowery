import 'package:dio/dio.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/models/response/sign_up_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/models/sign_up_request_model.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../models/request/forget_password_request.dart';
import '../models/request/reset_password_request.dart';
import '../models/request/verify_reset_code_request.dart';
import '../models/response/forget_password_response_dto.dart';
import '../models/response/reset_password_response_dto.dart';
import '../models/response/verify_reset_code_response_dto.dart';

part 'api_service.g.dart';

@injectable
@RestApi()
abstract class ApiServices {
  @factoryMethod
  factory ApiServices(Dio dio) = _ApiServices;

  @POST(ApiConstants.signUp)
  Future<SignUpResponseDto> signUp(@Body() SignUpRequestModel signUpRequest);

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
