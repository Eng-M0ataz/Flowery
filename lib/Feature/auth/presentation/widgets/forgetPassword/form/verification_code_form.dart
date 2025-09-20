import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/widgets/forgetPassword/main_timer.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/widgets/forgetPassword/resend_text.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/widgets/forgetPassword/resend_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/Widgets/custom_app_bar.dart';
import '../../../../../../core/localization/locale_keys.g.dart';
import '../../../../../../core/utils/Constantts/sizes.dart';
import '../../../viewModel/forgetPassword/forget_password_event.dart';
import '../../../viewModel/forgetPassword/forget_password_states.dart';
import '../../../viewModel/forgetPassword/forget_password_view_model.dart';
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
                title: LocaleKeys.resetPassword.tr(),
                subTitle: LocaleKeys.enterCodeInstruction.tr(),
              ),
              SizedBox(height: AppSizes.spaceBetweenItems_32),
              Form(
                key: viewModel.verifyCodeKey,
                child: Column(
                  children: [
                    BuildPinCode(
                      controller: viewModel.codeController,
                      onCompleted: (String value) {
                        viewModel.doIntent(VerifyCodeEvent());
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
                                  LocaleKeys.didNotReceiveCode.tr(),
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                                TextButton(
                                  onPressed: state.isResendAvailable
                                      ? () {
                                          viewModel.doIntent(ResendCodeEvent());
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
                                        ResendTimerFinishedEvent(),
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
