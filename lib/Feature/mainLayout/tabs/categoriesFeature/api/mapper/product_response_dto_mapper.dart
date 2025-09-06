import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/mapper/metadata_dto_mapper.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/mapper/product_dto_mapper.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/response/product_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/metadata_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/product_response_entity.dart';

extension ProductResponseDtoMapper on ProductResponseDto {
  ProductResponseEntity toEntity() => ProductResponseEntity(
        message: message ?? "message is null",
        metadata: metadata?.toEntity() ??
            MetadataEntity(
                currentPage: 0, limit: 0, totalPages: 0, totalItems: 0),
        products: products?.map((e) => e.toEntity()).toList() ?? [],
      );
}
