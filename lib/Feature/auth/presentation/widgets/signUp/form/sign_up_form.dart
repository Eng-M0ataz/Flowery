import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/viewModel/states/sign_Up_state.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/viewModel/viewModel/signup_view_model.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/widgets/signUp/build_email_field.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/widgets/signUp/build_first_and_last_name_field.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/widgets/signUp/build_gender_filed.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/widgets/signUp/build_navigation_text.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/widgets/signUp/build_password_and_confirm_field.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/widgets/signUp/build_phone_field.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_theme.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_app_bar.dart';
import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flower_e_commerce_app/core/utils/custom_elevated_button.dart';
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
        DialogueUtils.showMessage(
          context: context,
          message: state.errorMessage!,
        );
      }
      if (state.isSuccess && !state.isLoading) {
        DialogueUtils.showMessage(
          context: context,
          message: LocaleKeys.account_created_successfully.tr(),
          title: LocaleKeys.success.tr(),
          posActionName: LocaleKeys.ok.tr(),
          posAction: () {
            context.pushReplacementNamed(AppRoutes.signInRoute);
          },
        );

        context.read<SignupViewModel>().clearForm();
      }
    }, builder: (context, state) {
      final viewModel = context.read<SignupViewModel>();

      return Scaffold(
          appBar: AppBar(
            leadingWidth: AppSizes.appBarLeadingWidth,
            leading: CustomBackButton(
              title: LocaleKeys.sign_up.tr(),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: viewModel.formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingMd_20),
                  child: AutofillGroup(
                      child: Column(
                    children: [
                      const SizedBox(height: AppSizes.paddingLg_24),
                      BuildFirstAndLastNameField(
                        firstNameController:
                            viewModel.signUpFirstNameController,
                        secondNameController:
                            viewModel.signUpLastNameController,
                      ),
                      const SizedBox(height: AppSizes.spacingBetweenItems_24),
                      BuildEmailField(
                        controller: viewModel.signUpEmailController,
                      ),
                      const SizedBox(height: AppSizes.spacingBetweenItems_24),
                      BuildPasswordAndConfirmField(
                          passwordController:
                              viewModel.signUpPasswordController,
                          confirmController:
                              viewModel.signUpRePasswordController),
                      const SizedBox(height: AppSizes.spacingBetweenItems_24),
                      BuildPhoneField(
                        controller: viewModel.signUpPhoneController,
                      ),
                      const SizedBox(height: AppSizes.spacingBetweenItems_24),
                      BuildGenderField(
                          selectedGender: viewModel.selectedGender,
                          onChanged: (String gender) {
                            viewModel.updateGender(gender);
                            setState(() {});
                          }),
                      const SizedBox(height: AppSizes.spaceBetweenItems_16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.create_account_prompt.tr(),
                            style: AppThemeLight
                                .lightTheme.textTheme.bodyMedium!
                                .copyWith(fontSize: 11),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {
                              // TODO: navigate to terms and conditions
                            },
                            child: Text(
                              LocaleKeys.terms_and_conditions.tr(),
                              style: AppThemeLight
                                  .lightTheme.textTheme.labelLarge!
                                  .copyWith(
                                      decoration: TextDecoration.underline,
                                      fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.spacingBetweenItems_32),
                      CustomElevatedButton(
                        onPressed: state.isLoading
                            ? null
                            : () => viewModel.submitSignUpForm(),
                        isLoading: state.isLoading,
                        title: state.isLoading
                            ? LocaleKeys.loading.tr()
                            : LocaleKeys.sign_up_title.tr(),
                      ),
                      const SizedBox(height: AppSizes.spacingBetweenItems_16),
                      BuildNavigationText(
                          firstText:
                              LocaleKeys.already_have_account_prompt.tr(),
                          secondText: LocaleKeys.login_title.tr(),
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
