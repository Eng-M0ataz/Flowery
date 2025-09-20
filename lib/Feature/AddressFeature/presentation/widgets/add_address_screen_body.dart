import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/viewModel/addressViewModel/address_event.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/viewModel/addressViewModel/address_state.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/viewModel/addressViewModel/address_view_model.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/widgets/build_address_field.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/widgets/build_governorate_and_city_field.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/widgets/build_phone_field.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/widgets/build_recipient_name_field.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/widgets/google_map_widget.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_app_bar.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_elevated_button.dart';
import 'package:flower_e_commerce_app/core/helpers/dialogue_utils.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAddressScreenBody extends StatelessWidget {
  const AddAddressScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AddressViewModel>();

    return BlocListener<AddressViewModel, AddressState>(
        bloc: viewModel,
        listener: (context, state) {
          if (!context.mounted) return;

          if (state.errorMessage != null &&
              !state.isAddingAddress &&
              !state.isUpdatingAddress) {
            DialogueUtils.showMessage(
              context: context,
              message: state.errorMessage!,
              title: LocaleKeys.error.tr(),
              ngeActionName: LocaleKeys.ok.tr(),
            );
          }

          if (state.isSuccess &&
              !state.isAddingAddress &&
              !state.isUpdatingAddress) {
            final message = state.isEditMode
                ? LocaleKeys.address_updated_successfully.tr()
                : LocaleKeys.address_added_successfully.tr();

            DialogueUtils.showMessage(
              context: context,
              message: message,
              title: LocaleKeys.success.tr(),
              ngeActionName: LocaleKeys.ok.tr(),
              ngeAction: () {
                if (context.mounted) {
                  Navigator.of(context).pop(true);
                }
              },
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leadingWidth: AppSizes.appBarLeadingWidth,
            leading: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_16),
              child: BlocBuilder<AddressViewModel, AddressState>(
                builder: (context, state) {
                  return CustomBackButton(
                    title: state.isEditMode
                        ? LocaleKeys.edit_address.tr()
                        : LocaleKeys.add_address.tr(),
                  );
                },
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.only(
                  left: AppSizes.paddingMd_20,
                  right: AppSizes.paddingMd_20,
                  bottom: AppSizes.paddingMd_20),
              child: Column(
                children: [
                  GoogleMapWidget(
                    height: AppSizes.mapHeight,
                    selectedAddressId: viewModel.state.editingAddressId,
                  ),
                  Form(
                    key: viewModel.formKey,
                    child: Column(
                      children: [
                        SizedBox(height: AppSizes.spacingBetweenItems_24),
                        BuildAddressField(
                            addressController: viewModel.addressController),
                        SizedBox(height: AppSizes.spacingBetweenItems_24),
                        BuildPhoneField(controller: viewModel.phoneController),
                        SizedBox(height: AppSizes.spacingBetweenItems_24),
                        BuildRecipientNameField(
                            recipientNameController:
                                viewModel.recipientNameController),
                        SizedBox(height: AppSizes.spacingBetweenItems_24),
                        BlocBuilder<AddressViewModel, AddressState>(
                          builder: (context, state) {
                            return BuildGovernorateAndCityFields(
                              governorates: state.governorates,
                              cities: state.cities,
                              selectedGovernorate:
                                  state.selectedGovernorateId?.toString(),
                              selectedCity: state.selectedCityId?.toString(),
                              onGovernorateChanged: (String? value) {
                                if (value != null) {
                                  final governorateId = int.parse(value);
                                  context.read<AddressViewModel>().doIntent(
                                        SelectGovernorateEvent(
                                            governorateId: governorateId),
                                      );
                                }
                              },
                              onCityChanged: (String? value) {
                                if (value != null) {
                                  final cityId = int.parse(value);
                                  context.read<AddressViewModel>().doIntent(
                                        SelectCityEvent(cityId: cityId),
                                      );
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSizes.spacingBetweenItems_48),
                  BlocBuilder<AddressViewModel, AddressState>(
                    builder: (context, state) {
                      return CustomElevatedButton(
                        onPressed: () {
                          if (state.isEditMode &&
                              state.editingAddressId != null) {
                            viewModel.doIntent(
                              UpdateAddressEvent(
                                  addressId: state.editingAddressId!),
                            );
                          } else {
                            viewModel.doIntent(AddAddressEvent());
                          }
                        },
                        isLoading:
                            state.isAddingAddress || state.isUpdatingAddress,
                        widget: Text(state.isEditMode
                            ? LocaleKeys.update_address.tr()
                            : LocaleKeys.add_address.tr()),
                      );
                    },
                  ),
                ],
              ),
            )),
          ),
        ));
  }
}
