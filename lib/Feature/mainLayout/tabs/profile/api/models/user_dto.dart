import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'firstName')
  final String? firstName;

  @JsonKey(name: 'lastName')
  final String? lastName;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'password')
  final String? password;

  @JsonKey(name: 'gender')
  final String? gender;

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'photo')
  final String? photo;

  @JsonKey(name: 'role')
  final String? role;

  @JsonKey(name: 'wishlist')
  final List<dynamic>? wishlist;

  @JsonKey(name: 'addresses')
  final List<dynamic>? addresses;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  UserDto({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.gender,
    required this.phone,
    required this.photo,
    required this.role,
    required this.wishlist,
    required this.addresses,
    required this.createdAt,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
