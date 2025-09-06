import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/client/api_service.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/dataSources/categories_remote_data_source_impl.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/product_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/request/get_category_products_request_model.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/response/category_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/category_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/metadata_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/response/product_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/categories_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/product_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:dio/dio.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'categories_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late MockApiServices mockApiServices;
  late CategoriesRemoteDataSourceImpl categoriesRemoteDataSourceImpl;
  setUp(() {
    mockApiServices = MockApiServices();
    categoriesRemoteDataSourceImpl =
        CategoriesRemoteDataSourceImpl(apiServicest: mockApiServices);
  });
  group('getAllCategories', () {
    final responseDto = CategoryResponseDto(
      message: "success",
      metadata: MetadataDto(
        currentPage: 1,
        limit: 10,
        totalPages: 1,
        totalItems: 2,
      ),
      categories: [
        CategoryDto(
          id: '1',
          name: 'Flowers',
          slug: 'flowers',
          image: 'image.jpg',
          createdAt: '2025-01-01',
          updatedAt: '2025-01-01',
          isSuperAdmin: false,
          productsCount: 10,
        ),
      ],
    );
    test("should return success with Api Call ", () async {
      // Arrange
      when(mockApiServices.getAllCategories())
          .thenAnswer((_) async => responseDto);

      //Act
      final result = await categoriesRemoteDataSourceImpl.getAllCategories();

      //Assert
      expect(result, isA<ApiSuccessResult<CategoryResponseEntity>>());
    });

    test("should return error when DioException occurs ", () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/categories'),
        response: Response(
          requestOptions: RequestOptions(path: '/categories'),
          statusCode: 500,
        ),
      );
      when(mockApiServices.getAllCategories()).thenThrow(dioException);
      //Act
      final result = await categoriesRemoteDataSourceImpl.getAllCategories();

      //Assert
      expect(result, isA<ApiErrorResult<CategoryResponseEntity>>());
    });

    test("should return error when other exception occurs", () async {
      // Arrange
      when(mockApiServices.getAllCategories())
          .thenThrow(Exception('Network error'));

      //Act
      final result = await categoriesRemoteDataSourceImpl.getAllCategories();

      //Assert
      expect(result, isA<ApiErrorResult<CategoryResponseEntity>>());
    });
  });

  group('getCategoryProducts', () {
    final requestModal = GetCategoryProductsRequestModel(
      categoryId: 'category123',
      page: 1,
      limit: 10,
    );
    final responseDto = ProductResponseDto(
      message: "success",
      metadata: MetadataDto(
        currentPage: 1,
        limit: 10,
        totalPages: 1,
        totalItems: 2,
      ),
      products: [
        ProductDto(
          id: '1',
          title: 'Rose Bouquet',
          slug: 'rose-bouquet',
          description: 'Beautiful rose bouquet',
          price: 100.0,
          priceAfterDiscount: 80.0,
          quantity: 5,
          sold: 10,
          rateAvg: 4,
          rateCount: 20,
          imgCover: 'rose.jpg',
          images: ['rose1.jpg', 'rose2.jpg'],
          category: 'flowers',
          createdAt: '2025-01-01',
          updatedAt: '2025-01-01',
          isSuperAdmin: false,
          occasion: 'Flowers',
        ),
        ProductDto(
          id: '2',
          title: 'Tulip Bouquet',
          slug: 'tulip-bouquet',
          description: 'Beautiful tulip bouquet',
          price: 120.0,
          priceAfterDiscount: 100.0,
          quantity: 8,
          sold: 5,
          rateAvg: 3,
          rateCount: 15,
          imgCover: 'tulip.jpg',
          images: ['tulip1.jpg', 'tulip2.jpg'],
          category: 'flowers',
          isSuperAdmin: false,
          occasion: 'Flowers2',
          createdAt: '2025-01-01',
          updatedAt: '2025-01-01',
        ),
      ],
    );

    test("should return success with Api Call ", () async {
      // Arrange
      when(mockApiServices.getProducts(any))
          .thenAnswer((_) async => responseDto);

      //Act
      final result = await categoriesRemoteDataSourceImpl
          .getCategoryProducts(requestModal);

      //Assert
      expect(result, isA<ApiSuccessResult<ProductResponseEntity>>());
    });

    test("should return error when DioException occurs ", () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/products'),
        response: Response(
          requestOptions: RequestOptions(path: '/products'),
          statusCode: 500,
        ),
      );
      when(mockApiServices.getProducts(any)).thenThrow(dioException);
      //Act
      final result = await categoriesRemoteDataSourceImpl
          .getCategoryProducts(requestModal);

      //Assert
      expect(result, isA<ApiErrorResult<ProductResponseEntity>>());
    });

    test("should return error when other exception occurs", () async {
      // Arrange
      when(mockApiServices.getProducts(any))
          .thenThrow(Exception('Network error'));

      //Act
      final result = await categoriesRemoteDataSourceImpl
          .getCategoryProducts(requestModal);

      //Assert
      expect(result, isA<ApiErrorResult<ProductResponseEntity>>());
    });
  });

  group('getAllProducts', () {
    final responseDto = ProductResponseDto(
      message: "success",
      metadata: MetadataDto(
        currentPage: 1,
        limit: 20,
        totalPages: 1,
        totalItems: 3,
      ),
      products: [
        ProductDto(
          id: '1',
          title: 'Rose Bouquet',
          slug: 'rose-bouquet',
          description: 'Beautiful rose bouquet',
          price: 100.0,
          priceAfterDiscount: 80.0,
          quantity: 5,
          sold: 10,
          rateAvg: 4,
          rateCount: 20,
          imgCover: 'rose.jpg',
          images: ['rose1.jpg', 'rose2.jpg'],
          category: 'flowers',
          createdAt: '2025-01-01',
          updatedAt: '2025-01-01',
          isSuperAdmin: false,
          occasion: 'Flowers',
        ),
        ProductDto(
          id: '2',
          title: 'Tulip Bouquet',
          slug: 'tulip-bouquet',
          description: 'Beautiful tulip bouquet',
          price: 120.0,
          priceAfterDiscount: 100.0,
          quantity: 8,
          sold: 5,
          rateAvg: 3,
          rateCount: 15,
          imgCover: 'tulip.jpg',
          images: ['tulip1.jpg', 'tulip2.jpg'],
          category: 'flowers',
          isSuperAdmin: false,
          occasion: 'Flowers2',
          createdAt: '2025-01-01',
          updatedAt: '2025-01-01',
        ),
      ],
    );

    test("should return success with Api Call ", () async {
      // Arrange
      when(mockApiServices.getAllProducts())
          .thenAnswer((_) async => responseDto);

      //Act
      final result = await categoriesRemoteDataSourceImpl.getAllProducts();

      //Assert
      expect(result, isA<ApiSuccessResult<ProductResponseEntity>>());
    });

    test("should return error when DioException occurs ", () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: '/products'),
        response: Response(
          requestOptions: RequestOptions(path: '/products'),
          statusCode: 500,
        ),
      );
      when(mockApiServices.getAllProducts()).thenThrow(dioException);
      //Act
      final result = await categoriesRemoteDataSourceImpl.getAllProducts();

      //Assert
      expect(result, isA<ApiErrorResult<ProductResponseEntity>>());
    });

    test("should return error when other exception occurs", () async {
      // Arrange
      when(mockApiServices.getAllProducts())
          .thenThrow(Exception('Network error'));

      //Act
      final result = await categoriesRemoteDataSourceImpl.getAllProducts();

      //Assert
      expect(result, isA<ApiErrorResult<ProductResponseEntity>>());
    });
  });
}
