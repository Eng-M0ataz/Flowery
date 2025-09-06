import 'package:json_annotation/json_annotation.dart';
part 'get_category_products_request_model.g.dart';

@JsonSerializable()
class GetProductsByCategoryRequestModel {
  @JsonKey(name: 'category')
  final String categoryId;

  @JsonKey(name: 'page')
  final int? page;

  @JsonKey(name: 'limit')
  final int? limit;

  GetProductsByCategoryRequestModel({
    required this.categoryId,
    this.page,
    this.limit,
  });

  factory GetProductsByCategoryRequestModel.fromJson(
          Map<String, dynamic> json) =>
      _$GetProductsByCategoryRequestModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetProductsByCategoryRequestModelToJson(this);
}
