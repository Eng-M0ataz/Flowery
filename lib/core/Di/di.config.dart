// dart format width=80
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
import '../Services/secure_storge.dart' as _i792;
import '../Services/storge_interface.dart' as _i859;
import 'dioModul/dio_modle.dart' as _i456;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.lazySingleton<_i528.PrettyDioLogger>(
      () => dioModule.providePrettyDioLogger(),
    );
    gh.lazySingleton<_i361.Dio>(() => dioModule.provideDio());
    gh.factory<_i896.AuthRemoteDataSource>(
      () => _i515.AuthRemoteDataSourceImpl(),
    );
    gh.factory<_i500.ApiServices>(() => _i500.ApiServices.new(gh<_i361.Dio>()));
    gh.lazySingleton<_i859.Storge>(
      () => _i792.SecureStorgeImpl(),
      instanceName: 'secureStorge',
    );
    gh.factory<_i466.AuthRepo>(() => _i923.AuthRepoImpl());
    gh.factory<_i901.AuthLocalDataSource>(
      () => _i608.AuthLocalDataSourceImpl(),
    );
    return this;
  }
}

class _$DioModule extends _i456.DioModule {}
