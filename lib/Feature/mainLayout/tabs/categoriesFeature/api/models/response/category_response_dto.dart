import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/category_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/metadata_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'category_response_dto.g.dart';

@JsonSerializable()
class CategoryResponseDto {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'metadata')
  final MetadataDto? metadata;

  @JsonKey(name: 'categories')
  final List<CategoryDto>? categories;

  CategoryResponseDto({
    required this.message,
    required this.metadata,
    required this.categories,
  });

  factory CategoryResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseDtoToJson(this);
}
