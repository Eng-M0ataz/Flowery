import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/api/client/profile_api_service.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/api/mapper/logged_user_response_mapper.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/api/models/response/logged_user_data_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/logged_user_data_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Functions/execute_api.dart';
import 'package:injectable/injectable.dart';
import '../../data/dataSources/profile_remote_data_source.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ProfileApiService _apiService;

  ProfileRemoteDataSourceImpl(this._apiService);

  @override
  Future<ApiResult<LoggedUserDataResponseEntity>> getLoggedUserData() async {
    return executeApi<LoggedUserDataResponseDto, LoggedUserDataResponseEntity>(
        request: () => _apiService.getLoggedUserData(),
        mapper: (dto) => dto.toEntity());
  }
}
