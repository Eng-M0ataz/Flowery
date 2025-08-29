import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/categories_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/product_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/useCases/categories_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/useCases/get_all_products_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/useCases/get_category_products_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/events/categories_event.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/states/categories_state.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoriesViewModel extends Cubit<CategoriesState> {
  final CategoriesUseCase _categoriesUseCase;
  final GetCategoryProductsUseCase _getCategoryProductsUseCase;
  final GetAllProductsUseCase _getAllProductsUseCase;

  CategoriesViewModel(
    this._categoriesUseCase,
    this._getCategoryProductsUseCase,
    this._getAllProductsUseCase,
  ) : super(CategoriesState());

  Future<void> doIntent(CategoriesEvent event) async {
    switch (event) {
      case GetAllProductsEvent():
        await _getAllProducts();
        break;

      case GetAllCategoriesEvent():
        await _getAllCategories();
        break;

      case GetCategoryProductsEvent():
        if (event.categoryId == 'all') {
          await _getAllProducts();
        } else {
          await _getCategoryProducts(event.categoryId, event.page, event.limit);
        }
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
          categoriesResponse: result.data,
          isSuccess: true,
          selectedCategoryId: 'all',
        ));
        await _getAllProducts();
        break;
      case ApiErrorResult<CategoryResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          errorMessage: result.failure.errorMessage,
          categoriesResponse: null,
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
      selectedCategoryId: 'all',
    ));

    final result = await _getAllProductsUseCase.invoke();
    switch (result) {
      case ApiSuccessResult<ProductResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          errorMessage: null,
          productsResponse: result.data,
          isSuccess: true,
          selectedCategoryId: 'all',
        ));
        break;
      case ApiErrorResult<ProductResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          errorMessage: result.failure.errorMessage,
          productsResponse: null,
          isSuccess: false,
          selectedCategoryId: 'all',
        ));
        break;
    }
  }

  Future<void> _getCategoryProducts(
      String categoryId, int? page, int? limit) async {
    emit(state.copyWith(
        isSuccess: false,
        isLoading: true,
        errorMessage: null,
        selectedCategoryId: categoryId));

    final result = await _getCategoryProductsUseCase.invoke(
        categoryId: categoryId, page: page, limit: limit);

    switch (result) {
      case ApiSuccessResult<ProductResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          errorMessage: null,
          productsResponse: result.data,
          isSuccess: true,
          selectedCategoryId: categoryId,
        ));
        break;
      case ApiErrorResult<ProductResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          errorMessage: result.failure.errorMessage,
          productsResponse: null,
          isSuccess: false,
        ));
        break;
    }
  }
}
