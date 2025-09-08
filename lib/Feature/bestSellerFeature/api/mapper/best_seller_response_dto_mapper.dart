import 'package:flower_e_commerce_app/Feature/bestSellerFeature/api/mapper/best_seller_dto_mapper.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/api/models/response/best_seller_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/domain/entities/responseEntities/best_seller_response_entity.dart';

extension BestSellerResponseDtoMapper on BestSellerResponseDto {
  BestSellerResponseEntity toEntity() => BestSellerResponseEntity(
    message: message ?? "",
    bestSeller: bestSeller?.map((e) => e.toEntity()).toList() ?? [],
  );
}