import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/response/add_product_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/response/occasion_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/response/product_by_occasion_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:equatable/equatable.dart';

class OccasionState extends Equatable {
  final bool isOccasionLoading;
  final bool isProductLoading;
  final String? productId;

  final Failure? occasionFailure;
  final Failure? productFailure;
  final Failure? addToCartFailure;

  final OccasionResponseEntity? occasionResponse;
  final ProductByOccasionResponseEntity? productResponse;
  final AddProductResponseEntity? addToCartResponse;

  const OccasionState(
      {this.isOccasionLoading = true,
      this.isProductLoading = true,
      this.occasionFailure,
      this.productFailure,
      this.occasionResponse,
      this.productResponse,
      this.addToCartResponse,
      this.addToCartFailure,
      this.productId});

  OccasionState copyWith({
    bool? isOccasionLoading,
    bool? isProductLoading,
    Failure? occasionFailure,
    Failure? productFailure,
    OccasionResponseEntity? occasionResponse,
    ProductByOccasionResponseEntity? productResponse,
    AddProductResponseEntity? addToCartResponse,
    Failure? addToCartFailure,
    String? productId,
  }) {
    return OccasionState(
      isOccasionLoading: isOccasionLoading ?? this.isOccasionLoading,
      isProductLoading: isProductLoading ?? this.isProductLoading,
      occasionFailure: occasionFailure ?? this.occasionFailure,
      productFailure: productFailure ?? this.productFailure,
      occasionResponse: occasionResponse ?? this.occasionResponse,
      productResponse: productResponse ?? this.productResponse,
      addToCartResponse: addToCartResponse ?? this.addToCartResponse,
      addToCartFailure: addToCartFailure ?? this.addToCartFailure,
      productId: productId ,
    );
  }

  @override
  List<Object?> get props => [
        isOccasionLoading,
        isProductLoading,
        occasionFailure,
        productFailure,
        occasionResponse,
        productResponse,
        addToCartResponse,
        addToCartFailure,
        productId,
      ];
}
