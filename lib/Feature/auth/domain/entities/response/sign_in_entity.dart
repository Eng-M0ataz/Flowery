class SigninResponseEntity {
  final String? message;
  final UserEntity? user;
  final String? token;

  SigninResponseEntity ({
    this.message,
    this.user,
    this.token,
  });
}

class UserEntity {
  final String? Id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? gender;
  final String? phone;
  final String? photo;
  final String? role;
  final List<dynamic>? wishlist;
  final List<dynamic>? addresses;
  final String? createdAt;

  UserEntity ({
    this.Id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.wishlist,
    this.addresses,
    this.createdAt,
  });
}