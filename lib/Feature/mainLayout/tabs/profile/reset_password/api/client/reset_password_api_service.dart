import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/api/models/request/reset_password_request_model.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/api/models/response/reset_password_response_dto.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'reset_password_api_service.g.dart';


@RestApi()
@injectable
abstract class ResetPasswordApiService {
  @factoryMethod
  factory ResetPasswordApiService(Dio dio) = _ResetPasswordApiService;

  @PATCH(ApiConstants.reset_password)
  Future<ResetPasswordResponseDto> resetPassword(@Body() ResetPasswordRequestModel body);

}