import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/viewModel/viewModel/forget_password_view_model.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_app_bar.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flower_e_commerce_app/core/utils/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../viewModel/events/forget_password_intent.dart';
import '../../../viewModel/states/forget_password_states.dart';
import '../build_email_field.dart';
import '../build_title_and_sub.dart';

class ForgetPasswordForm extends StatelessWidget {
  const ForgetPasswordForm({super.key});

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
              title: LocaleKeys.forget_password.tr(),
              subTitle: LocaleKeys.enter_email_instruction.tr(),
            ),
            SizedBox(height: AppSizes.spaceBetweenItems_32),
            Form(
                key: viewModel.forgetPasswordKey,
                child: Column(
                  children: [
                    BuildEmailField(
                      controller: viewModel.emailController,
                    ),
                    SizedBox(height: AppSizes.spaceBetweenItems_48),
                    BlocBuilder<ForgetPasswordViewModel, ForgetPasswordState>(
                      builder: (context, state) {
                        return CustomElevatedButton(
                            onPressed: () =>
                                viewModel.doIntent(SendForgetRequestIntent()),
                            isLoading:
                                state.status == ForgetPasswordStatus.loading,
                            title: LocaleKeys.confirm.tr());
                      },
                    ),
                  ],
                ))
          ],
        ),
      )),
    );
  }
}
