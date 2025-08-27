import 'package:flower_e_commerce_app/Feature/occasion/api/mapper/meta_data_mapper.dart';
import 'package:flower_e_commerce_app/Feature/occasion/api/mapper/product_mapper.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/response/product_by_occasion_response_entity.dart';
import '../../domain/entities/meta_data_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../models/response/product_by_occasion_response_dto.dart';

extension ProductByOccasionResponseDtoMapper on ProductByOccasionResponseDto {
  ProductByOccasionResponseEntity toEntity() {
    return ProductByOccasionResponseEntity(
      message: message ?? '',
      metadata: metadata?.toEntity() ??
          MetadataEntity(
            currentPage: 1,
            totalPages: 1,
            limit: 0,
            totalItems: 0,
          ),
      products:
          products?.map((p) => p.toEntity()).toList() ?? <ProductEntity>[],
    );
  }
}
