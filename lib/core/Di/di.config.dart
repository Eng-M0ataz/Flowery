// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;

import '../../Feature/auth/api/client/api_service.dart' as _i500;
import '../../Feature/auth/api/dataSources/auth_local_data_source_impl.dart'
    as _i608;
import '../../Feature/auth/api/dataSources/auth_remote_data_source_impl.dart'
    as _i515;
import '../../Feature/auth/data/dataSources/auth_local_data_source.dart'
    as _i901;
import '../../Feature/auth/data/dataSources/auth_remote_data_source.dart'
    as _i896;
import '../../Feature/auth/data/repositories/auth_repo_impl.dart' as _i923;
import '../../Feature/auth/domain/repositories/auth_repo.dart' as _i466;
import '../../Feature/auth/domain/useCases/forget_password_use_case.dart'
    as _i568;
import '../../Feature/auth/domain/useCases/guest_use_case.dart' as _i99;
import '../../Feature/auth/domain/useCases/reset_password_use_case.dart'
    as _i576;
import '../../Feature/auth/domain/useCases/sign_in_use_case.dart' as _i375;
import '../../Feature/auth/domain/useCases/sign_up_use_case.dart' as _i630;
import '../../Feature/auth/domain/useCases/verify_reset_code_use_case.dart'
    as _i136;
import '../../Feature/auth/presentation/viewModel/viewModel/forget_password_view_model.dart'
    as _i509;
import '../../Feature/auth/presentation/viewModel/viewModel/sign_in_view_model.dart'
    as _i787;
import '../../Feature/auth/presentation/viewModel/viewModel/signup_view_model.dart'
    as _i248;
import '../Services/secure_storage.dart' as _i927;
import '../Services/storage_interface.dart' as _i456;
import 'dioModul/dio_modle.dart' as _i456;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioModule = _$DioModule();
    gh.lazySingleton<_i528.PrettyDioLogger>(
        () => dioModule.providePrettyDioLogger());
    gh.lazySingleton<_i361.Dio>(() => dioModule.provideDio());
    gh.factory<_i500.ApiServices>(() => _i500.ApiServices(gh<_i361.Dio>()));
    gh.lazySingleton<_i456.Storage>(
      () => _i927.SecureStorageImpl(),
      instanceName: 'secureStorage',
    );
    gh.factory<_i896.AuthRemoteDataSource>(() =>
        _i515.AuthRemoteDataSourceImpl(apiServices: gh<_i500.ApiServices>()));
    gh.factory<_i901.AuthLocalDataSource>(() => _i608.AuthLocalDataSourceImpl(
        gh<_i456.Storage>(instanceName: 'secureStorage')));
    gh.factory<_i99.guestUseCase>(
        () => _i99.guestUseCase(gh<_i901.AuthLocalDataSource>()));
    gh.factory<_i466.AuthRepo>(() => _i923.AuthRepoImpl(
          authRemoteDataSource: gh<_i896.AuthRemoteDataSource>(),
          authLocalDataSource: gh<_i901.AuthLocalDataSource>(),
        ));
    gh.factory<_i568.ForgetPasswordUseCase>(
        () => _i568.ForgetPasswordUseCase(gh<_i466.AuthRepo>()));
    gh.factory<_i576.ResetPasswordUseCase>(
        () => _i576.ResetPasswordUseCase(gh<_i466.AuthRepo>()));
    gh.factory<_i136.VerifyResetCodeUseCase>(
        () => _i136.VerifyResetCodeUseCase(gh<_i466.AuthRepo>()));
    gh.factory<_i509.ForgetPasswordViewModel>(
        () => _i509.ForgetPasswordViewModel(
              gh<_i568.ForgetPasswordUseCase>(),
              gh<_i136.VerifyResetCodeUseCase>(),
              gh<_i576.ResetPasswordUseCase>(),
            ));
    gh.factory<_i375.SigninUseCase>(
        () => _i375.SigninUseCase(authRepo: gh<_i466.AuthRepo>()));
    gh.factory<_i630.SignUpUseCase>(
        () => _i630.SignUpUseCase(authRepo: gh<_i466.AuthRepo>()));
    gh.factory<_i248.SignupViewModel>(
        () => _i248.SignupViewModel(gh<_i630.SignUpUseCase>()));
    gh.factory<_i787.SigninViewModel>(() => _i787.SigninViewModel(
          gh<_i375.SigninUseCase>(),
          gh<_i99.guestUseCase>(),
        ));
    return this;
  }
}

class _$DioModule extends _i456.DioModule {}
