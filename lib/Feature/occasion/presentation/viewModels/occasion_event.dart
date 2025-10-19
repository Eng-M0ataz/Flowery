sealed class OccasionEvent {}

class LoadProductsByOccasionEvent extends OccasionEvent {
  final String occasionId;

  LoadProductsByOccasionEvent({required this.occasionId});
}

class GetAllOccasionsEvent extends OccasionEvent {
  final String occasionId;

  GetAllOccasionsEvent({required this.occasionId});
}

class AddProductToCartEvent extends OccasionEvent {
  final String productId;

  AddProductToCartEvent({required this.productId});
}
