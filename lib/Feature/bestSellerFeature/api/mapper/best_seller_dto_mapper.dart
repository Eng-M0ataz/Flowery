import 'package:flower_e_commerce_app/Feature/bestSellerFeature/api/models/best_seller_dto.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/domain/entities/best_seller_entity.dart';

extension BestSellerDtoMapper on BestSellerDto {
  BestSellerEntity toEntity() => BestSellerEntity(
    Id: id ?? "",
    title: title ?? "",
    description: description ?? "",
    imgCover: imgCover ?? "",
    price: price ?? 0,
    priceAfterDiscount: priceAfterDiscount ?? 0,
  );
}