import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/address_entity.dart';

abstract class AddressEvent {
  const AddressEvent();
}

class GetGovernoratesEvent extends AddressEvent {
  const GetGovernoratesEvent();
}

class GetCitiesEvent extends AddressEvent {
  const GetCitiesEvent();
}

class GetCitiesByGovernorateEvent extends AddressEvent {
  final int governorateId;

  const GetCitiesByGovernorateEvent({required this.governorateId});
}

class SelectGovernorateEvent extends AddressEvent {
  final int governorateId;

  const SelectGovernorateEvent({required this.governorateId});
}

class SelectCityEvent extends AddressEvent {
  final int cityId;

  const SelectCityEvent({required this.cityId});
}

class GetAddressesEvent extends AddressEvent {
  const GetAddressesEvent();
}

class DeleteAddressEvent extends AddressEvent {
  final String addressId;

  const DeleteAddressEvent({required this.addressId});
}

class AddAddressEvent extends AddressEvent {
  AddAddressEvent();
}

class UpdateAddressEvent extends AddressEvent {
  final String addressId;

  UpdateAddressEvent({required this.addressId});
}

class DisposeEvent extends AddressEvent {
  DisposeEvent();
}

class InitializeEditAddressEvent extends AddressEvent {
  final AddressEntity address;
  const InitializeEditAddressEvent({required this.address});
}

class NavigateToAddAddressEvent extends AddressEvent {}

class RefreshAddressesEvent extends AddressEvent {}
