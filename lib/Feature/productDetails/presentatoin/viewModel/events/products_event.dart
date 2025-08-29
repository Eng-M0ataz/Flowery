sealed class ProductDetailsEvent {}

class LoadImagesEvent extends ProductDetailsEvent {
  final List<String>? images;
  LoadImagesEvent(this.images);
}

class ChangeImageEvent extends ProductDetailsEvent {
  final int index;
  ChangeImageEvent(this.index);
}