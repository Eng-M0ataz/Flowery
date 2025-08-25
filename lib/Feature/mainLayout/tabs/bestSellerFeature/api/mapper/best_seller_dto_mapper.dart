import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/bestSellerFeature/api/models/best_seller_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/bestSellerFeature/domain/entities/best_seller_entity.dart';

extension BestSellerDtoMapper on BestSellerDto {
  BestSellerEntity toEntity() => BestSellerEntity(
    rateAvg: rateAvg ?? 0,
    rateCount: rateCount ?? 0,
    Id: id ?? "",
    title: title ?? "",
    slug: slug ?? "",
    description: description ?? "",
    imgCover: imgCover ?? "",
    images: images ?? [],
    price: price ?? 0,
    priceAfterDiscount: priceAfterDiscount ?? 0,
    quantity: quantity ?? 0,
    category: category ?? '',
    occasion: occasion ?? '',
    createdAt: DateTime.now().toString(),
    updatedAt: DateTime.now().toString(),
    V: V ?? 0,
    isSuperAdmin: isSuperAdmin ?? false,
    sold: sold ?? 0,
    id: id ?? "",
  );
}