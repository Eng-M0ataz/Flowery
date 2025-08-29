import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/categories_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/product_response_entity.dart';

class CategoriesState {
  final bool isLoading;
  final String? errorMessage;
  final CategoryResponseEntity? categoriesResponse;
  final ProductResponseEntity? productsResponse;
  final bool isSuccess;
  final String? selectedCategoryId;

  CategoriesState({
    this.isLoading = false,
    this.errorMessage,
    this.categoriesResponse,
    this.productsResponse,
    this.isSuccess = false,
    this.selectedCategoryId,
  });

  CategoriesState copyWith({
    bool? isLoading,
    String? errorMessage,
    CategoryResponseEntity? categoriesResponse,
    ProductResponseEntity? productsResponse,
    bool? isSuccess,
    String? selectedCategoryId,
  }) {
    return CategoriesState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      categoriesResponse: categoriesResponse ?? this.categoriesResponse,
      productsResponse: productsResponse ?? this.productsResponse,
      isSuccess: isSuccess ?? this.isSuccess,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
    );
  }
}
