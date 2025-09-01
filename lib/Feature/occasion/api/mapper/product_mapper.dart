import '../../domain/entities/product_entity.dart';
import '../models/product_dto.dart';

extension ProductDtoMapper on ProductDto {
  ProductEntity toEntity() {
    return ProductEntity(
      id: id ?? Id ?? '',
      title: title ?? '',
      slug: slug ?? '',
      description: description ?? '',
      imgCover: imgCover ?? '',
      images: images ?? [],
      price: price ?? 0,
      priceAfterDiscount: priceAfterDiscount ?? 0,
      quantity: quantity ?? 0,
      category: category ?? '',
      occasion: occasion ?? '',
      rateAvg: rateAvg ?? 0,
      rateCount: rateCount ?? 0,
      sold: sold ?? 0,
    );
  }
}
