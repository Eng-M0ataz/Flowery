import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/mapper/category_dto_mapper%20.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/mapper/metadata_dto_mapper.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/response/category_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/metadata_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/resposneEntities/categories_response_entity.dart';

extension CategoryResponseDtoMapper on CategoryResponseDto {
  CategoryResponseEntity toEntity() => CategoryResponseEntity(
        message: message ?? "",
        metadata: metadata?.toEntity() ??
            MetadataEntity(currentPage: 0, limit: 0, totalPages: 0, totalItems: 0),
        categories: categories?.map((e) => e.toEntity()).toList() ?? [],
      );
}