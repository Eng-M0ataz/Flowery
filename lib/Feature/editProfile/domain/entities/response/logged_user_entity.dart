class LoggedUserEntity {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? gender;
  final String? phone;
  final String? photo;
  final List<dynamic>? wishlist;
  final List<dynamic>? addresses;

  const LoggedUserEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.wishlist,
    this.addresses,
  });
}
