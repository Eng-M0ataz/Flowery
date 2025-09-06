import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/mapper/metadata_dto_mapper.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/mapper/product_dto_mapper.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/response/product_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/product_response_entity.dart';

extension ProductResponseDtoMapper on ProductResponseDto {
  ProductResponseEntity toEntity() => ProductResponseEntity(
        message: message ?? "message is null",
        metadata: metadata?.toEntity(),
        products: products?.map((e) => e.toEntity()).toList() ?? [],
      );
}
