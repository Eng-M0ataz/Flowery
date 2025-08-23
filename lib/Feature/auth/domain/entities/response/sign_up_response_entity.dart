class SignUpResponseEntity {
  final String message;
  final UserEntity user;
  final String token;

  const SignUpResponseEntity({
    required this.message,
    required this.user,
    required this.token,
  });
}

class UserEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String phone;
  final String photo;
  final String role;
  final List<dynamic> wishlist;
  final List<dynamic> addresses;
  final DateTime createdAt;

  const UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.phone,
    required this.photo,
    required this.role,
    required this.wishlist,
    required this.addresses,
    required this.createdAt,
  });
}
