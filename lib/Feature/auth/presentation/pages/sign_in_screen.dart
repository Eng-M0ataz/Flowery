import 'package:flower_e_commerce_app/Feature/auth/presentation/viewModel/states/sign_in_state.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/viewModel/viewModel/sign_in_view_model.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_theme.dart';
import 'package:flower_e_commerce_app/core/Functions/validators.dart';
import 'package:flower_e_commerce_app/core/Utils/constants/app_routes.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import '../../../../core/Di/di.dart';
import '../../../../core/Widgets/custom_app_bar.dart';
import '../../../../core/Widgets/custom_elevated_button.dart';
import '../../../../core/helpers/dialogue_utils.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final SigninViewModel _viewModel = getIt<SigninViewModel>();


  @override
  Widget build(BuildContext context) {
    final theme = AppThemeLight.lightTheme;
    return BlocProvider(
      create: (context) => _viewModel,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSizes.spaceBetweenItems_16),
                const CustomBackButton(title: LocaleKeys.login),
                const SizedBox(height: AppSizes.spaceBetweenItems_16),

                Form(
                  key: _viewModel.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _viewModel.emailController,
                        decoration: InputDecoration(
                          label: Text(
                              LocaleKeys.email,
                              style: theme.textTheme.bodyMedium
                          ),
                          hintText: LocaleKeys.email_hint,
                        ),
                        validator: (value) => Validations.validateEmail(value)
                      ),
                      const SizedBox(height: AppSizes.spaceBetweenItems_16),

                      TextFormField(
                        controller: _viewModel.passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          label: Text(
                              LocaleKeys.password,
                              style: theme.textTheme.bodyMedium
                          ),
                          hintText: LocaleKeys.password_hint,
                        ),
                        validator: (value) => Validations.validatePassword(value)
                      ),

                      const SizedBox(height: AppSizes.spaceBetweenItems_16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _viewModel.rememberMe,
                                onChanged: (val) {
                                    _viewModel.rememberMe = val ?? false;
                                },
                              ),
                              Text(LocaleKeys.remember_me),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              context.pushNamed(AppRoutes.forgetPasswordRoute);
                            },
                            child: Text(
                              LocaleKeys.forget_password,
                              style: theme.textTheme.bodyMedium!.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSizes.spaceBetweenItems_16),

                BlocConsumer<SigninViewModel, SignInState>(
                  bloc: _viewModel,
                  listener: (context, state) {
                    if (state.failure != null) {
                      DialogueUtils.showMessage(
                        context: context,
                        title: LocaleKeys.error,
                        message: state.failure?.errorMessage ?? "error",
                        posActionName: LocaleKeys.ok,
                      );
                    }
                    if (state.response != null) {
                      context.pushNamedAndRemoveUntil(AppRoutes.mainLayoutRoute,
                          predicate: (route) => false);
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state.isLoading;

                    return CustomElevatedButton(
                      title: LocaleKeys.login,
                      isLoading: isLoading,
                      onPressed: () {
                        _viewModel.signin();
                      },
                    );
                  },
                ),

                const SizedBox(height: AppSizes.spaceBetweenItems_16),

                OutlinedButton(
                  onPressed: () {
                    context.pushNamedAndRemoveUntil(
                        AppRoutes.mainLayoutRoute,
                        predicate: (route) => false
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(double.infinity, AppSizes.buttonHigh_48),
                  ),
                  child: Text(LocaleKeys.guest),
                ),

                const SizedBox(height: AppSizes.spaceBetweenItems_8),

                Center(
                  child: GestureDetector(
                    onTap: () => context.pushNamed(AppRoutes.signUpRoute),
                    child: RichText(
                      text: TextSpan(
                        text: LocaleKeys.dont_have_account,
                        style: theme.textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: LocaleKeys.sign_up,
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: theme.colorScheme.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
