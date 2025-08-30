import 'package:flower_e_commerce_app/Feature/mainLayout/api/models/meta_data_dto.dart';
import 'package:flower_e_commerce_app/Feature/occasion/api/models/product_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_by_occasion_response_dto.g.dart';

@JsonSerializable()
class ProductByOccasionResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final MetadataDto? metadata;
  @JsonKey(name: "products")
  final List<ProductDto>? products;

  ProductByOccasionResponseDto ({
    this.message,
    this.metadata,
    this.products,
  });

  factory ProductByOccasionResponseDto.fromJson(Map<String, dynamic> json) {
    return _$ProductByOccasionResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductByOccasionResponseDtoToJson(this);
  }
}






