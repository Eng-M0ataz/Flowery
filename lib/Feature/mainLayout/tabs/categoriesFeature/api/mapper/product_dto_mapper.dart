import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/product_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/product_entity.dart';

extension ProductDtoMapper on ProductDto {
  ProductEntity toEntity() => ProductEntity(
        id: id ?? "",
        title: title ?? "",
        description: description ?? "",
        imgCover: imgCover ?? "",
        price: price ?? 0,
        priceAfterDiscount: priceAfterDiscount ?? 0,
        createdAt: DateTime.parse(createdAt!).toLocal(),
        quantity: quantity ?? 0,
        category: category ?? "",
        sold: sold ?? 0,
        images: images ?? [],
      );
}
