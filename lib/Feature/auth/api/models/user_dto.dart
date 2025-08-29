import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  @JsonKey(name: "firstName")
  final String? firstName;

  @JsonKey(name: "lastName")
  final String? lastName;

  @JsonKey(name: "email")
  final String email; 

  @JsonKey(name: "gender")
  final String? gender;

  @JsonKey(name: "phone")
  final String? phone;

  @JsonKey(name: "photo")
  final String? photo;

  @JsonKey(name: "role")
  final String role; 

  @JsonKey(name: "wishlist")
  final List<dynamic>? wishlist;

  @JsonKey(name: "_id")
  final String id; 

  @JsonKey(name: "addresses")
  final List<dynamic>? addresses;

  @JsonKey(name: "createdAt")
  final DateTime createdAt; 

  UserDto({
    this.firstName,
    this.lastName,
    required this.email,
    this.gender,
    this.phone,
    this.photo,
    required this.role,
    this.wishlist,
    required this.id,
    this.addresses,
    required this.createdAt,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
