import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/requestEntities/get_category_products_request_entity.dart';

class GetCategoryProductsRequestModel {
  final String categoryId;
  final int? page;
  final int? limit;

  GetCategoryProductsRequestModel({
    required this.categoryId,
    this.page,
    this.limit,
  });

  factory GetCategoryProductsRequestModel.fromEntity(
      GetCategoryProductsRequestEntity entity) {
    return GetCategoryProductsRequestModel(
      categoryId: entity.categoryId,
      page: entity.page,
      limit: entity.limit,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "category": categoryId,
      if (page != null) "page": page,
      if (limit != null) "limit": limit,
    };
  }
}
