import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/response/product_by_occasion_response_entity.dart';
import '../../../../core/Errors/failure.dart';
import '../../domain/entities/response/occasion_response_entity.dart';
import 'package:equatable/equatable.dart';

class OccasionState extends Equatable {
  final bool isOccasionLoading;
  final bool isProductLoading;

  final Failure? occasionFailure;
  final Failure? productFailure;

  final OccasionResponseEntity? occasionResponse;
  final ProductByOccasionResponseEntity? productResponse;

  const OccasionState({
    this.isOccasionLoading = true,
    this.isProductLoading = true,
    this.occasionFailure,
    this.productFailure,
    this.occasionResponse,
    this.productResponse,
  });

  OccasionState copyWith({
    bool? isOccasionLoading,
    bool? isProductLoading,
    Failure? occasionFailure,
    Failure? productFailure,
    OccasionResponseEntity? occasionResponse,
    ProductByOccasionResponseEntity? productResponse,
  }) {
    return OccasionState(
      isOccasionLoading: isOccasionLoading ?? this.isOccasionLoading,
      isProductLoading: isProductLoading ?? this.isProductLoading,
      occasionFailure: occasionFailure ?? this.occasionFailure,
      productFailure: productFailure ?? this.productFailure,
      occasionResponse: occasionResponse ?? this.occasionResponse,
      productResponse: productResponse ?? this.productResponse,
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
      ];
}
