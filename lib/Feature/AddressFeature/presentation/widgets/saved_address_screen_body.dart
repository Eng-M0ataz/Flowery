import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/pages/add_address_screen.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/viewModel/addressViewModel/address_event.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/viewModel/addressViewModel/address_state.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/viewModel/addressViewModel/address_view_model.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/widgets/build_location_card_widget.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_app_bar.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_elevated_button.dart';
import 'package:flower_e_commerce_app/core/helpers/dialogue_utils.dart';
import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/app_routes.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedAddressScreenBody extends StatelessWidget {
  const SavedAddressScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AddressViewModel>();
    return Scaffold(
        appBar: AppBar(
          leadingWidth: AppSizes.appBarLeadingWidth,
          leading: Padding(
            padding: const EdgeInsets.all(AppSizes.paddingMd_16),
            child: CustomBackButton(title: LocaleKeys.saved_addresses.tr()),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                left: AppSizes.paddingMd_20,
                right: AppSizes.paddingMd_20,
                bottom: AppSizes.paddingMd_20),
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<AddressViewModel, AddressState>(
                    bloc: viewModel,
                    buildWhen: (p, c) => p.addressList != c.addressList,
                    builder: (context, state) {
                      if (!state.isLoading && state.addressList.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_off,
                                size: AppSizes.lgIcon_32,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(height: AppSizes.paddingMd_16),
                              Text(
                                LocaleKeys.no_saved_addresses.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
                        );
                      }
                      if (state.errorMessage != null) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          DialogueUtils.showMessage(
                            context: context,
                            message: state.errorMessage!,
                            ngeActionName: LocaleKeys.ok.tr(),
                            title: LocaleKeys.error.tr(),
                          );
                        });
                      }

                      if (state.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return ListView.builder(
                        itemCount: state.addressList.length,
                        itemBuilder: (context, index) {
                          final address = state.addressList[index];
                          return LocationCard(
                            city: viewModel.state.addressList[index].city ?? '',
                            address:
                                viewModel.state.addressList[index].street ?? '',
                            onDelete: () {
                              final addressId =
                                  viewModel.state.addressList[index].id;
                              if (addressId.isNotEmpty) {
                                viewModel.doIntent(
                                  DeleteAddressEvent(addressId: addressId),
                                );
                              }
                            },
                            onEdit: () async {
                              final result = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AddAddressScreen(
                                    addressToEdit: address,
                                  ),
                                ),
                              );
                              if (result == true) {
                                viewModel.doIntent(GetAddressesEvent());
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                BlocConsumer<AddressViewModel, AddressState>(
                  listener: (context, state) async {
                    if (state.navigateToAddAddress) {
                      final result = await context
                          .pushNamed(AppRoutes.addAddressScreenRoute);
                      context.read<AddressViewModel>().emit(
                            state.copyWith(navigateToAddAddress: false),
                          );
                      if (result == true) {
                        context
                            .read<AddressViewModel>()
                            .doIntent(RefreshAddressesEvent());
                      }
                    }
                  },
                  builder: (context, state) {
                    return CustomElevatedButton(
                      onPressed: () async {
                        context
                            .read<AddressViewModel>()
                            .doIntent(NavigateToAddAddressEvent());
                      },
                      isLoading: state.isLoading,
                      widget: Text(LocaleKeys.add_new_address.tr()),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
