import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_request_model.g.dart';

@JsonSerializable()
class EditProfileRequestModel {
  @JsonKey(name: 'firstName')
  final String firstName;

  @JsonKey(name: 'lastName')
  final String lastName;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'phone')
  final String phone;



  EditProfileRequestModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });

  factory EditProfileRequestModel.fromJson(Map<String, dynamic> json) =>
      _$EditProfileRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileRequestModelToJson(this);
}
