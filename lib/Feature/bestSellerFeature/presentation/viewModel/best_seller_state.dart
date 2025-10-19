import 'package:flower_e_commerce_app/Feature/bestSellerFeature/domain/entities/responseEntities/best_seller_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/response/add_product_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:equatable/equatable.dart';

class BestSellerState extends Equatable {
  final bool isLoading;
  final BestSellerResponseEntity? bestSellers;

  final String? selectedBestSellerId;
  final AddProductResponseEntity? addToCartResponse;
  final Failure? addToCartFailure;
  final Failure? bestSellerFailure;

  const BestSellerState({
    this.isLoading = true,
    this.bestSellers,
    this.selectedBestSellerId,
    this.addToCartResponse,
    this.addToCartFailure,
    this.bestSellerFailure,
  });

  BestSellerState copyWith({
    bool? isLoading,
    Failure? failure,
    BestSellerResponseEntity? bestSellers,
    String? selectedBestSellerId,
    AddProductResponseEntity? addToCartResponse,
    Failure? addToCartFailure,
    Failure? bestSellerFailure,
  }) {
    return BestSellerState(
      isLoading: isLoading ?? this.isLoading,
      bestSellers: bestSellers ?? this.bestSellers,
      selectedBestSellerId: selectedBestSellerId,
      addToCartResponse: addToCartResponse ?? this.addToCartResponse,
      addToCartFailure: addToCartFailure ?? this.addToCartFailure,
      bestSellerFailure: bestSellerFailure ?? this.bestSellerFailure,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        bestSellers,
        selectedBestSellerId,
        addToCartResponse,
        addToCartFailure,
        bestSellerFailure,
      ];
}
