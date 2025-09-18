import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/address_entity.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/address_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/city_entity.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/governorate_entity.dart';

class AddressState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final List<GovernorateEntity> governorates;
  final List<CityEntity> cities;
  final int? selectedGovernorateId;
  final int? selectedCityId;
  final List<AddressResponseEntity> addresses;
  final List<AddressEntity> addressList;
  final String selectedLat;
  final String selectedLong;
  final bool isAddingAddress;
  final bool isUpdatingAddress;
  final bool isEditMode;
  final String? editingAddressId;
  final String selectedAddress;

  AddressState({
    this.isSuccess = false,
    this.isLoading = false,
    this.errorMessage,
    this.governorates = const [],
    this.cities = const [],
    this.selectedGovernorateId,
    this.selectedCityId,
    this.addresses = const [],
    this.addressList = const [],
    this.selectedLat = '',
    this.selectedLong = '',
    this.isAddingAddress = false,
    this.isUpdatingAddress = false,
    this.isEditMode = false,
    this.editingAddressId,
    this.selectedAddress = '',
  });

  AddressState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    List<GovernorateEntity>? governorates,
    List<CityEntity>? cities,
    int? selectedGovernorateId,
    int? selectedCityId,
    List<AddressResponseEntity>? addresses,
    List<AddressEntity>? addressList,
    String? selectedLat,
    String? selectedLong,
    bool? isAddingAddress,
    bool? isUpdatingAddress,
    bool? isEditMode,
    String? editingAddressId,
    String? selectedAddress,
  }) {
    return AddressState(
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      governorates: governorates ?? this.governorates,
      cities: cities ?? this.cities,
      selectedGovernorateId:
          selectedGovernorateId ?? this.selectedGovernorateId,
      selectedCityId: selectedCityId ?? this.selectedCityId,
      addresses: addresses ?? this.addresses,
      addressList: addressList ?? this.addressList,
      selectedLat: selectedLat ?? this.selectedLat,
      selectedLong: selectedLong ?? this.selectedLong,
      isAddingAddress: isAddingAddress ?? this.isAddingAddress,
      isUpdatingAddress: isUpdatingAddress ?? this.isUpdatingAddress,
      isEditMode: isEditMode ?? this.isEditMode,
      editingAddressId: editingAddressId ?? this.editingAddressId,
      
    );
  }
}
