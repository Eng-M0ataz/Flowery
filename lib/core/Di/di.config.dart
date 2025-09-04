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
import '../../Feature/bestSellerFeature/api/client/api_service.dart' as _i776;
import '../../Feature/bestSellerFeature/api/dataSources/best_seller_remote_data_source_impl.dart'
    as _i320;
import '../../Feature/bestSellerFeature/data/dataSource/best_seller_remote_data_source.dart'
    as _i806;
import '../../Feature/bestSellerFeature/data/repositories/best_seller_repo_impl.dart'
    as _i983;
import '../../Feature/bestSellerFeature/domain/repositories/best_seller_repo.dart'
    as _i516;
import '../../Feature/bestSellerFeature/domain/useCases/best_seller_use_case.dart'
    as _i127;
import '../../Feature/bestSellerFeature/presentation/viewModel/best_seller_model_view.dart'
    as _i53;
import '../../Feature/mainLayout/tabs/categoriesFeature/api/client/api_service.dart'
    as _i996;
import '../../Feature/mainLayout/tabs/categoriesFeature/api/dataSources/categories_remote_data_source_impl.dart'
    as _i98;
import '../../Feature/mainLayout/tabs/categoriesFeature/data/dataSources/categories_remote_data_source.dart'
    as _i341;
import '../../Feature/mainLayout/tabs/categoriesFeature/data/repositories/categories_repo_impl.dart'
    as _i1066;
import '../../Feature/mainLayout/tabs/categoriesFeature/domain/repositories/categories_repo.dart'
    as _i691;
import '../../Feature/mainLayout/tabs/categoriesFeature/domain/useCases/categories_use_case.dart'
    as _i66;
import '../../Feature/mainLayout/tabs/categoriesFeature/domain/useCases/get_all_products_use_case.dart'
    as _i201;
import '../../Feature/mainLayout/tabs/categoriesFeature/domain/useCases/get_category_products_use_case.dart'
    as _i214;
import '../../Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/viewModel/categories_view_model.dart'
    as _i1057;
import '../../Feature/mainLayout/tabs/home/presentation/viewModel/home_view_model.dart'
    as _i1060;
import '../../Feature/mainLayout/tabs/profile/api/client/profile_api_service.dart'
    as _i602;
import '../../Feature/mainLayout/tabs/profile/api/dataSources/profile_remote_data_source_impl.dart'
    as _i156;
import '../../Feature/mainLayout/tabs/profile/data/dataSources/profile_remote_data_source.dart'
    as _i394;
import '../../Feature/mainLayout/tabs/profile/data/repositories/profile_repo_impl.dart'
    as _i1026;
import '../../Feature/mainLayout/tabs/profile/domain/repositories/profile_repo.dart'
    as _i992;
import '../../Feature/mainLayout/tabs/profile/domain/useCases/get_logged_user_use_case.dart'
    as _i548;
import '../../Feature/mainLayout/tabs/profile/presentation/viewModels/profileViewModel/profile_view_model.dart'
    as _i152;
import '../../Feature/occasion/api/client/occasion_api_service.dart' as _i713;
import '../../Feature/occasion/api/dataSources/occasion_remote_data_source_impl.dart'
    as _i108;
import '../../Feature/occasion/data/dataSources/occasion_remote_data_source.dart'
    as _i245;
import '../../Feature/occasion/data/repositories/occasion_repo_impl.dart'
    as _i782;
import '../../Feature/occasion/domain/repositories/occasion_repo.dart' as _i215;
import '../../Feature/occasion/domain/useCases/get_all_occasion_use_case.dart'
    as _i49;
import '../../Feature/occasion/domain/useCases/get_products_by_occasion_use_case.dart'
    as _i89;
import '../../Feature/occasion/presentation/viewModels/occasion_view_model.dart'
    as _i347;
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
    gh.factory<_i500.ApiServices>(() => _i500.ApiServices.new(gh<_i361.Dio>()));
    gh.factory<_i776.ApiServices>(() => _i776.ApiServices.new(gh<_i361.Dio>()));
    gh.factory<_i996.ApiServices>(() => _i996.ApiServices.new(gh<_i361.Dio>()));
    gh.factory<_i713.OccasionApiService>(
        () => _i713.OccasionApiService.new(gh<_i361.Dio>()));
    gh.factory<_i602.ProfileApiService>(
        () => _i602.ProfileApiService.new(gh<_i361.Dio>()));
    gh.factory<_i245.OccasionRemoteDataSource>(() =>
        _i108.OccasionRemoteDataSourceImpl(gh<_i713.OccasionApiService>()));
    gh.lazySingleton<_i456.Storage>(
      () => _i927.SecureStorageImpl(),
      instanceName: 'secureStorage',
    );
    gh.factory<_i341.CategoriesRemoteDataSource>(() =>
        _i98.CategoriesRemoteDataSourceImpl(
            apiServicest: gh<_i996.ApiServices>()));
    gh.factory<_i691.CategoriesRepo>(() => _i1066.CategoriesRepoImpl(
        categoriesRemoteDataSource: gh<_i341.CategoriesRemoteDataSource>()));
    gh.factory<_i394.ProfileRemoteDataSource>(
        () => _i156.ProfileRemoteDataSourceImpl(gh<_i602.ProfileApiService>()));
    gh.factory<_i806.BestSellerRemoteDataSource>(() =>
        _i320.BestSellerRemoteDataSourceImpl(
            apiServices: gh<_i776.ApiServices>()));
    gh.factory<_i896.AuthRemoteDataSource>(() =>
        _i515.AuthRemoteDataSourceImpl(apiServices: gh<_i500.ApiServices>()));
    gh.factory<_i992.ProfileRepo>(
        () => _i1026.ProfileRepoImpl(gh<_i394.ProfileRemoteDataSource>()));
    gh.factory<_i901.AuthLocalDataSource>(() => _i608.AuthLocalDataSourceImpl(
        gh<_i456.Storage>(instanceName: 'secureStorage')));
    gh.factory<_i66.CategoriesUseCase>(() =>
        _i66.CategoriesUseCase(categoriesRepo: gh<_i691.CategoriesRepo>()));
    gh.factory<_i201.GetAllProductsUseCase>(() => _i201.GetAllProductsUseCase(
        categoriesRepo: gh<_i691.CategoriesRepo>()));
    gh.factory<_i214.GetCategoryProductsUseCase>(() =>
        _i214.GetCategoryProductsUseCase(
            categoriesRepo: gh<_i691.CategoriesRepo>()));
    gh.factory<_i516.BestSellerRepo>(() => _i983.BestSellerRepoImpl(
        dataSource: gh<_i806.BestSellerRemoteDataSource>()));
    gh.factory<_i215.OccasionRepo>(
        () => _i782.OccasionRepoImpl(gh<_i245.OccasionRemoteDataSource>()));
    gh.factory<_i127.BestSellerUseCase>(
        () => _i127.BestSellerUseCase(repo: gh<_i516.BestSellerRepo>()));
    gh.factory<_i49.GetAllOccasionUseCase>(
        () => _i49.GetAllOccasionUseCase(gh<_i215.OccasionRepo>()));
    gh.factory<_i89.GetProductsByOccasionUseCase>(
        () => _i89.GetProductsByOccasionUseCase(gh<_i215.OccasionRepo>()));
    gh.factory<_i99.guestUseCase>(
        () => _i99.guestUseCase(gh<_i901.AuthLocalDataSource>()));
    gh.factory<_i347.OccasionViewModel>(() => _i347.OccasionViewModel(
          gh<_i49.GetAllOccasionUseCase>(),
          gh<_i89.GetProductsByOccasionUseCase>(),
        ));
    gh.factory<_i53.BestSellerViewModel>(
        () => _i53.BestSellerViewModel(gh<_i127.BestSellerUseCase>()));
    gh.factory<_i1060.HomeViewModel>(() => _i1060.HomeViewModel(
          gh<_i49.GetAllOccasionUseCase>(),
          gh<_i127.BestSellerUseCase>(),
          gh<_i66.CategoriesUseCase>(),
        ));
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
    gh.factory<_i548.GetLoggedUserUseCase>(
        () => _i548.GetLoggedUserUseCase(gh<_i992.ProfileRepo>()));
    gh.factory<_i1057.CategoriesViewModel>(() => _i1057.CategoriesViewModel(
          gh<_i66.CategoriesUseCase>(),
          gh<_i214.GetCategoryProductsUseCase>(),
          gh<_i201.GetAllProductsUseCase>(),
        ));
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
    gh.factory<_i152.ProfileViewModel>(
        () => _i152.ProfileViewModel(gh<_i548.GetLoggedUserUseCase>()));
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
