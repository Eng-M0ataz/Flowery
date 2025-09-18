import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/category_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/product_entity.dart';
import 'package:flower_e_commerce_app/core/Functions/filter.dart';

class CategoriesState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final List<CategoryEntity>? categories;
  final List<ProductEntity>? productsList;
  final List<ProductEntity>? filteredProducts;
  final FilterType? currentFilter;
  final bool isSuccess;
  final String? selectedCategoryId;

  const CategoriesState({
    this.isLoading = false,
    this.errorMessage,
    this.categories = const [],
    this.productsList = const [],
    this.filteredProducts = const [],
    this.currentFilter,
    this.isSuccess = false,
    this.selectedCategoryId,
  });

  CategoriesState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<CategoryEntity>? categories,
    List<ProductEntity>? productsList,
    List<ProductEntity>? filteredProducts,
    FilterType? currentFilter,
    bool? isSuccess,
    String? selectedCategoryId,
  }) {
    return CategoriesState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      categories: categories ?? this.categories,
      productsList: productsList ?? this.productsList,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      currentFilter: currentFilter ?? this.currentFilter,
      isSuccess: isSuccess ?? this.isSuccess,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
    );
  }

  List<ProductEntity> get displayProducts {
    if (currentFilter != null && filteredProducts != null && filteredProducts!.isNotEmpty) {
      return filteredProducts!;
    }
    return productsList ?? [];
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        categories,
        productsList,
        filteredProducts,
        currentFilter,
        isSuccess,
        selectedCategoryId,
      ];
}
