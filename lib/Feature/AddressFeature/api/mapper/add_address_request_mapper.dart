import 'package:flower_e_commerce_app/Feature/AddressFeature/api/models/request/add_address_request_model.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/viewModel/addressViewModel/address_state.dart';
import 'package:flutter/material.dart';

extension AddressStateMapper on AddressState {
  AddAddressRequestModel toRequestModel({
    required TextEditingController phoneController,
    required TextEditingController recipientNameController,
  }) {
    final city = cities.firstWhere((c) => c.id == selectedCityId).cityNameEn;
    final governorate = governorates
        .firstWhere((g) => g.id == selectedGovernorateId)
        .governorateNameEn;
    return AddAddressRequestModel(
        street: city,
        phone: phoneController.text.trim(),
        city: governorate,
        lat: selectedLat,
        long: selectedLong,
        username: recipientNameController.text.trim());
  }
}
