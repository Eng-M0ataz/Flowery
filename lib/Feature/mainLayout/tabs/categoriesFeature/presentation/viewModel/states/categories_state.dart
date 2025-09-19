import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/category_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/product_entity.dart';

class CategoriesState extends Equatable {
  final bool isCategoriesLoading;
  final bool isProductsLoading;
  final String? errorMessage;
  final List<CategoryEntity>? categories;
  final List<ProductEntity>? productsList;
  final bool isSuccess;
  final String? selectedCategoryId;

  const CategoriesState({
    this.isCategoriesLoading = false,
    this.isProductsLoading = false,
    this.errorMessage,
    this.categories = const [],
    this.productsList = const [],
    this.isSuccess = false,
    this.selectedCategoryId,
  });

  CategoriesState copyWith({
    bool? isCategoriesLoading,
    bool? isProductsLoading,
    String? errorMessage,
    List<CategoryEntity>? categories,
    List<ProductEntity>? productsList,
    bool? isSuccess,
    String? selectedCategoryId,
  }) {
    return CategoriesState(
      isCategoriesLoading: isCategoriesLoading ?? this.isCategoriesLoading,
      isProductsLoading: isProductsLoading ?? this.isProductsLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      categories: categories ?? this.categories,
      productsList: productsList ?? this.productsList,
      isSuccess: isSuccess ?? this.isSuccess,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
    );
  }

  @override
  List<Object?> get props => [
        isCategoriesLoading,
        isProductsLoading,
        errorMessage,
        categories,
        productsList,
        isSuccess,
        selectedCategoryId,
      ];
}
