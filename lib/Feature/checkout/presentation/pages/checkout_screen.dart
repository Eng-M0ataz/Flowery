import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/checkout/presentation/viewModels/checkout_view_model.dart';
import 'package:flower_e_commerce_app/Feature/checkout/presentation/widgets/address_section.dart';
import 'package:flower_e_commerce_app/Feature/checkout/presentation/widgets/app_bar_section.dart';
import 'package:flower_e_commerce_app/Feature/checkout/presentation/widgets/gift_section.dart';
import 'package:flower_e_commerce_app/Feature/checkout/presentation/widgets/payment_section.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/Constants/sizes.dart';
import '../viewModels/checkout_event.dart';
import '../viewModels/checkout_state.dart';
import '../widgets/order_button_with_feedback.dart';

class CheckoutScreen extends StatefulWidget {
  final double totalPrice;

  const CheckoutScreen({super.key, required this.totalPrice});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late final CheckoutViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<CheckoutViewModel>();
    _viewModel.doIntent(event: LoadUserAddressEvent());
  }

  @override
  void dispose() {
    _viewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _viewModel,
      child: Scaffold(
        backgroundColor: AppColorsLight.whiteGrey,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppBarSection(),
                const SizedBox(height: AppSizes.spaceBetwwenItems_24),
                AddressSection(),
                const SizedBox(height: AppSizes.spaceBetwwenItems_24),
                PaymentSection(),
                BlocBuilder<CheckoutViewModel, CheckoutState>(
                  builder: (context, state) {
                    if (state.isCash) {
                      return const SizedBox.shrink();
                    } else {
                      return Column(
                        children: [
                          const SizedBox(height: AppSizes.spaceBetwwenItems_24),
                          const GiftSection(),
                        ],
                      );
                    }
                  },
                ),
                const SizedBox(height: AppSizes.spaceBetwwenItems_24),
                Container(
                  color: Theme.of(context).colorScheme.onPrimary,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingMd_16,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: AppSizes.spaceBetwwenItems_24),
                        customPriceRow(LocaleKeys.sub_total.tr(),
                            widget.totalPrice, context),
                        const SizedBox(height: AppSizes.spaceBetweenItems_8),
                        customPriceRow(
                            LocaleKeys.delivery_fee.tr(), 10, context),
                        const SizedBox(height: AppSizes.spaceBetweenItems_8),
                        Divider(color: AppColorsLight.grey),
                        const SizedBox(height: AppSizes.spaceBetweenItems_8),
                        customPriceRow(LocaleKeys.total.tr(),
                            widget.totalPrice + 10, context),
                        const SizedBox(height: AppSizes.spaceBetweenItems_50),
                        OrderButtonWithFeedback(),
                        const SizedBox(height: AppSizes.spaceBetweenItems_50),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget customPriceRow(String title, double price, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headlineLarge!
            .copyWith(color: AppColorsLight.grey),
      ),
      Text(
        '$price\$',
        style: Theme.of(context)
            .textTheme
            .headlineLarge!
            .copyWith(color: AppColorsLight.grey),
      )
    ],
  );
}
