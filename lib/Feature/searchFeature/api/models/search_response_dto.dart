import 'package:flower_e_commerce_app/Feature/searchFeature/api/models/search_dto.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/api/models/search_metadata_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'search_response_dto.g.dart';

@JsonSerializable()
class SearchResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final SearchMetadataDto? metadata;
  @JsonKey(name: "products")
  final List<SearchDto>? products;

  SearchResponseDto({
    this.message,
    this.metadata,
    this.products,
  });

  factory SearchResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResponseDtoToJson(this);
}
