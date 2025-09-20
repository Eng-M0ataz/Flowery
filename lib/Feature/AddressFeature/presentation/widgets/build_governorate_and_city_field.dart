import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/city_entity.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/governorate_entity.dart';
import 'package:flower_e_commerce_app/core/Functions/validators.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';

class BuildGovernorateAndCityFields extends StatelessWidget {
  final String? selectedGovernorate;
  final String? selectedCity;
  final List<GovernorateEntity> governorates;
  final List<CityEntity> cities;
  final Function(String?) onGovernorateChanged;
  final Function(String?) onCityChanged;

  const BuildGovernorateAndCityFields({
    super.key,
    required this.selectedGovernorate,
    required this.selectedCity,
    required this.governorates,
    required this.cities,
    required this.onGovernorateChanged,
    required this.onCityChanged,
  });

  @override
  Widget build(BuildContext context) {
    final filteredCities = selectedGovernorate != null
        ? cities
            .where(
                (city) => city.governorateId.toString() == selectedGovernorate)
            .toList()
        : <CityEntity>[];

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: DropdownButtonFormField<String>(
              value: selectedGovernorate,
              isExpanded: true,
              items: governorates.map((gov) {
                return DropdownMenuItem(
                  value: gov.id.toString(),
                  child: Text(
                    gov.governorateNameEn,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                );
              }).toList(),
              onChanged: onGovernorateChanged,
              validator: Validations.validateCity,
              decoration: InputDecoration(
                labelText: LocaleKeys.governorate.tr(),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingMd_12,
                    vertical: AppSizes.paddingSm_8),
              ),
            ),
          ),
          const SizedBox(width: AppSizes.spaceBetweenItems_16),
          Flexible(
            flex: 1,
            child: DropdownButtonFormField<String>(
              value: filteredCities
                      .any((city) => city.id.toString() == selectedCity)
                  ? selectedCity
                  : null,
              isExpanded: true,
              items: selectedGovernorate == null
                  ? null
                  : filteredCities.map((city) {
                      return DropdownMenuItem(
                        value: city.id.toString(),
                        child: Text(
                          city.cityNameEn,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      );
                    }).toList(),
              validator: Validations.validateCity,
              onChanged: selectedGovernorate == null ? null : onCityChanged,
              decoration: InputDecoration(
                labelText: LocaleKeys.city.tr(),
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingMd_12,
                  vertical: AppSizes.paddingSm_8,
                ),
                enabled: selectedGovernorate != null,
                hintText: selectedGovernorate == null
                    ? LocaleKeys.select_governorate_first.tr()
                    : filteredCities.isEmpty
                        ? LocaleKeys.no_cities_available.tr()
                        : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
