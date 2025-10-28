import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/viewModel/forgetPassword/forget_password_view_model.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_elevated_button.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../viewModel/forgetPassword/forget_password_event.dart';
import '../../../viewModel/forgetPassword/forget_password_states.dart';
import '../build_email_field.dart';
import '../build_title_and_sub.dart';

class ForgetPasswordForm extends StatelessWidget {
  const ForgetPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ForgetPasswordViewModel>();

    return  SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: AppSizes.spaceBetweenItems_40),
          BuildTitleAndSub(
            title: LocaleKeys.forgetPassword.tr(),
            subTitle: LocaleKeys.enterEmailInstruction.tr(),
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
                              viewModel.doIntent(SendForgetRequestEvent()),
                          isLoading:
                          state.status == ForgetPasswordStatus.loading,
                          widget: Text(LocaleKeys.confirm.tr()));
                    },
                  ),
                ],
              ))
        ],
      ),
    );
      
  }
}
