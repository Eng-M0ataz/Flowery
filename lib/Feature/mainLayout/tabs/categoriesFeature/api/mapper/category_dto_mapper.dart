import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/category_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/category_entity.dart';

extension CategoryDtoMapper on CategoryDto {
  CategoryEntity toEntity() => CategoryEntity(
        id: id ?? "",
        name: name ?? "",
        image: image ?? "",
        productsCount: productsCount ?? 0,
      );
}
