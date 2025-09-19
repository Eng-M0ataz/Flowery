import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile_main/api/mapper/logged_user_response_mapper.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Functions/execute_api.dart';
import 'package:injectable/injectable.dart';
import '../../data/dataSources/profile_main_remote_data_source.dart';
import '../../domain/entities/response/logged_user_data_response_entity.dart';
import '../client/profile_api_service.dart';
import '../models/response/logged_user_data_response_dto.dart';

@Injectable(as: ProfileMainRemoteDataSource)
class ProfileMainRemoteDataSourceImpl implements ProfileMainRemoteDataSource {
  final ProfileApiService _apiService;

  ProfileMainRemoteDataSourceImpl(this._apiService);

  @override
  Future<ApiResult<LoggedUserDataResponseEntity>> getLoggedUserData() async {
    return executeApi<LoggedUserDataResponseDto, LoggedUserDataResponseEntity>(
        request: () => _apiService.getLoggedUserData(),
        mapper: (dto) => dto.toEntity());
  }
}
