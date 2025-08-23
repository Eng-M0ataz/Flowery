import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/auth/data/dataSources/auth_local_data_source.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:flower_e_commerce_app/core/Services/secure_storge.dart';
import 'package:flower_e_commerce_app/core/Services/storge_interface.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/app_constants.dart';

import 'package:injectable/injectable.dart';

@Injectable(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
 final Storage _storage;

  AuthLocalDataSourceImpl(@Named(AppConstants.secureStorage)this._storage);

  @override
  Future<ApiResult<void>> isGuest()async {

    try {
     await _storage.write(key: AppConstants.isGuest, value: "true");
      return ApiSuccessResult<void>(data: null);
    }catch(e){
           return ApiErrorResult<void>(failure: Failure(errorMessage: e.toString()));
    }

  }
 
}
