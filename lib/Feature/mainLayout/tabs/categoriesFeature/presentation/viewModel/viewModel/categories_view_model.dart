import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/request/get_category_products_request_model.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/product_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/categories_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/product_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/useCases/categories_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/useCases/get_all_products_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/useCases/get_products_by_category_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/events/categories_event.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/states/categories_state.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Functions/filter.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoriesViewModel extends Cubit<CategoriesState> {
  final CategoriesUseCase _categoriesUseCase;
  final GetProductsByCategoryUseCase _getCategoryProductsUseCase;
  final GetAllProductsUseCase _getAllProductsUseCase;
  final Filter _filter = Filter();

  CategoriesViewModel(
    this._categoriesUseCase,
    this._getCategoryProductsUseCase,
    this._getAllProductsUseCase,
  ) : super(const CategoriesState());

  void applyFilter(FilterType? filterType) {

    if (filterType == null) {
      emit(state.copyWith(
        filteredProducts: state.productsList,
        currentFilter: null,
        isLoading: false,
      ));
      return;
    }

    emit(state.copyWith(isLoading: true));

    try {
      final products = state.productsList ?? [];
      if (products.isEmpty) {
        emit(state.copyWith(isLoading: false));
        return;
      }

      final filteredProducts = _filter.filterList<ProductEntity>(
        items: products,
        filter: filterType,
        getCreatedAt: (p) => p.createdAt ?? DateTime.now(),
        getPrice: (p) => (p.price ?? 0).toInt(),
        getPriceAfterDiscount: (p) => p.priceAfterDiscount?.toInt(),
        getDiscountPercent: (p) => p.discountPercent,
      );


      emit(state.copyWith(
        filteredProducts: filteredProducts,
        currentFilter: filterType,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  void clearFilter() {
    emit(state.copyWith(
      filteredProducts: state.productsList,
      currentFilter: null,
      isLoading: false,
    ));
  }

  Future<void> doIntent(CategoriesEvent event) async {
    switch (event) {
      case GetAllCategoriesEvent():
        await _getAllCategories();
        break;

      case GetAllProductsEvent():
        await _getAllProducts();
        break;

      case GetProductsByCategoryEvent():
        await _getCategoryProducts(GetProductsByCategoryRequestModel(
          categoryId: event.categoryId,
          page: event.page ?? 1,
          limit: event.limit ?? 10,
        ));
        break;
    }
  }

  Future<void> _getAllCategories() async {
    emit(state.copyWith(isSuccess: false, isLoading: true, errorMessage: null));

    final result = await _categoriesUseCase.invoke();
    switch (result) {
      case ApiSuccessResult<CategoryResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          errorMessage: null,
          categories: result.data.categories,
          isSuccess: true,
          selectedCategoryId: state.selectedCategoryId ?? AppConstants.allId,
        ));
        break;
      case ApiErrorResult<CategoryResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          errorMessage: result.failure.errorMessage,
          categories: null,
          isSuccess: false,
        ));
        break;
    }
  }

  Future<void> _getAllProducts() async {
    emit(state.copyWith(
      isSuccess: false,
      isLoading: true,
      errorMessage: null,
      selectedCategoryId: AppConstants.allId,
      currentFilter: null,
      filteredProducts: []
    ));

    final result = await _getAllProductsUseCase.invoke();
    switch (result) {
      case ApiSuccessResult<ProductResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          errorMessage: null,
          productsList: result.data.products,
          filteredProducts: result.data.products,
          isSuccess: true,
          selectedCategoryId: AppConstants.allId,
        ));
        break;
      case ApiErrorResult<ProductResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          errorMessage: result.failure.errorMessage,
          productsList: null,
          isSuccess: false,
          selectedCategoryId: AppConstants.allId,
        ));
        break;
    }
  }

  Future<void> _getCategoryProducts(
      GetProductsByCategoryRequestModel requestModel) async {
    emit(state.copyWith(
      isSuccess: false,
      isLoading: true,
      errorMessage: null,
      selectedCategoryId: requestModel.categoryId,
      currentFilter: null,
      filteredProducts: []
    ));

    final result = await _getCategoryProductsUseCase.invoke(
      categoryId: requestModel.categoryId,
      page: requestModel.page,
      limit: requestModel.limit,
    );

    switch (result) {
      case ApiSuccessResult<ProductResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          errorMessage: null,
          productsList: result.data.products,
          filteredProducts: result.data.products,
          isSuccess: true,
          selectedCategoryId: requestModel.categoryId,
        ));
        break;

      case ApiErrorResult<ProductResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          errorMessage: result.failure.errorMessage,
          productsList: null,
          isSuccess: false,
        ));
        break;
    }
  }
}
