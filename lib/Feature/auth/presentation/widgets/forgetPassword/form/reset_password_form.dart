import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/Widgets/custom_app_bar.dart';
import '../../../../../../core/localization/locale_keys.g.dart';
import '../../../../../../core/utils/Constants/sizes.dart';
import '../../../viewModel/forgetPassword/forget_password_event.dart';
import '../../../viewModel/forgetPassword/forget_password_states.dart';
import '../../../viewModel/forgetPassword/forget_password_view_model.dart';
import '../build_confirm_password_field.dart';
import '../build_password_field.dart';
import '../build_title_and_sub.dart';
import '../../../../../../core/Widgets/custom_elevated_button.dart';

class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ForgetPasswordViewModel>();
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: AppSizes.spaceBetweenItems_16),
              CustomBackButton(title: LocaleKeys.password.tr()),
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
                      BuildPasswordField(
                        controller: viewModel.newPasswordController,
                      ),
                      SizedBox(height: AppSizes.spaceBetweenItems_24),
                      BuildConfirmPasswordField(
                        confirmController: viewModel.confirmPasswordController,
                        passwordController: viewModel.newPasswordController,
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
        ),
      )),
    );
  }
}
