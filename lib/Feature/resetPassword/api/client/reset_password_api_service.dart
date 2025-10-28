import 'package:dio/dio.dart';
import 'package:flower_e_commerce_app/Feature/resetPassword/api/model/request/reset_password_request_model.dart';
import 'package:flower_e_commerce_app/Feature/resetPassword/api/model/response/reset_password_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../core/utils/Constantts/api_constants.dart';

part 'reset_password_api_service.g.dart';

@singleton
@RestApi()
abstract class ResetPasswordApiService {
  @factoryMethod
  factory ResetPasswordApiService(Dio dio) = _ResetPasswordApiService;

  @PATCH(ApiConstants.changePassword)
  Future<ResetPasswordResponseDto> resetPassword(
    @Body() ResetPasswordRequestModel resetPasswordRequestModel,
  );
}
