import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/resposneEntities/categories_response_entity.dart';

class CategoriesState {
  final bool isLoading;
  final String? errorMessage;
  final CategoryResponseEntity? response;
  final bool isSuccess;

  CategoriesState({
    this.isLoading = false,
    this.errorMessage,
    this.response,
    this.isSuccess = false,
  });

  CategoriesState copyWith({
    bool? isLoading,
    String? errorMessage,
    final CategoryResponseEntity? response,
    bool? isSuccess,
  }) {
    return CategoriesState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      response: response ?? this.response,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
