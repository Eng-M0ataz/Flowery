import 'package:bloc_test/bloc_test.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/category_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/metadata_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/product_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/categories_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/product_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/useCases/categories_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/useCases/get_all_products_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/useCases/get_products_by_category_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/events/categories_event.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/states/categories_state.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/viewModel/categories_view_model.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/app_constants.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'categories_view_model_test.mocks.dart';

@GenerateMocks([
  CategoriesUseCase,
  GetProductsByCategoryUseCase,
  GetAllProductsUseCase,
])
void main() {
  late MockCategoriesUseCase mockCategoriesUseCase;
  late MockGetProductsByCategoryUseCase mockGetProductsByCategoryUseCase;
  late MockGetAllProductsUseCase mockGetAllProductsUseCase;

  late List<CategoryEntity> categoryEntityList;
  late CategoryResponseEntity categoryResponseEntity;
  late ApiResult<CategoryResponseEntity> catResult;

  late List<ProductEntity> productList;
  late ProductResponseEntity productResponseEntity;
  late ApiResult<ProductResponseEntity> productResult;

  setUpAll(() {
    mockCategoriesUseCase = MockCategoriesUseCase();
    mockGetProductsByCategoryUseCase = MockGetProductsByCategoryUseCase();
    mockGetAllProductsUseCase = MockGetAllProductsUseCase();

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

  blocTest<CategoriesViewModel, CategoriesState>(
    "should load categories and then all products",
    build: () => CategoriesViewModel(
      mockCategoriesUseCase,
      mockGetProductsByCategoryUseCase,
      mockGetAllProductsUseCase,
    ),
    act: (viewModel) async {
      provideDummy<ApiResult<CategoryResponseEntity>>(catResult);
      provideDummy<ApiResult<ProductResponseEntity>>(productResult);

      when(mockCategoriesUseCase.invoke()).thenAnswer((_) async => catResult);
      when(mockGetAllProductsUseCase.invoke())
          .thenAnswer((_) async => productResult);

      await viewModel.doIntent(const GetAllCategoriesEvent());
      await viewModel.doIntent(const GetAllProductsEvent());
    },
    expect: () => [
      const CategoriesState(
        isCategoriesLoading: true,
        isProductsLoading: false,
        isSuccess: false,
        errorMessage: null,
        categories: [],
        productsList: [],
        selectedCategoryId: null,
      ),
      CategoriesState(
        isCategoriesLoading: false,
        isProductsLoading: false,
        isSuccess: true,
        errorMessage: null,
        categories: categoryEntityList,
        productsList: [],
        selectedCategoryId: AppConstants.allId,
      ),
      CategoriesState(
        isCategoriesLoading: false,
        isProductsLoading: true,
        isSuccess: false,
        errorMessage: null,
        categories: categoryEntityList,
        productsList: const [],
        selectedCategoryId: AppConstants.allId,
      ),
      CategoriesState(
        isCategoriesLoading: false,
        isProductsLoading: false,
        isSuccess: true,
        errorMessage: null,
        categories: categoryEntityList,
        productsList: productList,
        selectedCategoryId: AppConstants.allId,
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
      mockGetProductsByCategoryUseCase,
      mockGetAllProductsUseCase,
    ),
    act: (viewModel) async {
      provideDummy<ApiResult<ProductResponseEntity>>(productResult);
      when(mockGetProductsByCategoryUseCase.invoke(
        categoryId: "1",
        page: 1,
        limit: 10,
      )).thenAnswer((_) async => productResult);

      await viewModel.doIntent(
        const GetProductsByCategoryEvent(categoryId: "1", page: 1, limit: 10),
      );
    },
    expect: () => [
      const CategoriesState(
        isCategoriesLoading: false,
        isProductsLoading: true,
        isSuccess: false,
        errorMessage: null,
        categories: [],
        productsList: [],
        selectedCategoryId: "1",
      ),
      CategoriesState(
        isCategoriesLoading: false,
        isProductsLoading: false,
        isSuccess: true,
        errorMessage: null,
        categories: const [],
        productsList: productList,
        selectedCategoryId: "1",
      ),
    ],
    verify: (viewModel) {
      verify(mockGetProductsByCategoryUseCase.invoke(
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
      mockGetProductsByCategoryUseCase,
      mockGetAllProductsUseCase,
    ),
    act: (viewModel) async {
      provideDummy<ApiResult<ProductResponseEntity>>(productResult);
      when(mockGetAllProductsUseCase.invoke())
          .thenAnswer((_) async => productResult);

      await viewModel.doIntent(const GetAllProductsEvent());
    },
    expect: () => [
      const CategoriesState(
        isCategoriesLoading: false,
        isProductsLoading: true,
        isSuccess: false,
        errorMessage: null,
        categories: [],
        productsList: [],
        selectedCategoryId: AppConstants.allId,
      ),
      CategoriesState(
        isCategoriesLoading: false,
        isProductsLoading: false,
        isSuccess: true,
        errorMessage: null,
        categories: const [],
        productsList: productList,
        selectedCategoryId: AppConstants.allId,
      ),
    ],
    verify: (viewModel) {
      verify(mockGetAllProductsUseCase.invoke()).called(1);
    },
  );
}
