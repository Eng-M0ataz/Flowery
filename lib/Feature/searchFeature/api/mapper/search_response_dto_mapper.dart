import 'package:flower_e_commerce_app/Feature/searchFeature/api/models/search_dto.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/api/models/search_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/domain/entities/search_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/domain/entities/search_peoduct_entity.dart';

extension SearchResponseDtoMapper on SearchResponseDto {
  SearchResponseEntity toEntity() {
    return SearchResponseEntity(
      products: products?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

extension SearchDtoMapper on SearchDto {
  SearchProductEntity toEntity() {
    return SearchProductEntity(
      id: id ?? "",
      title: title ?? "",
      description: description,
      imgCover: imgCover,
      price: price ?? 0,
      priceAfterDiscount: priceAfterDiscount ?? 0,
      images: images ?? [],
      quantity: quantity ?? 0,
      sold: sold ?? 0,
      category: category ?? "",
      occasion: occasion ?? "",
    );
  }
}
