import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/data/dataSources/categories_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/data/repositories/categories_repo_impl.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/product_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/requestEntities/get_category_products_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/categories_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/category_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/metadata_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/product_response_entity.dart';
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

  provideDummy<ApiResult<ProductResponseEntity>>(
    ApiSuccessResult<ProductResponseEntity>(
      data: ProductResponseEntity(
        message: "dummy",
        metadata: MetadataEntity(
          currentPage: 0,
          limit: 0,
          totalPages: 0,
          totalItems: 0,
        ),
        products: [],
      ),
    ),
  );

  provideDummy<GetCategoryProductsRequestEntity>(
    GetCategoryProductsRequestEntity(
      categoryId: "dummy",
      page: 1,
      limit: 10,
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
          image: 'image.jpg',
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

  group('getCategoryProducts', () {
    final requestEntity = GetCategoryProductsRequestEntity(
      categoryId: '1',
      page: 1,
      limit: 10,
    );

    final productResponseEntity = ProductResponseEntity(
      message: "success",
      metadata: MetadataEntity(
        currentPage: 1,
        limit: 10,
        totalPages: 1,
        totalItems: 2,
      ),
      products: [
        ProductEntity(
          id: '1',
          title: 'Rose Bouquet',
          description: 'Beautiful red roses',
          imgCover: 'rose1.jpg',
          price: 25.99,
          priceAfterDiscount: 22.99,
          quantity: 5,
          category: '1',
          sold: 12,
        ),
        ProductEntity(
          id: '2',
          title: 'Tulip Bundle',
          description: 'Fresh tulips',
          imgCover: 'tulip1.jpg',
          price: 18.50,
          priceAfterDiscount: 16.99,
          quantity: 8,
          category: '1',
          sold: 5,
        ),
      ],
    );

    test("should return success when data source returns success", () async {
      // Arrange
      when(mockCategoriesRemoteDataSource.getCategoryProducts(requestEntity))
          .thenAnswer(
              (_) async => ApiSuccessResult(data: productResponseEntity));

      //Act
      final result =
          await categoriesRepoImpl.getCategoryProducts(requestEntity);

      //Assert
      expect(result, isA<ApiSuccessResult<ProductResponseEntity>>());
      verify(mockCategoriesRemoteDataSource.getCategoryProducts(requestEntity))
          .called(1);
    });

    test("should return error when data source returns error", () async {
      // Arrange
      final failure = ServerFailure(errorMessage: 'Failed to fetch products');
      when(mockCategoriesRemoteDataSource.getCategoryProducts(requestEntity))
          .thenAnswer((_) async => ApiErrorResult(failure: failure));

      //Act
      final result =
          await categoriesRepoImpl.getCategoryProducts(requestEntity);

      //Assert
      expect(result, isA<ApiErrorResult<ProductResponseEntity>>());
      verify(mockCategoriesRemoteDataSource.getCategoryProducts(requestEntity))
          .called(1);
    });

    test("should pass through the exact result from data source", () async {
      // Arrange
      final successResult = ApiSuccessResult(data: productResponseEntity);
      when(mockCategoriesRemoteDataSource.getCategoryProducts(requestEntity))
          .thenAnswer((_) async => successResult);

      //Act
      final result =
          await categoriesRepoImpl.getCategoryProducts(requestEntity);

      //Assert
      expect(result, equals(successResult));
      final successCast = result as ApiSuccessResult<ProductResponseEntity>;
      expect(successCast.data.message, productResponseEntity.message);
      expect(successCast.data.products!.length, 2);
      expect(successCast.data.products![0].title, 'Rose Bouquet');
      expect(successCast.data.products![0].category, '1');
      expect(successCast.data.products![1].title, 'Tulip Bundle');
      verify(mockCategoriesRemoteDataSource.getCategoryProducts(requestEntity))
          .called(1);
    });

    test("should pass correct request parameters to data source", () async {
      // Arrange
      when(mockCategoriesRemoteDataSource.getCategoryProducts(any)).thenAnswer(
          (_) async => ApiSuccessResult(data: productResponseEntity));

      //Act
      await categoriesRepoImpl.getCategoryProducts(requestEntity);

      //Assert
      verify(mockCategoriesRemoteDataSource.getCategoryProducts(argThat(
              predicate<GetCategoryProductsRequestEntity>((req) =>
                  req.categoryId == '1' && req.page == 1 && req.limit == 10))))
          .called(1);
    });
  });

  group('getAllProducts', () {
    final allProductsResponseEntity = ProductResponseEntity(
      message: "success",
      metadata: MetadataEntity(
        currentPage: 1,
        limit: 20,
        totalPages: 2,
        totalItems: 25,
      ),
      products: [
        ProductEntity(
          id: '1',
          title: 'Rose Bouquet',
          description: 'Beautiful red roses',
          imgCover: 'rose1.jpg',
          price: 25.99,
          priceAfterDiscount: 22.99,
          quantity: 5,
          category: '1',
          sold: 12,
        ),
        ProductEntity(
          id: '2',
          title: 'Sunflower',
          description: 'Bright sunflowers',
          imgCover: 'sunflower1.jpg',
          price: 12.99,
          priceAfterDiscount: 11.99,
          quantity: 15,
          category: '2',
          sold: 8,
        ),
        ProductEntity(
          id: '3',
          title: 'Lily Arrangement',
          description: 'White lilies',
          imgCover: 'lily1.jpg',
          price: 35.00,
          priceAfterDiscount: 32.00,
          quantity: 3,
          category: '3',
          sold: 2,
        ),
      ],
    );

    test("should return success when data source returns success", () async {
      // Arrange
      when(mockCategoriesRemoteDataSource.getAllProducts()).thenAnswer(
          (_) async => ApiSuccessResult(data: allProductsResponseEntity));

      //Act
      final result = await categoriesRepoImpl.getAllProducts();

      //Assert
      expect(result, isA<ApiSuccessResult<ProductResponseEntity>>());
      verify(mockCategoriesRemoteDataSource.getAllProducts()).called(1);
    });

    test("should return error when data source returns error", () async {
      // Arrange
      final failure = ServerFailure(errorMessage: 'Connection timeout');
      when(mockCategoriesRemoteDataSource.getAllProducts())
          .thenAnswer((_) async => ApiErrorResult(failure: failure));

      //Act
      final result = await categoriesRepoImpl.getAllProducts();

      //Assert
      expect(result, isA<ApiErrorResult<ProductResponseEntity>>());
      verify(mockCategoriesRemoteDataSource.getAllProducts()).called(1);
    });

    test("should pass through the exact result from data source", () async {
      // Arrange
      final successResult = ApiSuccessResult(data: allProductsResponseEntity);
      when(mockCategoriesRemoteDataSource.getAllProducts())
          .thenAnswer((_) async => successResult);

      //Act
      final result = await categoriesRepoImpl.getAllProducts();

      //Assert
      expect(result, equals(successResult));
      final successCast = result as ApiSuccessResult<ProductResponseEntity>;
      expect(successCast.data.message, allProductsResponseEntity.message);
      expect(successCast.data.products!.length, 3);
      expect(successCast.data.products![0].title, 'Rose Bouquet');
      expect(successCast.data.products![1].title, 'Sunflower');
      expect(successCast.data.products![2].title, 'Lily Arrangement');
      expect(successCast.data.metadata!.totalItems, 25);
      verify(mockCategoriesRemoteDataSource.getAllProducts()).called(1);
    });

    test("should handle empty products list", () async {
      // Arrange
      final emptyResponseEntity = ProductResponseEntity(
        message: "No products found",
        metadata: MetadataEntity(
          currentPage: 1,
          limit: 20,
          totalPages: 0,
          totalItems: 0,
        ),
        products: [],
      );
      when(mockCategoriesRemoteDataSource.getAllProducts())
          .thenAnswer((_) async => ApiSuccessResult(data: emptyResponseEntity));

      //Act
      final result = await categoriesRepoImpl.getAllProducts();

      //Assert
      expect(result, isA<ApiSuccessResult<ProductResponseEntity>>());
      final successCast = result as ApiSuccessResult<ProductResponseEntity>;
      expect(successCast.data.products, isEmpty);
      expect(successCast.data.metadata!.totalItems, 0);
      verify(mockCategoriesRemoteDataSource.getAllProducts()).called(1);
    });
  });
}
