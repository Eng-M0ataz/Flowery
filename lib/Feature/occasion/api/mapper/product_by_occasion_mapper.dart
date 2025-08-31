import 'package:flower_e_commerce_app/Feature/occasion/api/mapper/product_mapper.dart';
import 'package:flower_e_commerce_app/Feature/occasion/api/models/response/product_by_occasion_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/response/product_by_occasion_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/product_entity.dart';
import 'package:flower_e_commerce_app/Feature/occasion/api/mapper/meta_data_mapper.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/meta_data_entity.dart';

extension ProductByOccasionResponseDtoMapper on ProductByOccasionResponseDto {
  ProductByOccasionResponseEntity toEntity() {
    return ProductByOccasionResponseEntity(
      message: message ?? '',
      products: products?.map<ProductEntity>((p) => p.toEntity()).toList() ?? <ProductEntity>[],
      metadata: metadata?.toEntity() ?? MetadataEntity(
          currentPage: 0,
          limit: 0,
          totalPages: 0,
          totalItems: 0
      ),
    );
  }
}