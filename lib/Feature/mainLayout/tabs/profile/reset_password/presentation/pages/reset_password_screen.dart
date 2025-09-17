import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/presentation/viewModel/profile_event.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/presentation/viewModel/resetPasswordViewModel.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/presentation/viewModel/reset_password_state.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/presentation/widgets/password_text_field.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flower_e_commerce_app/core/Functions/validators.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_elevated_button.dart';
import 'package:flower_e_commerce_app/core/helpers/dialogue_utils.dart';
import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
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
          if (state.failure != null && !state.isLoading) {
            DialogueUtils.showMessage(
              context: context,
              message: state.failure!.errorMessage,
              posActionName: LocaleKeys.ok.tr(),
              posAction: () {
              },
            );
          } else if (state.resetPasswordSuccess && !state.isLoading) {
            DialogueUtils.showMessage(
              context: context,
              message: LocaleKeys.password_is_changed.tr(),
              posActionName: LocaleKeys.ok.tr(),
              posAction: () {
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
                onPressed: () => context.pop(),
              ),
              title: Text(
                LocaleKeys.reset_password.tr(),
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    PasswordTextField(
                      lableText:LocaleKeys.current_password.tr(),
                      isPassword: true,
                      hintText: LocaleKeys.current_password.tr(),
                      validator: Validations.validatePassword,
                      controller: viewModel.currentPasswordController,
                    ),
                    SizedBox(height: AppSizes.spaceBetweenItems_8),
                    PasswordTextField(
                      lableText: LocaleKeys.new_password.tr(),
                      isPassword: true,
                      hintText: LocaleKeys.new_password.tr(),
                      validator: Validations.validatePassword,
                      controller: viewModel.newPasswordController,
                    ),
                    SizedBox(height: AppSizes.spaceBetweenItems_8),
                    PasswordTextField(
                      lableText: LocaleKeys.confirm_password.tr(),
                      isPassword: true,
                      hintText: LocaleKeys.confirm_password.tr(),
                      validator: (val) => Validations.validateConfirmPassword(
                        val,
                        viewModel.newPasswordController.text,
                      ),
                      controller: viewModel.confirmPasswordController,
                    ),
                    Padding(
                      padding: EdgeInsets.all(AppSizes.spaceBetweenItems_16),
                      child: CustomElevatedButton(
                        title: LocaleKeys.update.tr(),
                        onPressed: () {
                          if (viewModel.resetPasswordFormKey.currentState!
                              .validate()) {
                            viewModel.doIntent(ResetPasswordSubmitEvent());
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