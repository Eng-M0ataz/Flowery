import 'package:json_annotation/json_annotation.dart';

part 'category_dto.g.dart';

@JsonSerializable()
class CategoryDto {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'slug')
  final String? slug;

  @JsonKey(name: 'image')
  final String? image;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  @JsonKey(name: 'isSuperAdmin')
  final bool? isSuperAdmin;

  @JsonKey(name: 'productsCount')
  final int? productsCount;

  CategoryDto({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.isSuperAdmin,
    required this.productsCount,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDtoToJson(this);
}
