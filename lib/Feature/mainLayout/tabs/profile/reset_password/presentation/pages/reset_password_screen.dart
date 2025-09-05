import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/presentation/viewModel/profile_event.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/presentation/viewModel/resetPasswordViewModel.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/presentation/viewModel/reset_password_state.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/presentation/widgets/password_text_field.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flower_e_commerce_app/core/Functions/validators.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_app_bar.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_elevated_button.dart';
import 'package:flower_e_commerce_app/core/helpers/dialogue_utils.dart';
import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flower_e_commerce_app/generated/locale_keys.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ResetPasswordViewModel>(),
      child: BlocConsumer<ResetPasswordViewModel, ResetPasswordState>(
        listener: (context, state) {
          final viewModel = context.read<ResetPasswordViewModel>();

          if (state.failure != null && !state.isLoading) {
            DialogueUtils.showMessage(
              context: context,
              message: state.failure!.errorMessage,
              posActionName: "ok",
              posAction: () {
                viewModel.resetPasswordSuccessState();
                context.pop();
              },
            );
          } else if (state.resetPasswordSuccess && !state.isLoading) {
            DialogueUtils.showMessage(
              context: context,
              message: "Password is changed",
              posActionName: "ok",
              posAction: () {
                viewModel.resetPasswordSuccessState();
                context.pop();
              },
            );
          }
        },
        builder: (context, state) {
          final viewModel = context.read<ResetPasswordViewModel>();
          return Scaffold(
            appBar: AppBar(
              leading: CupertinoNavigationBarBackButton(
                color: AppColorsLight.black,
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                "Reset Password",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              centerTitle: false,
              elevation: 0,
              backgroundColor: AppColorsLight.white,
              foregroundColor: AppColorsLight.black,
            ),
            body: SafeArea(
              child: Form(
                key: viewModel.resetPasswordFormKey,
                child: Column(
                  children: [
                    PasswordTextField(
                      lableText:LocaleKeys.currentPassword.tr(),
                      isPassword: true,
                      hintText: LocaleKeys.currentPassword.tr(),
                      validator: Validations.validatePassword,
                      controller: viewModel.currentPasswordController,
                    ),
                    SizedBox(height: AppSizes.spaceBetweenItems_8),
                    PasswordTextField(
                      lableText: "New Password",
                      isPassword: true,
                      hintText: "New Password",
                      validator: Validations.validatePassword,
                      controller: viewModel.newPasswordController,
                    ),
                    SizedBox(height: AppSizes.spaceBetweenItems_8),
                    PasswordTextField(
                      lableText: "Confirm Password",
                      isPassword: true,
                      hintText: "Confirm Password",
                      validator: (val) => Validations.validateConfirmPassword(
                        val,
                        viewModel.newPasswordController.text,
                      ),
                      controller: viewModel.confirmPasswordController,
                    ),
                    Padding(
                      padding: EdgeInsets.all(AppSizes.spaceBetweenItems_16),
                      child: CustomElevatedButton(
                        title: "Update",
                        onPressed: () {
                          if (viewModel.resetPasswordFormKey.currentState!
                              .validate()) {
                            viewModel.doIntent(ResetPasswordEvent());
                          }
                        },
                        isLoading: state.isLoading,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
