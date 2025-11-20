import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/app_routes.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/Config/Theme/app_colors.dart';
import '../../../../core/localization/locale_keys.g.dart';

import '../viewModels/checkout_event.dart';
import '../viewModels/checkout_state.dart';
import '../viewModels/checkout_view_model.dart';
import 'address_item.dart';

class AddressSection extends StatelessWidget {
  const AddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.onPrimary),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingMd_16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSizes.spaceBetweenItems_24),
            Text(
              LocaleKeys.delivery_address.tr(),
              style: Theme.of(context).textTheme.displaySmall,
            ),
            SizedBox(
              height: AppSizes.spaceBetweenItems_16,
            ),
            BlocBuilder<CheckoutViewModel, CheckoutState>(
              builder: (context, state) {
                final addresses = state.userAddressResponse?.addresses ?? [];
                if (state.isAddressLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (addresses.isEmpty) {
                  return const Center(
                    child: Text(LocaleKeys.no_addresses),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => AddressItem(
                      addressTitle:
                          "${addresses[index].street!} _${addresses[index].city!}",
                      isSelected:
                          state.selectedAddressId == addresses[index].id,
                      onSelect: () {
                        context.read<CheckoutViewModel>().doIntent(
                            event: SelectAddressEvent(
                                addressId: addresses[index].id!));
                      }),
                  separatorBuilder: (context, index) => SizedBox(
                    height: AppSizes.spaceBetweenItems_16,
                  ),
                  itemCount: addresses.length,
                );
              },
            ),
            SizedBox(
              height: AppSizes.spaceBetweenItems_16,
            ),
            Container(
              padding: EdgeInsets.all(AppSizes.paddingXs_4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusXl_20),
                border: Border.all(color: AppColorsLight.white[60]!, width: 2),
              ),
              child: GestureDetector(
                onTap: () async {
                  final result =
                      await context.pushNamed(AppRoutes.addAddressScreenRoute);
                  if (result == true) {
                    context
                        .read<CheckoutViewModel>()
                        .doIntent(event: LoadUserAddressEvent());
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      size: AppSizes.mdIcon_24,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(
                      LocaleKeys.add_new.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: AppSizes.spaceBetweenItems_16,
            ),
          ],
        ),
      ),
    );
  }
}
