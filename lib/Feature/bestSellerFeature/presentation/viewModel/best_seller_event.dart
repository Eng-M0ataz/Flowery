sealed class BestSellerEvent {}

class GetAllBestSellersEvent extends BestSellerEvent {}

class AddProductToCartEvent extends BestSellerEvent {
  final String productId;

  AddProductToCartEvent({required this.productId});
}
