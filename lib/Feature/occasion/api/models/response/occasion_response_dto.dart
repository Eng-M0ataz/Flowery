import 'package:json_annotation/json_annotation.dart';
import '../meta_data_dto.dart';
import '../occasion_dto.dart';

part 'occasion_response_dto.g.dart';

@JsonSerializable()
class OccasionResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final MetadataDto? metadata;
  @JsonKey(name: "occasions")
  final List<OccasionDto>? occasions;

  OccasionResponseDto ({
    this.message,
    this.metadata,
    this.occasions,
  });

  factory OccasionResponseDto.fromJson(Map<String, dynamic> json) {
    return _$OccasionResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OccasionResponseDtoToJson(this);
  }
}






