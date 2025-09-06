import 'package:json_annotation/json_annotation.dart';
part 'get_category_products_request_model.g.dart';

@JsonSerializable()
class GetCategoryProductsRequestModel {
  @JsonKey(name: 'category')
  final String categoryId;

  @JsonKey(name: 'page')
  final int? page;

  @JsonKey(name: 'limit')
  final int? limit;

  GetCategoryProductsRequestModel({
    required this.categoryId,
    this.page,
    this.limit,
  });

  factory GetCategoryProductsRequestModel.fromJson(Map<String, dynamic> json) =>
      _$GetCategoryProductsRequestModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetCategoryProductsRequestModelToJson(this);
}
