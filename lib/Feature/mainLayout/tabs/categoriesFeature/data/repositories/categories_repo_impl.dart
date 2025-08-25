import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/data/dataSources/categories_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/resposneEntities/categories_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/repositories/categories_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CategoriesRepo)
class CategoriesRepoImpl implements CategoriesRepo {
  final CategoriesRemoteDataSource _categoriesRemoteDataSource;
  CategoriesRepoImpl(
      {required CategoriesRemoteDataSource categoriesRemoteDataSource})
      : _categoriesRemoteDataSource = categoriesRemoteDataSource;
  @override
  Future<ApiResult<CategoryResponseEntity>> getAllCategories() {
    return _categoriesRemoteDataSource.getAllCategories();
  }
}
