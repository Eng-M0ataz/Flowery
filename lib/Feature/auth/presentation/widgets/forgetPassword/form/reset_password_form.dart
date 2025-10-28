import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Functions/validators.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_password_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/localization/locale_keys.g.dart';
import '../../../../../../core/utils/Constantts/sizes.dart';
import '../../../viewModel/forgetPassword/forget_password_event.dart';
import '../../../viewModel/forgetPassword/forget_password_states.dart';
import '../../../viewModel/forgetPassword/forget_password_view_model.dart';
import '../build_title_and_sub.dart';
import '../../../../../../core/Widgets/custom_elevated_button.dart';

class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ForgetPasswordViewModel>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: AppSizes.spaceBetweenItems_40),
          BuildTitleAndSub(
            title: LocaleKeys.resetPassword.tr(),
            subTitle: LocaleKeys.passwordValidation.tr(),
          ),
          SizedBox(height: AppSizes.spaceBetweenItems_32),
          Form(
              key: viewModel.resetPasswordKey,
              child: Column(
                children: [

                  CustomPasswordTextFormField(
                    controller:viewModel.newPasswordController ,
                    hint: LocaleKeys.enterPassword.tr(),
                    label:LocaleKeys.password.tr(),
                    validator: Validations.validatePassword,
                  ),
                  SizedBox(height: AppSizes.spaceBetweenItems_24),


                  CustomPasswordTextFormField(
                    controller:viewModel.confirmPasswordController ,
                    hint: LocaleKeys.confirmPassword.tr(),
                    label:LocaleKeys.confirmPassword.tr(),
                    validator: (val) =>
                        Validations.validateConfirmPassword(val, viewModel.newPasswordController.text),
                  ),


                  SizedBox(height: AppSizes.spaceBetweenItems_48),
                  BlocBuilder<ForgetPasswordViewModel, ForgetPasswordState>(
                    builder: (context, state) {
                      return CustomElevatedButton(
                          onPressed: () =>
                              viewModel.doIntent(ResetPasswordEvent()),
                          isLoading:
                              state.status == ForgetPasswordStatus.loading,
                          widget: Text(LocaleKeys.confirm.tr()));
                    },
                  ),
                ],
              )),
          SizedBox(height: AppSizes.spaceBetweenItems_16),
        ],
      ),
    );
  }
}
