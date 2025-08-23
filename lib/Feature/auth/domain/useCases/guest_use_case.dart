
import 'package:flower_e_commerce_app/Feature/auth/data/dataSources/auth_local_data_source.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@injectable
class guestUseCase{
  final AuthLocalDataSource authLocalDataSource;
  guestUseCase(this.authLocalDataSource);

  Future<ApiResult<void>>isGuest() async {
    return authLocalDataSource.isGuest();
  }

}