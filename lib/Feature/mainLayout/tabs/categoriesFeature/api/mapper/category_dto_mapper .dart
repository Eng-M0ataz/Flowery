import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/category_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/category_entity.dart';

extension CategoryDtoMapper on CategoryDto {
  CategoryEntity toEntity() => CategoryEntity(
        id: id ?? "",
        name: name ?? "",
        slug: slug ?? "",
        image: image ?? "",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isSuperAdmin: isSuperAdmin ?? false,
        productsCount: productsCount ?? 0,
      );
}
