import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/metadata_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/product_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_response_dto.g.dart';

@JsonSerializable()
class ProductResponseDto {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'metadata')
  final MetadataDto? metadata;

  @JsonKey(name: 'products')
  final List<ProductDto>? products;

  ProductResponseDto({
    required this.message,
    required this.metadata,
    required this.products,
  });

  factory ProductResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseDtoToJson(this);
}
