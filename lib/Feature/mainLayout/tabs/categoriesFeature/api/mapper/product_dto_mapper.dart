import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/product_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/product_entity.dart';

extension ProductDtoMapper on ProductDto {
  ProductEntity toEntity() => ProductEntity(
        rateAvg: rateAvg ?? 0,
        rateCount: rateCount ?? 0,
        id: id ?? "",
        title: title ?? "",
        slug: slug ?? "",
        description: description ?? "",
        imgCover: imgCover ?? "",
        images: images ?? [],
        price: price ?? 0,
        priceAfterDiscount: priceAfterDiscount ?? 0,
        quantity: quantity ?? 0,
        category: category ?? "",
        occasion: occasion ?? "",
        createdAt: createdAt ?? "",
        updatedAt: updatedAt ?? "",
        isSuperAdmin: isSuperAdmin ?? false,
        sold: sold ?? 0,
      );
}
