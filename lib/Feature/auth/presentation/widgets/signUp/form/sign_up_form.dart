import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/viewModel/states/sign_Up_state.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/viewModel/signup_view_model.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/widgets/signUp/build_elevated_button.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/widgets/signUp/build_email_field.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/widgets/signUp/build_first_and_last_name_field.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/widgets/signUp/build_gender_filed.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/widgets/signUp/build_navigation_text.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/widgets/signUp/build_password_and_confirm_field.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/widgets/signUp/build_phone_field.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_theme.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_app_bar.dart';
import 'package:flower_e_commerce_app/core/utils/dialog_utils.dart';
import 'package:flower_e_commerce_app/core/helpers/dialogue_utils.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/app_routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupViewModel, SignUpState>(
        listener: (context, state) {
      if (state.errorMessage != null && !state.isLoading) {
        DialogUtils.showMessage(
          context: context,
          message: state.errorMessage!,
        );
      }
      if (state.isSuccess && !state.isLoading) {
        DialogUtils.showMessage(
          context: context,
          message: 'Account created successfully!',
        );

        // Clear form after success
        context.read<SignupViewModel>().clearForm();

        // Navigate after showing success message
        Future.delayed(const Duration(seconds: 2), () {
          if (context.mounted) {
            Navigator.pushReplacementNamed(context, AppRoutes.signInRoute);
          }
        });
      }
    }, builder: (context, state) {
      final viewModel = context.read<SignupViewModel>();

      return Scaffold(
          appBar: AppBar(
            leadingWidth: 120,
            leading: CustomBackButton(
              title: "sign_up".tr(),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: viewModel.formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AutofillGroup(
                      child: Column(
                    children: [
                      const SizedBox(height: 24),
                      BuildFirstAndLastNameField(
                        firstNameController:
                            viewModel.signUpFirstNameController,
                        secondNameController:
                            viewModel.signUpLastNameController,
                      ),
                      const SizedBox(height: 24),
                      BuildEmailField(
                        controller: viewModel.signUpEmailController,
                      ),
                      const SizedBox(height: 24),
                      BuildPasswordAndConfirmField(
                          passwordController:
                              viewModel.signUpPasswordController,
                          confirmController:
                              viewModel.signUpRePasswordController),
                      const SizedBox(height: 24),
                      BuildPhoneField(
                        controller: viewModel.signUpPhoneController,
                      ),
                      const SizedBox(height: 24),
                      BuildGenderField(
                          selectedGender: viewModel.selectedGender,
                          onChanged: (String gender) {
                            viewModel.updateGender(gender);
                            setState(() {});
                          }),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'create_account_prompt'.tr(),
                            style: AppThemeLight
                                .lightTheme.textTheme.bodyMedium!
                                .copyWith(fontSize: 10),
                          ),
                          TextButton(
                            onPressed: () {
                              // TODO: navigate to terms and conditions
                            },
                            child: Text(
                              'terms_and_conditions'.tr(),
                              style: AppThemeLight
                                  .lightTheme.textTheme.labelLarge!
                                  .copyWith(
                                      decoration: TextDecoration.underline,
                                      fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      BuildElevatedButton(
                        text: state.isLoading
                            ? 'Loading...'
                            : 'sign_up_title'.tr(),
                        isLoading: state.isLoading,
                        onPressed: state.isLoading
                            ? null
                            : () => viewModel.submitSignUpForm(),
                      ),
                      const SizedBox(height: 16),
                      BuildNavigationText(
                          firstText: 'already_have_account_prompt'.tr(),
                          secondText: 'login_title'.tr(),
                          routeName: AppRoutes.signInRoute)
                    ],
                  )),
                ),
              ),
            ),
          ));
    });
  }
}
/*
;*/