import 'package:bloc_test/bloc_test.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/category_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/metadata_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/product_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/categories_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/product_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/useCases/categories_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/useCases/get_all_products_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/useCases/get_category_products_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/events/categories_event.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/states/categories_state.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/viewModel/categories_view_model.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'categories_view_model_test.mocks.dart';

@GenerateMocks([
  CategoriesUseCase,
  GetCategoryProductsUseCase,
  GetAllProductsUseCase,
])
void main() {
  late CategoriesViewModel categoriesViewModel;
  late MockCategoriesUseCase mockCategoriesUseCase;
  late MockGetCategoryProductsUseCase mockGetCategoryProductsUseCase;
  late MockGetAllProductsUseCase mockGetAllProductsUseCase;

  late List<CategoryEntity> categoryEntityList;
  late CategoryResponseEntity categoryResponseEntity;
  late ApiResult<CategoryResponseEntity> catResult;

  late List<ProductEntity> productList;
  late ProductResponseEntity productResponseEntity;
  late ApiResult<ProductResponseEntity> productResult;

  setUpAll(() {
    mockCategoriesUseCase = MockCategoriesUseCase();
    mockGetCategoryProductsUseCase = MockGetCategoryProductsUseCase();
    mockGetAllProductsUseCase = MockGetAllProductsUseCase();

    categoriesViewModel = CategoriesViewModel(
      mockCategoriesUseCase,
      mockGetCategoryProductsUseCase,
      mockGetAllProductsUseCase,
    );

    /// Categories
    categoryEntityList = [
      CategoryEntity(
        id: "1",
        name: "Category 1",
        image: "img1",
        productsCount: 2,
      ),
      CategoryEntity(
        id: "2",
        name: "Category 2",
        image: "img2",
        productsCount: 3,
      ),
    ];
    categoryResponseEntity = CategoryResponseEntity(
      message: "ok",
      metadata: MetadataEntity(
        currentPage: 1,
        limit: 10,
        totalItems: 2,
        totalPages: 1,
      ),
      categories: categoryEntityList,
    );
    catResult = ApiSuccessResult<CategoryResponseEntity>(
      data: categoryResponseEntity,
    );

    /// Products
    productList = [
      ProductEntity(
        id: "p1",
        title: "Product 1",
        description: "desc1",
        imgCover: "img1",
        price: 100,
        priceAfterDiscount: 90,
        quantity: 5,
        sold: 2,
        category: "cat1",
      ),
      ProductEntity(
        id: "p2",
        title: "Product 2",
        description: "desc2",
        imgCover: "img2",
        price: 200,
        priceAfterDiscount: 180,
        quantity: 10,
        sold: 5,
        category: "cat2",
      ),
    ];
    productResponseEntity = ProductResponseEntity(
      message: "ok",
      metadata: MetadataEntity(
        currentPage: 1,
        limit: 10,
        totalItems: 2,
        totalPages: 1,
      ),
      products: productList,
    );
    productResult = ApiSuccessResult<ProductResponseEntity>(
      data: productResponseEntity,
    );
  });

  group("CategoriesViewModel Tests", () {
    blocTest<CategoriesViewModel, CategoriesState>(
      "should load categories and then all products",
      build: () => CategoriesViewModel(
        mockCategoriesUseCase,
        mockGetCategoryProductsUseCase,
        mockGetAllProductsUseCase,
      ),
      act: (viewModel) async {
        provideDummy<ApiResult<CategoryResponseEntity>>(catResult);
        provideDummy<ApiResult<ProductResponseEntity>>(productResult);

        when(mockCategoriesUseCase.invoke()).thenAnswer((_) async => catResult);
        when(mockGetAllProductsUseCase.invoke())
            .thenAnswer((_) async => productResult);

        await viewModel.doIntent(GetAllCategoriesEvent());
      },
      skip: 2, 
      expect: () => [
        CategoriesState(
          isLoading: true,
          isSuccess: false,
          errorMessage: null,
          categories: categoryEntityList,
          productsList: const [],
          selectedCategoryId: "all",
        ),
        CategoriesState(
          isLoading: false,
          isSuccess: true,
          errorMessage: null,
          categories: categoryEntityList,
          productsList: productList,
          selectedCategoryId: "all",
        ),
      ],
      verify: (viewModel) {
        verify(mockCategoriesUseCase.invoke()).called(1);
        verify(mockGetAllProductsUseCase.invoke()).called(1);
      },
    );

    blocTest<CategoriesViewModel, CategoriesState>(
      "should load products by category",
      build: () => CategoriesViewModel(
        mockCategoriesUseCase,
        mockGetCategoryProductsUseCase,
        mockGetAllProductsUseCase,
      ),
      act: (viewModel) async {
        provideDummy<ApiResult<ProductResponseEntity>>(productResult);
        when(mockGetCategoryProductsUseCase.invoke(
          categoryId: "1",
          page: 1,
          limit: 10,
        )).thenAnswer((_) async => productResult);

        await viewModel.doIntent(
          GetCategoryProductsEvent(categoryId: "1", page: 1, limit: 10),
        );
      },
      skip: 1,
      expect: () => [
        CategoriesState(
          isLoading: false,
          isSuccess: true,
          errorMessage: null,
          categories: const [],
          productsList: productList,
          selectedCategoryId: "1",
        ),
      ],
      verify: (viewModel) {
        verify(mockGetCategoryProductsUseCase.invoke(
          categoryId: "1",
          page: 1,
          limit: 10,
        )).called(1);
      },
    );

    blocTest<CategoriesViewModel, CategoriesState>(
      "should load all products",
      build: () => CategoriesViewModel(
        mockCategoriesUseCase,
        mockGetCategoryProductsUseCase,
        mockGetAllProductsUseCase,
      ),
      act: (viewModel) async {
        provideDummy<ApiResult<ProductResponseEntity>>(productResult);
        when(mockGetAllProductsUseCase.invoke())
            .thenAnswer((_) async => productResult);

        await viewModel.doIntent(GetAllProductsEvent());
      },
      skip: 1,
      expect: () => [
        CategoriesState(
          isLoading: false,
          isSuccess: true,
          errorMessage: null,
          categories: const [],
          productsList: productList,
          selectedCategoryId: "all",
        ),
      ],
      verify: (viewModel) {
        verify(mockGetAllProductsUseCase.invoke()).called(1);
      },
    );
  });
}
