import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/checkout/presentation/widgets/visa_payment_web_view.dart';
import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/Widgets/custom_elevated_button.dart';
import '../../../../core/helpers/dialogue_utils.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../viewModels/checkout_event.dart';
import '../viewModels/checkout_state.dart';
import '../viewModels/checkout_view_model.dart';

class OrderButtonWithFeedback extends StatelessWidget {
  const OrderButtonWithFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckoutViewModel, CheckoutState>(
      listenWhen: (previous, current) {
        return previous.visaOrderResponse != current.visaOrderResponse ||
            previous.cashOrderSuccessMessage !=
                current.cashOrderSuccessMessage ||
            previous.cashOrderFailure != current.cashOrderFailure ||
            previous.visaOrderFailure != current.visaOrderFailure ||
            previous.validationFailure != current.validationFailure;
      },
      listener: (context, state) {
        if (state.cashOrderFailure != null ||
            state.visaOrderFailure != null ||
            state.validationFailure != null) {
          DialogueUtils.showMessage(
            context: context,
            message: state.cashOrderFailure?.errorMessage ??
                state.visaOrderFailure?.errorMessage ??
                state.validationFailure?.errorMessage ??
                LocaleKeys.something_went_wrong.tr(),
            posActionName: LocaleKeys.ok.tr(),
          );
        } else if (state.cashOrderSuccessMessage != null) {
          DialogueUtils.showMessage(
            context: context,
            posActionName: LocaleKeys.ok.tr(),
            message: LocaleKeys.cashOrderSuccessMessage.tr(),
            posAction: () {
              context.pushReplacementNamed(AppRoutes.successOrderRoute,
                  arguments: state.cashOrderResponse!.orderId);
            },
          );
        } else if (!state.isVisaOrderLoading &&
            state.visaOrderResponse != null) {
          final url = state.visaOrderResponse!.url;
          if (url != null && url.isNotEmpty) {
            DialogueUtils.showMessage(
              context: context,
              posActionName: LocaleKeys.ok.tr(),
              message: LocaleKeys.visaOrderSuccessMessage.tr(),
              posAction: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => VisaPaymentWebView(url: url),
                  ),
                );
              },
            );
          } else {
            DialogueUtils.showMessage(
              context: context,
              posActionName: LocaleKeys.ok.tr(),
              message: LocaleKeys.unableToLoadPaymentPage.tr(),
            );
          }
        }
      },
      builder: (context, state) {
        return CustomElevatedButton(
          onPressed: () {
            context.read<CheckoutViewModel>().doIntent(
                  event: PlaceOrderEvent(),
                );
          },
          isLoading: state.isCashOrderLoading || state.isVisaOrderLoading,
          widget: Text(LocaleKeys.place_order.tr()),
        );
      },
    );
  }
}
