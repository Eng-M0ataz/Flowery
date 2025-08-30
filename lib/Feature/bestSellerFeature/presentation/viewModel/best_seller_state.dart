import 'package:flower_e_commerce_app/Feature/bestSellerFeature/domain/entities/responseEntities/best_seller_response_entity.dart';

class BestSellerState{
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;
  final BestSellerResponseEntity? bestSellers;
  final String? selectedBestSellerId;

  BestSellerState({
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
    this.bestSellers,
    this.selectedBestSellerId,
  });

  BestSellerState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
    BestSellerResponseEntity? bestSellers,
    String? selectedBestSellerId,
  }) {
    return BestSellerState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      bestSellers: bestSellers ?? this.bestSellers,
      selectedBestSellerId: selectedBestSellerId ?? this.selectedBestSellerId,
    );
  }
}