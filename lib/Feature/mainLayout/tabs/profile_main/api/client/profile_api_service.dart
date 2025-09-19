import 'package:flower_e_commerce_app/core/utils/Constantts/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

import '../models/response/logged_user_data_response_dto.dart';

part 'profile_api_service.g.dart';

@RestApi()
@injectable
abstract class ProfileApiService {
  @factoryMethod
  factory ProfileApiService(Dio dio) = _ProfileApiService;

  @GET(ApiConstants.getLoggedUserData)
  Future<LoggedUserDataResponseDto> getLoggedUserData();
}
