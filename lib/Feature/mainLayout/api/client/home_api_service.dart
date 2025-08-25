import 'package:flower_e_commerce_app/core/utils/Constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import '../models/response/occasion_response_dto.dart';

part 'home_api_service.g.dart';

@RestApi()
@injectable
abstract class HomeApiService {
  @factoryMethod
  factory HomeApiService(Dio dio) = _HomeApiService;

  @GET(ApiConstants.occasions)
  Future<OccasionResponseDto> getAllOccasions();
}
