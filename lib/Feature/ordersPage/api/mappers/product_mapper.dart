import 'package:flower_e_commerce_app/Feature/ordersPage/api/models/product_dto.dart';
import 'package:flower_e_commerce_app/core/models/product_details_model.dart';

extension ProductMapper on ProductDto {
  ProductDetailsModel toEntity() {
    return ProductDetailsModel(
      id: Id??'',
      title: title??'',
      images: images??[],
      price: price??0,
      description: description ??'',
      quantity: quantity ??0,
      priceAfterDiscount: priceAfterDiscount?.toDouble()??0.0,
      imageCover: imgCover ??'',
    );
  }
}