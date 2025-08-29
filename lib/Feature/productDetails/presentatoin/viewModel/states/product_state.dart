import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/product_entity.dart';

enum ProductImagesStatus { initial, loading, success, error }
enum ProductDetailsStatus { initial, loading, success, error }


class ProductDetailsState {
  final ProductDetailsStatus status;
  final ProductEntity? product;
  final String? errorMessage;
  final int currentIndex;

  ProductDetailsState({
    this.status = ProductDetailsStatus.initial,
    this.product,
    this.errorMessage,
    this.currentIndex = 0, // default 0
  });

  ProductDetailsState copyWith({
    ProductDetailsStatus? status,
    ProductEntity? product,
    String? errorMessage,
    int? currentIndex,
  }) {
    return ProductDetailsState(
      status: status ?? this.status,
      product: product ?? this.product,
      errorMessage: errorMessage ?? this.errorMessage,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}


