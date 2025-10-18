import 'location_entity.dart';

class DriverEntity {
  final LocationEntity? driverLocation;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? driverPhotoUrl;

  const DriverEntity({
    this.driverLocation,
    this.firstName,
    this.lastName,
    this.phone,
    this.driverPhotoUrl,
  });
}

