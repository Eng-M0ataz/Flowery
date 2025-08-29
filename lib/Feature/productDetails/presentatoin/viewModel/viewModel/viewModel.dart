import 'package:flower_e_commerce_app/Feature/productDetails/presentatoin/viewModel/events/products_event.dart';
import 'package:flower_e_commerce_app/Feature/productDetails/presentatoin/viewModel/states/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductDetailsViewModel extends Cubit<ProductDetailsState> {
  ProductDetailsViewModel() : super(ProductDetailsState());

  Future<void> doIntent(ProductDetailsEvent event, BuildContext context) async {
    switch (event) {
      case LoadImagesEvent():
        await _loadImages(event.images, context);
      case ChangeImageEvent():
        emit(state.copyWith(currentIndex: event.index));
    }
  }

  Future<void> _loadImages(List<String>? images, BuildContext context) async {
    if (images == null || images.isEmpty) {
      emit(state.copyWith(
        status: ProductDetailsStatus.error,
        errorMessage: "No images available",
      ));
      return;
    }

    emit(state.copyWith(status: ProductDetailsStatus.loading));

    try {
      for (final url in images) {
        final image = Image.network(url).image;
        await precacheImage(image, context);
      }

      emit(state.copyWith(status: ProductDetailsStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: ProductDetailsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
