import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/api/mapper/add_address_request_mapper.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/address_entity.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/address_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/useCases/add_address_use_case.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/useCases/delete_address_use_case.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/useCases/get_addresses_use_case.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/useCases/get_cities_by_governorate_use_case.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/useCases/get_cities_use_case.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/useCases/get_governorates_use_case.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/useCases/update_address_use_case.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/viewModel/addressViewModel/address_event.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/viewModel/addressViewModel/address_state.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddressViewModel extends Cubit<AddressState> {
  final GetCitiesByGovernorateUseCase _getCitiesByGovernorateUseCase;
  final GetCitiesUseCase _getCitiesUseCase;
  final GetGovernoratesUseCase _getGovernoratesUseCase;
  final DeleteAddressUseCase _deleteAddressUseCase;
  final GetAddressesUseCase _getAddressesUseCase;
  final AddAddressUseCase _addAddressUseCase;
  final UpdateAddressUseCase _updateAddressUseCase;
  AddressViewModel(
    this._getCitiesByGovernorateUseCase,
    this._getCitiesUseCase,
    this._getGovernoratesUseCase,
    this._getAddressesUseCase,
    this._deleteAddressUseCase,
    this._addAddressUseCase,
    this._updateAddressUseCase,
  ) : super(AddressState());

  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController recipientNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> doIntent(AddressEvent event) async {
    switch (event) {
      case GetGovernoratesEvent():
        await _loadGovernorates();
        break;
      case GetCitiesEvent():
        await _loadCities();
        break;
      case GetCitiesByGovernorateEvent():
        await _loadCitiesByGovernorate(event.governorateId);
        break;
      case SelectGovernorateEvent():
        await _selectGovernorate(event.governorateId);
        break;
      case SelectCityEvent():
        _selectCity(event.cityId);
        break;
      case GetAddressesEvent():
        await _loadAddresses();
        break;
      case DeleteAddressEvent():
        await _deleteAddress(event.addressId);

      case AddAddressEvent():
        await _saveAddress();
        break;
      case UpdateAddressEvent():
        await _saveAddress(addressId: event.addressId);
        break;
      case InitializeEditAddressEvent():
        await _initializeEditAddress(event.address);
        break;
      case NavigateToAddAddressEvent():
        _navigateToAddAddress();
      case RefreshAddressesEvent():
        await _loadAddresses();
        break;

      case DisposeEvent():
        _dispose();
        break;
    }
  }

  Future<void> _loadGovernorates() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final governorates = await _getGovernoratesUseCase.call();
      emit(state.copyWith(isLoading: false, governorates: governorates));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: e.toString(), governorates: []));
    }
  }

  Future<void> _loadCities() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final cities = await _getCitiesUseCase.call();
      emit(state.copyWith(isLoading: false, cities: cities));
    } catch (e) {
      emit(state
          .copyWith(isLoading: false, errorMessage: e.toString(), cities: []));
    }
  }

  Future<void> _loadCitiesByGovernorate(int governorateId) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final cities = await _getCitiesByGovernorateUseCase.call(governorateId);
      emit(state.copyWith(
          isLoading: false, cities: cities, selectedCityId: null));
    } catch (e) {
      emit(state
          .copyWith(isLoading: false, errorMessage: e.toString(), cities: []));
    }
  }

  Future<void> _selectGovernorate(int governorateId) async {
    emit(state.copyWith(
      selectedGovernorateId: governorateId,
      selectedCityId: null,
      cities: [],
    ));

    await _loadCitiesByGovernorate(governorateId);
  }

  void _selectCity(int cityId) {
    final selectedCity = state.cities.firstWhere(
      (city) => city.id == cityId,
      orElse: () => throw Exception(LocaleKeys.city_not_found.tr()),
    );

    if (state.selectedGovernorateId != null &&
        selectedCity.governorateId == state.selectedGovernorateId) {
      emit(state.copyWith(selectedCityId: cityId));
    } else {
      emit(state.copyWith(
        errorMessage: LocaleKeys.city_not_found_in_governorate.tr(),
        selectedCityId: null,
      ));
    }
  }

  Future<void> _loadAddresses() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getAddressesUseCase.invoke();
    switch (result) {
      case ApiSuccessResult<AddressResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          addressList: result.data.addresses,
          errorMessage: null,
        ));
      case ApiErrorResult<AddressResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          errorMessage: result.failure.errorMessage,
        ));
    }
  }

  Future<void> _deleteAddress(String addressId) async {
    final updatedList =
        state.addressList.where((addr) => addr.id != addressId).toList();
    emit(state.copyWith(addressList: updatedList));

    final result = await _deleteAddressUseCase.invoke(addressId);
    switch (result) {
      case ApiSuccessResult<void>():
        break;
      case ApiErrorResult<void>():
        emit(state.copyWith(
          addressList: state.addressList,
          errorMessage: result.failure.errorMessage,
        ));
        break;
    }
  }

  bool _validateForm() {
    if (!(formKey.currentState?.validate() ?? false)) {
      return false;
    }

    return true;
  }

  void _fillFormForEdit(AddressEntity address) {
    final fullAddress = address.street ?? '';

    addressController.text = fullAddress;
    phoneController.text = address.phone ?? '';
    recipientNameController.text = address.username ?? '';

    emit(state.copyWith(
      selectedLat: address.lat ?? '',
      selectedLong: address.long ?? '',
      selectedAddress: fullAddress,
    ));
  }

  void updateSelectedAddress(String address) {
    emit(state.copyWith(selectedAddress: address));
    addressController.text = address;
  }

  Future<void> _saveAddress({String? addressId}) async {
    if (!_validateForm()) return;
    final request = state.toRequestModel(
      phoneController: phoneController,
      recipientNameController: recipientNameController,
    );
    if (addressId == null) {
      emit(state.copyWith(isAddingAddress: true, errorMessage: null));
      final result = await _addAddressUseCase.call(requestModel: request);
      switch (result) {
        case ApiSuccessResult<void>():
          emit(state.copyWith(isAddingAddress: false, isSuccess: true));
        case ApiErrorResult<void>():
          emit(state.copyWith(
              isAddingAddress: false,
              errorMessage: result.failure.errorMessage));
      }
    } else {
      emit(state.copyWith(isUpdatingAddress: true, errorMessage: null));
      final result = await _updateAddressUseCase.call(
          addressId: addressId, requestModel: request);
      switch (result) {
        case ApiSuccessResult<void>():
          emit(state.copyWith(isUpdatingAddress: false, isSuccess: true));
        case ApiErrorResult<void>():
          emit(state.copyWith(
              isUpdatingAddress: false,
              errorMessage: result.failure.errorMessage));
      }
    }
  }

  Future<void> _setGovernorateAndCityFromAddress(AddressEntity address) async {
    final governorate = state.governorates.firstWhere(
      (gov) =>
          gov.governorateNameEn.toLowerCase() == address.city?.toLowerCase(),
      orElse: () => throw Exception(LocaleKeys.governorate_not_found.tr()),
    );

    emit(state.copyWith(selectedGovernorateId: governorate.id));

    await _loadCitiesByGovernorate(governorate.id);

    final city = state.cities.firstWhere(
      (city) => city.cityNameEn.toLowerCase() == address.street?.toLowerCase(),
      orElse: () => throw Exception(LocaleKeys.city_not_found.tr()),
    );

    emit(state.copyWith(selectedCityId: city.id));
  }

  Future<void> _initializeEditAddress(AddressEntity address) async {
    emit(state.copyWith(
      isEditMode: true,
      editingAddressId: address.id,
    ));

    _fillFormForEdit(address);

    if (state.governorates.isEmpty) {
      await _loadGovernorates();
    }

    await _setGovernorateAndCityFromAddress(address);
  }

  void _dispose() {
    emit(state.copyWith(
      isEditMode: false,
      editingAddressId: null,
      isSuccess: false,
    ));

    addressController.clear();
    phoneController.clear();
    recipientNameController.clear();
  }

  void _navigateToAddAddress() {
    emit(state.copyWith(navigateToAddAddress: true));
  }
}
