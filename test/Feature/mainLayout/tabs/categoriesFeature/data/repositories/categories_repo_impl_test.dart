import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/data/dataSources/categories_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/data/repositories/categories_repo_impl.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/resposneEntities/categories_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/category_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/metadata_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'categories_repo_impl_test.mocks.dart';

@GenerateMocks([CategoriesRemoteDataSource])
void main() {
  provideDummy<ApiResult<CategoryResponseEntity>>(
    ApiSuccessResult<CategoryResponseEntity>(
      data: CategoryResponseEntity(
        message: "dummy",
        metadata: MetadataEntity(
          currentPage: 0,
          limit: 0,
          totalPages: 0,
          totalItems: 0,
        ),
        categories: [],
      ),
    ),
  );
  late MockCategoriesRemoteDataSource mockCategoriesRemoteDataSource;
  late CategoriesRepoImpl categoriesRepoImpl;
  setUp(() {
    mockCategoriesRemoteDataSource = MockCategoriesRemoteDataSource();
    categoriesRepoImpl = CategoriesRepoImpl(
        categoriesRemoteDataSource: mockCategoriesRemoteDataSource);
  });

  group('getAllCategories', () {
    final responseEntity = CategoryResponseEntity(
      message: "success",
      metadata: MetadataEntity(
        currentPage: 1,
        limit: 10,
        totalPages: 1,
        totalItems: 2,
      ),
      categories: [
        CategoryEntity(
          id: '1',
          name: 'Flowers',
          slug: 'flowers',
          image: 'image.jpg',
          createdAt: DateTime(2025, 1, 1),
          updatedAt: DateTime(2025, 1, 1),
          isSuperAdmin: false,
          productsCount: 10,
        ),
      ],
    );

    test("should return success when data source returns success", () async {
      // Arrange
      when(mockCategoriesRemoteDataSource.getAllCategories())
          .thenAnswer((_) async => ApiSuccessResult(data: responseEntity));

      //Act
      final result = await categoriesRepoImpl.getAllCategories();

      //Assert
      expect(result, isA<ApiSuccessResult<CategoryResponseEntity>>());
    });

    test("should return error when data source returns error", () async {
      // Arrange
      final failure = ServerFailure(errorMessage: 'Network error');
      when(mockCategoriesRemoteDataSource.getAllCategories())
          .thenAnswer((_) async => ApiErrorResult(failure: failure));

      //Act
      final result = await categoriesRepoImpl.getAllCategories();

      //Assert
      expect(result, isA<ApiErrorResult<CategoryResponseEntity>>());
    });

    test("should pass through the exact result from data source", () async {
      // Arrange
      final successResult = ApiSuccessResult(data: responseEntity);
      when(mockCategoriesRemoteDataSource.getAllCategories())
          .thenAnswer((_) async => successResult);

      //Act
      final result = await categoriesRepoImpl.getAllCategories();

      //Assert
      expect(result, equals(successResult));
      final successCast = result as ApiSuccessResult<CategoryResponseEntity>;
      expect(successCast.data.message, responseEntity.message);
      expect(successCast.data.categories.length, 1);
      expect(successCast.data.categories[0].name, 'Flowers');
    });
  });
}
