import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/categories_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/product_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/category_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/product_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/metadata_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/useCases/categories_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/useCases/get_all_products_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/useCases/get_category_products_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/events/categories_event.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/states/categories_state.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/viewModel/categories_view_model.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'categories_view_model_test.mocks.dart';

@GenerateMocks([
  CategoriesUseCase,
  GetCategoryProductsUseCase,
  GetAllProductsUseCase,
])
void main() {
  // Provide dummy values for Mockito
  provideDummy<ApiResult<CategoryResponseEntity>>(
    ApiSuccessResult<CategoryResponseEntity>(
      data: CategoryResponseEntity(
        message: "dummy",
        metadata: MetadataEntity(currentPage: 0, limit: 0, totalPages: 0, totalItems: 0),
        categories: [],
      ),
    ),
  );

  provideDummy<ApiResult<ProductResponseEntity>>(
    ApiSuccessResult<ProductResponseEntity>(
      data: ProductResponseEntity(
        message: "dummy",
        metadata: MetadataEntity(currentPage: 0, limit: 0, totalPages: 0, totalItems: 0),
        products: [],
      ),
    ),
  );
  late CategoriesViewModel viewModel;
  late MockCategoriesUseCase mockCategoriesUseCase;
  late MockGetCategoryProductsUseCase mockGetCategoryProductsUseCase;
  late MockGetAllProductsUseCase mockGetAllProductsUseCase;

  // Test data
  final categoriesResponse = CategoryResponseEntity(
    message: "Success",
    metadata: MetadataEntity(currentPage: 1, limit: 10, totalPages: 1, totalItems: 2),
    categories: [
      CategoryEntity(id: '1', name: 'Flowers', image: 'flower.jpg', productsCount: 5),
      CategoryEntity(id: '2', name: 'Plants', image: 'plant.jpg', productsCount: 3),
    ],
  );

  final productsResponse = ProductResponseEntity(
    message: "Success",
    metadata: MetadataEntity(currentPage: 1, limit: 10, totalPages: 1, totalItems: 2),
    products: [
      ProductEntity(
        id: '1',
        title: 'Rose',
        description: 'Beautiful rose',
        price: 20.0,
        category: '1',
        quantity: 10,
      ),
      ProductEntity(
        id: '2',
        title: 'Tulip',
        description: 'Fresh tulip',
        price: 15.0,
        category: '1',
        quantity: 8,
      ),
    ],
  );

  setUp(() {
    mockCategoriesUseCase = MockCategoriesUseCase();
    mockGetCategoryProductsUseCase = MockGetCategoryProductsUseCase();
    mockGetAllProductsUseCase = MockGetAllProductsUseCase();

    viewModel = CategoriesViewModel(
      mockCategoriesUseCase,
      mockGetCategoryProductsUseCase,
      mockGetAllProductsUseCase,
    );
  });

  group('GetAllCategoriesEvent', () {
    test('should emit loading then success states when categories loaded successfully', () async {
      // Arrange
      when(mockCategoriesUseCase.invoke())
          .thenAnswer((_) async => ApiSuccessResult(data: categoriesResponse));
      when(mockGetAllProductsUseCase.invoke())
          .thenAnswer((_) async => ApiSuccessResult(data: productsResponse));

      // Act
      final states = <CategoriesState>[];
      viewModel.stream.listen((state) => states.add(state));
      
      await viewModel.doIntent(GetAllCategoriesEvent());

      // Assert
      expect(states.length, 3); // initial loading, categories success, products success
      
      // First emission - loading state
      expect(states[0].isLoading, true);
      expect(states[0].isSuccess, false);
      expect(states[0].errorMessage, null);

      // Second emission - categories loaded
      expect(states[1].isLoading, false);
      expect(states[1].isSuccess, true);
      expect(states[1].categoriesResponse, categoriesResponse);
      expect(states[1].selectedCategoryId, 'all');

      // Third emission - products loaded
      expect(states[2].productsResponse, productsResponse);
    });

    test('should emit loading then error states when categories fail to load', () async {
      // Arrange
      final failure = ServerFailure(errorMessage: 'Network error');
      when(mockCategoriesUseCase.invoke())
          .thenAnswer((_) async => ApiErrorResult(failure: failure));

      // Act
      final states = <CategoriesState>[];
      viewModel.stream.listen((state) => states.add(state));
      
      await viewModel.doIntent(GetAllCategoriesEvent());

      // Assert
      expect(states.length, 2); // loading, then error
      
      expect(states[0].isLoading, true);
      expect(states[1].isLoading, false);
      expect(states[1].isSuccess, false);
      expect(states[1].errorMessage, 'Network error');
      expect(states[1].categoriesResponse, null);
    });
  });

  group('GetAllProductsEvent', () {
    test('should emit loading then success states when products loaded successfully', () async {
      // Arrange
      when(mockGetAllProductsUseCase.invoke())
          .thenAnswer((_) async => ApiSuccessResult(data: productsResponse));

      // Act
      final states = <CategoriesState>[];
      viewModel.stream.listen((state) => states.add(state));
      
      await viewModel.doIntent(GetAllProductsEvent());

      // Assert
      expect(states.length, 2); // loading, then success
      
      expect(states[0].isLoading, true);
      expect(states[0].selectedCategoryId, 'all');
      
      expect(states[1].isLoading, false);
      expect(states[1].isSuccess, true);
      expect(states[1].productsResponse, productsResponse);
      expect(states[1].selectedCategoryId, 'all');
    });

    test('should emit loading then error states when products fail to load', () async {
      // Arrange
      final failure = ServerFailure(errorMessage: 'Failed to load products');
      when(mockGetAllProductsUseCase.invoke())
          .thenAnswer((_) async => ApiErrorResult(failure: failure));

      // Act
      final states = <CategoriesState>[];
      viewModel.stream.listen((state) => states.add(state));
      
      await viewModel.doIntent(GetAllProductsEvent());

      // Assert
      expect(states.length, 2);
      
      expect(states[1].isLoading, false);
      expect(states[1].isSuccess, false);
      expect(states[1].errorMessage, 'Failed to load products');
      expect(states[1].selectedCategoryId, 'all');
    });
  });

  group('GetCategoryProductsEvent', () {
    test('should call getAllProducts when categoryId is "all"', () async {
      // Arrange
      when(mockGetAllProductsUseCase.invoke())
          .thenAnswer((_) async => ApiSuccessResult(data: productsResponse));

      // Act
      await viewModel.doIntent(GetCategoryProductsEvent(
        categoryId: 'all',
        page: 1,
        limit: 10,
      ));

      // Assert
      verify(mockGetAllProductsUseCase.invoke()).called(1);
      verifyNever(mockGetCategoryProductsUseCase.invoke(
        categoryId: anyNamed('categoryId'),
        page: anyNamed('page'),
        limit: anyNamed('limit'),
      ));
    });

    test('should load category products successfully when categoryId is not "all"', () async {
      // Arrange
      when(mockGetCategoryProductsUseCase.invoke(
        categoryId: '1',
        page: 1,
        limit: 10,
      )).thenAnswer((_) async => ApiSuccessResult(data: productsResponse));

      // Act
      final states = <CategoriesState>[];
      viewModel.stream.listen((state) => states.add(state));
      
      await viewModel.doIntent(GetCategoryProductsEvent(
        categoryId: '1',
        page: 1,
        limit: 10,
      ));

      // Assert
      expect(states.length, 2);
      
      expect(states[0].isLoading, true);
      expect(states[0].selectedCategoryId, '1');
      
      expect(states[1].isLoading, false);
      expect(states[1].isSuccess, true);
      expect(states[1].productsResponse, productsResponse);
      expect(states[1].selectedCategoryId, '1');
      
      verify(mockGetCategoryProductsUseCase.invoke(
        categoryId: '1',
        page: 1,
        limit: 10,
      )).called(1);
    });

    test('should emit error when category products fail to load', () async {
      // Arrange
      final failure = ServerFailure(errorMessage: 'Category not found');
      when(mockGetCategoryProductsUseCase.invoke(
        categoryId: '1',
        page: 1,
        limit: 10,
      )).thenAnswer((_) async => ApiErrorResult(failure: failure));

      // Act
      final states = <CategoriesState>[];
      viewModel.stream.listen((state) => states.add(state));
      
      await viewModel.doIntent(GetCategoryProductsEvent(
        categoryId: '1',
        page: 1,
        limit: 10,
      ));

      // Assert
      expect(states.length, 2);
      
      expect(states[1].isLoading, false);
      expect(states[1].isSuccess, false);
      expect(states[1].errorMessage, 'Category not found');
      expect(states[1].productsResponse, null);
      expect(states[1].selectedCategoryId, null); // Should not be set on error
    });
  });

  group('Initial State', () {
    test('should have correct initial state', () {
      // Assert
      expect(viewModel.state.isLoading, false);
      expect(viewModel.state.isSuccess, false);
      expect(viewModel.state.errorMessage, null);
      expect(viewModel.state.categoriesResponse, null);
      expect(viewModel.state.productsResponse, null);
      expect(viewModel.state.selectedCategoryId, null);
    });
  });
}