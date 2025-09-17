import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/api/client/reset_password_api_service.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/api/mapper/reset_password_mapper.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/api/models/response/reset_password_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/data/dataSources/reset_password_data_source.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/domain/entities/request/reset_password_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/domain/entities/response/reset_password_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Functions/execute_api.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ResetPasswordDataSource)
class ResetPasswordDataSourceImpl implements ResetPasswordDataSource {
  final ResetPasswordApiService _resetPasswordApiService;
  ResetPasswordDataSourceImpl({
    required ResetPasswordApiService resetPasswordApiService
  }) :_resetPasswordApiService=resetPasswordApiService;

  @override
  Future<ApiResult<ResetPasswordResponseEntity>> resetPassword(
      ResetPasswordRequestEntity resetPasswordRequestEntity) {
    return executeApi<ResetPasswordResponseDto, ResetPasswordResponseEntity>(
            () =>
            _resetPasswordApiService.resetPassword(
                resetPasswordRequestEntity.toModel()
            ), (dto) => dto.toEntity()
    );
  }
}