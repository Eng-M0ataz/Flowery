import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/bestSellerFeature/api/models/best_seller_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'best_seller_response_dto.g.dart';

@JsonSerializable()
class BestSellerResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "bestSeller")
  final List<BestSellerDto>? bestSeller;

  BestSellerResponseDto ({
    this.message,
    this.bestSeller,
  });

  factory BestSellerResponseDto.fromJson(Map<String, dynamic> json) {
    return _$BestSellerResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BestSellerResponseDtoToJson(this);
  }
}