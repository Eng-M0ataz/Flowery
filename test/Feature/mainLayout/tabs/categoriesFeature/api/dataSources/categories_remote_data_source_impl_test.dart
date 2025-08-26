import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/client/api_service.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/dataSources/categories_remote_data_source_impl.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/response/category_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/category_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/metadata_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/categories_response_entity.dart';
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
}
