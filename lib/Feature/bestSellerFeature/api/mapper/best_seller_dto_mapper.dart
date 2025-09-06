import 'package:flower_e_commerce_app/Feature/bestSellerFeature/api/models/best_seller_dto.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/domain/entities/best_seller_entity.dart';

extension BestSellerDtoMapper on BestSellerDto {
  BestSellerEntity toEntity() => BestSellerEntity(
    id: Id ?? id ?? "",
    title: title ?? "",
    description: description ?? "",
    imgCover: imgCover ?? "",
    price: price ?? 0,
    priceAfterDiscount: priceAfterDiscount ?? 0,
    discount: discount ?? 0,
    slug: slug ?? "",
    rateCount: rateCount ?? 0,
    rateAvg: rateAvg ?? 0,
    quantity: quantity ?? 0,
    category: category ?? "general",
    images: images ?? [],
    isSuperAdmin: isSuperAdmin ?? false,
    occasion: occasion ?? "",
    V: V ?? 0,
    sold: sold ?? 0,
    createdAt: createdAt ?? "",
    updatedAt: updatedAt ?? "",
  );
}