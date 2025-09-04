import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/widgets/forgetPassword/main_timer.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/widgets/forgetPassword/resend_text.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/widgets/forgetPassword/resend_timer.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/localization/locale_keys.g.dart';
import '../../../../../../core/utils/Constants/sizes.dart';
import '../../../viewModel/events/forget_password_intent.dart';
import '../../../viewModel/states/forget_password_states.dart';
import '../../../viewModel/viewModel/forget_password_view_model.dart';
import '../build_pin_code.dart';
import '../build_title_and_sub.dart';

class VerificationCodeForm extends StatelessWidget {
  const VerificationCodeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ForgetPasswordViewModel>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppSizes.spaceBetweenItems_16),
              CustomBackButton(title: LocaleKeys.password.tr()),
              SizedBox(height: AppSizes.spaceBetweenItems_40),
              BuildTitleAndSub(
                title: LocaleKeys.reset_password.tr(),
                subTitle: LocaleKeys.enter_code_instruction.tr(),
              ),
              SizedBox(height: AppSizes.spaceBetweenItems_32),
              Form(
                key: viewModel.verifyCodeKey,
                child: Column(
                  children: [
                    BuildPinCode(
                      controller: viewModel.codeController,
                      onCompleted: (String value) {
                        viewModel.doIntent(VerifyCodeIntent());
                      },
                    ),
                    SizedBox(height: AppSizes.spaceBetweenItems_16),
                    MainTimer(),
                    SizedBox(height: AppSizes.spaceBetweenItems_8),
                    BlocBuilder<ForgetPasswordViewModel, ForgetPasswordState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  LocaleKeys.did_not_receive_code.tr(),
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                                TextButton(
                                  onPressed: state.isResendAvailable
                                      ? () {
                                          viewModel
                                              .doIntent(ResendCodeIntent());
                                        }
                                      : null,
                                  child: ResendText(
                                    isResendAvailable: state.isResendAvailable,
                                  ),
                                ),
                              ],
                            ),
                            !state.isResendAvailable
                                ? ResendTimer(
                                    onEnd: () {
                                      viewModel.doIntent(
                                        ResendTimerFinishedIntent(),
                                      );
                                    },
                                  )
                                : SizedBox(),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
