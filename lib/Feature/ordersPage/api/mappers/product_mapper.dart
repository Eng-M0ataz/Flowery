import 'package:flower_e_commerce_app/Feature/ordersPage/api/models/product_dto.dart';
import 'package:flower_e_commerce_app/core/models/product_details_model.dart';

extension ProductMapper on ProductDto {
  ProductDetailsModel toEntity() {
    return ProductDetailsModel(
      id: id,
      title: title,
      images: images,
      price: price,
      description: description,
      quantity: quantity,
      priceAfterDiscount: priceAfterDiscount!.toDouble(),
      imageCover: imgCover,
      discount: discount!.toDouble(),
    );
  }
}