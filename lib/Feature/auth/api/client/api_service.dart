import 'package:dio/dio.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/model/requests/sign_in_request_dto.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/model/responses/sign_in_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../core/utils/Constants/api_constants.dart';
part 'api_service.g.dart';

@singleton
@RestApi()
abstract class ApiServices {
  @factoryMethod
  factory ApiServices(Dio dio) = _ApiServices;

@POST(ApiConstants.signIn)
  Future<SigninResponseDto> signIn({
    @Body() required SigninRequestDto request
  });
}
