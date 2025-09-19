import 'package:json_annotation/json_annotation.dart';
part 'search_metadata_dto.g.dart';

@JsonSerializable()
class SearchMetadataDto {
  @JsonKey(name: "currentPage")
  final int? currentPage;
  @JsonKey(name: "totalPages")
  final int? totalPages;
  @JsonKey(name: "limit")
  final int? limit;
  @JsonKey(name: "totalItems")
  final int? totalItems;

  SearchMetadataDto({
    this.currentPage,
    this.totalPages,
    this.limit,
    this.totalItems,
  });

  factory SearchMetadataDto.fromJson(Map<String, dynamic> json) =>
      _$SearchMetadataDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SearchMetadataDtoToJson(this);
}
