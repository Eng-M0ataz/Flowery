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
import '../../Feature/auth/domain/use_cases/sign_in_use_case.dart' as _i320;
import '../../Feature/auth/domain/useCases/forget_password_use_case.dart'
    as _i568;
import '../../Feature/auth/domain/useCases/reset_password_use_case.dart'
    as _i576;
import '../../Feature/auth/domain/useCases/sign_up_use_case.dart' as _i630;
import '../../Feature/auth/domain/useCases/verify_reset_code_use_case.dart'
    as _i136;
import '../../Feature/auth/presentation/viewModel/forgetPassword/forget_password_view_model.dart'
    as _i889;
import '../../Feature/auth/presentation/viewModel/signin/sign_in_view_model.dart'
    as _i301;
import '../../Feature/auth/presentation/viewModel/viewModel/signup_view_model.dart'
    as _i248;
import '../../Feature/bestSellerFeature/api/client/most_selling_api_service.dart'
    as _i35;
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
import '../../Feature/editProfile/api/client/profile_api_service.dart' as _i762;
import '../../Feature/editProfile/api/dataSources/profile_remote_data_source_impl.dart'
    as _i1007;
import '../../Feature/editProfile/data/dataSources/profile_remote_data_source.dart'
    as _i700;
import '../../Feature/editProfile/data/repositories/profile_repo_impl.dart'
    as _i387;
import '../../Feature/editProfile/domain/repositories/profile_repo.dart'
    as _i197;
import '../../Feature/editProfile/domain/useCases/edit_profile_use_case.dart'
    as _i983;
import '../../Feature/editProfile/domain/useCases/get_logged_user_use_case.dart'
    as _i182;
import '../../Feature/editProfile/domain/useCases/upload_photo_use_case.dart'
    as _i463;
import '../../Feature/editProfile/presentation/viewModels/profileViewModel/profile_view_model.dart'
    as _i373;
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
import '../../Feature/mainLayout/tabs/categoriesFeature/domain/useCases/get_products_by_category_use_case.dart'
    as _i137;
import '../../Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/viewModel/categories_view_model.dart'
    as _i1057;
import '../../Feature/mainLayout/tabs/home/presentation/viewModel/home_view_model.dart'
    as _i1060;
import '../../Feature/mainLayout/tabs/profile_main/api/client/profile_api_service.dart'
    as _i542;
import '../../Feature/mainLayout/tabs/profile_main/api/dataSources/profile_main_remote_data_source_impl.dart'
    as _i386;
import '../../Feature/mainLayout/tabs/profile_main/data/dataSources/profile_main_remote_data_source.dart'
    as _i795;
import '../../Feature/mainLayout/tabs/profile_main/data/repositories/profile_main_repo_impl.dart'
    as _i418;
import '../../Feature/mainLayout/tabs/profile_main/domain/repositories/profile_main_repo.dart'
    as _i183;
import '../../Feature/mainLayout/tabs/profile_main/domain/useCases/get_logged_user_use_case.dart'
    as _i868;
import '../../Feature/mainLayout/tabs/profile_main/presentation/viewModels/profileViewModel/profile_main_view_model.dart'
    as _i505;
import '../../Feature/occasion/api/client/occasion_api_service.dart' as _i713;
import '../../Feature/occasion/api/dataSources/occasion_remote_data_source_impl.dart'
    as _i108;
import '../../Feature/occasion/data/dataSources/occasion_remote_data_source.dart'
    as _i245;
import '../../Feature/occasion/data/repositories/occasion_repo_impl.dart'
    as _i782;
import '../../Feature/occasion/domain/repositories/occasion_repo.dart' as _i215;
import '../../Feature/occasion/domain/useCases/add_product_to_cart_use_case.dart'
    as _i781;
import '../../Feature/occasion/domain/useCases/get_all_occasion_use_case.dart'
    as _i49;
import '../../Feature/occasion/domain/useCases/get_products_by_occasion_use_case.dart'
    as _i89;
import '../../Feature/occasion/presentation/viewModels/occasion_view_model.dart'
    as _i347;
import '../../Feature/searchFeature/api/client/search_api_service.dart'
    as _i104;
import '../../Feature/searchFeature/api/dataSources/search_remote_data_source_impl.dart'
    as _i112;
import '../../Feature/searchFeature/data/dataSource/search_remote_data_source.dart'
    as _i509;
import '../../Feature/searchFeature/data/repositories/search_repo_impl.dart'
    as _i695;
import '../../Feature/searchFeature/domain/repositories/search_repo.dart'
    as _i886;
import '../../Feature/searchFeature/domain/useCases/product_search_use_case.dart'
    as _i167;
import '../../Feature/searchFeature/presentation/viewModel/search_view_model.dart'
    as _i670;
import '../helpers/app_config_cubit.dart' as _i713;
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
    gh.factory<_i713.AppConfigCubit>(
        () => _i713.AppConfigCubit(gh<_i456.Storage>()));
    gh.factory<_i500.ApiServices>(() => _i500.ApiServices.new(gh<_i361.Dio>()));
    gh.factory<_i35.MostSellingApiService>(
        () => _i35.MostSellingApiService.new(gh<_i361.Dio>()));
    gh.factory<_i762.ProfileApiService>(
        () => _i762.ProfileApiService.new(gh<_i361.Dio>()));
    gh.factory<_i996.ApiServices>(() => _i996.ApiServices.new(gh<_i361.Dio>()));
    gh.factory<_i542.ProfileApiService>(
        () => _i542.ProfileApiService.new(gh<_i361.Dio>()));
    gh.factory<_i713.OccasionApiService>(
        () => _i713.OccasionApiService.new(gh<_i361.Dio>()));
    gh.factory<_i104.SearchApiService>(
        () => _i104.SearchApiService.new(gh<_i361.Dio>()));
    gh.factory<_i245.OccasionRemoteDataSource>(() =>
        _i108.OccasionRemoteDataSourceImpl(gh<_i713.OccasionApiService>()));
    gh.lazySingleton<_i456.Storage>(
      () => _i927.SecureStorageImpl(),
      instanceName: 'secureStorage',
    );
    gh.factory<_i700.ProfileRemoteDataSource>(() =>
        _i1007.ProfileRemoteDataSourceImpl(
            profileApiService: gh<_i762.ProfileApiService>()));
    gh.factory<_i341.CategoriesRemoteDataSource>(() =>
        _i98.CategoriesRemoteDataSourceImpl(
            apiServicest: gh<_i996.ApiServices>()));
    gh.factory<_i197.ProfileRepo>(() => _i387.ProfileRepoImpl(
        profileRemoteDataSource: gh<_i700.ProfileRemoteDataSource>()));
    gh.factory<_i691.CategoriesRepo>(() => _i1066.CategoriesRepoImpl(
        categoriesRemoteDataSource: gh<_i341.CategoriesRemoteDataSource>()));
    gh.factory<_i509.SearchRemoteDataSource>(
        () => _i112.SearchRemoteDataSourceImpl(gh<_i104.SearchApiService>()));
    gh.factory<_i886.SearchRepo>(
        () => _i695.SearchRepoImpl(gh<_i509.SearchRemoteDataSource>()));
    gh.factory<_i795.ProfileMainRemoteDataSource>(() =>
        _i386.ProfileMainRemoteDataSourceImpl(gh<_i542.ProfileApiService>()));
    gh.factory<_i182.GetLoggedUserUseCase>(
        () => _i182.GetLoggedUserUseCase(gh<_i197.ProfileRepo>()));
    gh.factory<_i183.ProfileMainRepo>(() =>
        _i418.ProfileMainRepoImpl(gh<_i795.ProfileMainRemoteDataSource>()));
    gh.factory<_i806.BestSellerRemoteDataSource>(() =>
        _i320.BestSellerRemoteDataSourceImpl(
            apiServices: gh<_i35.MostSellingApiService>()));
    gh.factory<_i901.AuthLocalDataSource>(() => _i608.AuthLocalDataSourceImpl(
        gh<_i456.Storage>(instanceName: 'secureStorage')));
    gh.factory<_i66.CategoriesUseCase>(() =>
        _i66.CategoriesUseCase(categoriesRepo: gh<_i691.CategoriesRepo>()));
    gh.factory<_i201.GetAllProductsUseCase>(() => _i201.GetAllProductsUseCase(
        categoriesRepo: gh<_i691.CategoriesRepo>()));
    gh.factory<_i214.GetCategoryProductsUseCase>(() =>
        _i214.GetCategoryProductsUseCase(
            categoriesRepo: gh<_i691.CategoriesRepo>()));
    gh.factory<_i137.GetProductsByCategoryUseCase>(() =>
        _i137.GetProductsByCategoryUseCase(
            categoriesRepo: gh<_i691.CategoriesRepo>()));
    gh.factory<_i516.BestSellerRepo>(() => _i983.BestSellerRepoImpl(
        dataSource: gh<_i806.BestSellerRemoteDataSource>()));
    gh.factory<_i896.AuthRemoteDataSource>(
        () => _i515.AuthRemoteDataSourceImpl(gh<_i500.ApiServices>()));
    gh.factory<_i215.OccasionRepo>(
        () => _i782.OccasionRepoImpl(gh<_i245.OccasionRemoteDataSource>()));
    gh.factory<_i127.BestSellerUseCase>(
        () => _i127.BestSellerUseCase(repo: gh<_i516.BestSellerRepo>()));
    gh.factory<_i781.AddProductToCartUseCase>(
        () => _i781.AddProductToCartUseCase(gh<_i215.OccasionRepo>()));
    gh.factory<_i49.GetAllOccasionUseCase>(
        () => _i49.GetAllOccasionUseCase(gh<_i215.OccasionRepo>()));
    gh.factory<_i89.GetProductsByOccasionUseCase>(
        () => _i89.GetProductsByOccasionUseCase(gh<_i215.OccasionRepo>()));
    gh.factory<_i983.EditProfileUseCase>(
        () => _i983.EditProfileUseCase(profileRepo: gh<_i197.ProfileRepo>()));
    gh.factory<_i463.UploadPhotoUseCase>(
        () => _i463.UploadPhotoUseCase(profileRepo: gh<_i197.ProfileRepo>()));
    gh.factory<_i868.GetLoggedUserUseCase>(
        () => _i868.GetLoggedUserUseCase(gh<_i183.ProfileMainRepo>()));
    gh.factory<_i167.ProductSearchUseCase>(
        () => _i167.ProductSearchUseCase(gh<_i886.SearchRepo>()));
    gh.factory<_i347.OccasionViewModel>(() => _i347.OccasionViewModel(
          gh<_i49.GetAllOccasionUseCase>(),
          gh<_i89.GetProductsByOccasionUseCase>(),
        ));
    gh.factory<_i53.BestSellerViewModel>(
        () => _i53.BestSellerViewModel(gh<_i127.BestSellerUseCase>()));
    gh.factory<_i466.AuthRepo>(() => _i923.AuthRepoImpl(
          gh<_i896.AuthRemoteDataSource>(),
          gh<_i901.AuthLocalDataSource>(),
        ));
    gh.factory<_i1060.HomeViewModel>(() => _i1060.HomeViewModel(
          gh<_i49.GetAllOccasionUseCase>(),
          gh<_i127.BestSellerUseCase>(),
          gh<_i66.CategoriesUseCase>(),
        ));
    gh.factory<_i568.ForgetPasswordUseCase>(
        () => _i568.ForgetPasswordUseCase(gh<_i466.AuthRepo>()));
    gh.factory<_i576.ResetPasswordUseCase>(
        () => _i576.ResetPasswordUseCase(gh<_i466.AuthRepo>()));
    gh.factory<_i136.VerifyResetCodeUseCase>(
        () => _i136.VerifyResetCodeUseCase(gh<_i466.AuthRepo>()));
    gh.factory<_i1057.CategoriesViewModel>(() => _i1057.CategoriesViewModel(
          gh<_i66.CategoriesUseCase>(),
          gh<_i137.GetProductsByCategoryUseCase>(),
          gh<_i201.GetAllProductsUseCase>(),
        ));
    gh.factory<_i889.ForgetPasswordViewModel>(
        () => _i889.ForgetPasswordViewModel(
              gh<_i568.ForgetPasswordUseCase>(),
              gh<_i136.VerifyResetCodeUseCase>(),
              gh<_i576.ResetPasswordUseCase>(),
            ));
    gh.factory<_i630.SignUpUseCase>(
        () => _i630.SignUpUseCase(authRepo: gh<_i466.AuthRepo>()));
    gh.factory<_i320.SigninUseCase>(
        () => _i320.SigninUseCase(authRepo: gh<_i466.AuthRepo>()));
    gh.factory<_i373.ProfileViewModel>(() => _i373.ProfileViewModel(
          gh<_i182.GetLoggedUserUseCase>(),
          gh<_i983.EditProfileUseCase>(),
          gh<_i463.UploadPhotoUseCase>(),
        ));
    gh.factory<_i505.ProfileMainViewModel>(
        () => _i505.ProfileMainViewModel(gh<_i868.GetLoggedUserUseCase>()));
    gh.factory<_i670.SearchViewModel>(
        () => _i670.SearchViewModel(gh<_i167.ProductSearchUseCase>()));
    gh.factory<_i301.SigninViewModel>(
        () => _i301.SigninViewModel(gh<_i320.SigninUseCase>()));
    gh.factory<_i248.SignupViewModel>(
        () => _i248.SignupViewModel(gh<_i630.SignUpUseCase>()));
    return this;
  }
}

class _$DioModule extends _i456.DioModule {}
