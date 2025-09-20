import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/address_entity.dart';
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
  final List<AddressEntity> addressList;
  final String selectedLat;
  final String selectedLong;
  final bool isAddingAddress;
  final bool isUpdatingAddress;
  final bool isEditMode;
  final String? editingAddressId;
  final String selectedAddress;
  final bool navigateToAddAddress;
  final bool refreshAddresses;
  AddressState({
    this.isSuccess = false,
    this.isLoading = false,
    this.errorMessage,
    this.governorates = const [],
    this.cities = const [],
    this.selectedGovernorateId,
    this.selectedCityId,
    this.addressList = const [],
    this.selectedLat = '',
    this.selectedLong = '',
    this.isAddingAddress = false,
    this.isUpdatingAddress = false,
    this.isEditMode = false,
    this.editingAddressId,
    this.selectedAddress = '',
    this.navigateToAddAddress = false,
    this.refreshAddresses = false,
  });

  AddressState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    List<GovernorateEntity>? governorates,
    List<CityEntity>? cities,
    int? selectedGovernorateId,
    int? selectedCityId,
    List<AddressEntity>? addressList,
    String? selectedLat,
    String? selectedLong,
    bool? isAddingAddress,
    bool? isUpdatingAddress,
    bool? isEditMode,
    String? editingAddressId,
    String? selectedAddress,
    bool? navigateToAddAddress,
    bool? refreshAddresses,
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
      addressList: addressList ?? this.addressList,
      selectedLat: selectedLat ?? this.selectedLat,
      selectedLong: selectedLong ?? this.selectedLong,
      isAddingAddress: isAddingAddress ?? this.isAddingAddress,
      isUpdatingAddress: isUpdatingAddress ?? this.isUpdatingAddress,
      isEditMode: isEditMode ?? this.isEditMode,
      editingAddressId: editingAddressId ?? this.editingAddressId,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      navigateToAddAddress: navigateToAddAddress ?? this.navigateToAddAddress,
      refreshAddresses: refreshAddresses ?? this.refreshAddresses,
    );
  }
}
