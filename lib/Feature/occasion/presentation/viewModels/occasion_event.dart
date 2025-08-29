sealed class OccasionEvent {}

class LoadProductsByOccasionEvent extends OccasionEvent {
  final String occasionId;

  LoadProductsByOccasionEvent({required this.occasionId});
}

class GetAllOccasionsEvent extends OccasionEvent {
  final String occasionId;

  GetAllOccasionsEvent({required this.occasionId});
}
