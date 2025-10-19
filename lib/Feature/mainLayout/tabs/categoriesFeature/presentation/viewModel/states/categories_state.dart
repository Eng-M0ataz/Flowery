import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/category_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/product_entity.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/response/add_product_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:flower_e_commerce_app/core/Functions/filter.dart';

class CategoriesState extends Equatable {
  final bool isCategoriesLoading;
  final bool isProductsLoading;
  final String? errorMessage;
  final List<CategoryEntity>? categories;
  final List<ProductEntity>? productsList;
  final List<ProductEntity>? filteredProducts;
  final FILTERTYPE? currentFilter;
  final bool isSuccess;
  final String? selectedCategoryId;
  final AddProductResponseEntity? addToCartResponse;
  final Failure? addToCartFailure;
  final String? productId;

  const CategoriesState({
    this.isCategoriesLoading = false,
    this.isProductsLoading = false,
    this.errorMessage,
    this.categories = const [],
    this.productsList = const [],
    this.filteredProducts = const [],
    this.currentFilter,
    this.isSuccess = false,
    this.selectedCategoryId,
    this.addToCartResponse,
    this.addToCartFailure,
    this.productId,
  });

  CategoriesState copyWith({
    bool? isCategoriesLoading,
    bool? isProductsLoading,
    String? errorMessage,
    List<CategoryEntity>? categories,
    List<ProductEntity>? productsList,
    List<ProductEntity>? filteredProducts,
    FILTERTYPE? currentFilter,
    bool? isSuccess,
    String? selectedCategoryId,
    AddProductResponseEntity? addToCartResponse,
    Failure? addToCartFailure,
    String? productId,
  }) {
    return CategoriesState(
      isCategoriesLoading: isCategoriesLoading ?? this.isCategoriesLoading,
      isProductsLoading: isProductsLoading ?? this.isProductsLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      categories: categories ?? this.categories,
      productsList: productsList ?? this.productsList,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      currentFilter: currentFilter ?? this.currentFilter,
      isSuccess: isSuccess ?? this.isSuccess,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      addToCartResponse: addToCartResponse ?? this.addToCartResponse,
      addToCartFailure: addToCartFailure ?? this.addToCartFailure,
      productId: productId,
    );
  }

  @override
  List<Object?> get props => [
        isCategoriesLoading,
        isProductsLoading,
        errorMessage,
        categories,
        productsList,
        filteredProducts,
        currentFilter,
        isSuccess,
        selectedCategoryId,
        addToCartResponse,
        addToCartFailure,
        productId,
      ];
}
