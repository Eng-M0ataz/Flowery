import 'package:flower_e_commerce_app/Feature/auth/presentation/viewModel/states/sign_in_state.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/viewModel/viewModel/sign_in_view_model.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_theme.dart';
import 'package:flower_e_commerce_app/core/Utils/constants/app_routes.dart';
import 'package:flower_e_commerce_app/core/helpers/regex.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import '../../../../core/Di/di.dart';
import '../../../../core/Widgets/custom_app_bar.dart';
import '../../../../core/helpers/dialogue_utils.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final SigninViewModel _viewModel = getIt<SigninViewModel>();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

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
                SizedBox(height: AppSizes.spaceBetweenSections_16),
                const CustomBackButton(title: LocaleKeys.Login),
                const SizedBox(height: AppSizes.spaceBetweenSections_16),

                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Email
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          label: Text(LocaleKeys.Email,
                              style: theme.textTheme.bodyMedium),
                          hintText: LocaleKeys.EmailHint,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return LocaleKeys.EmailRequired;
                          }
                          if (!AppRegExp.isEmailValid(value)) {
                            return LocaleKeys.EmailInvalid;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppSizes.spaceBetweenSections_16),

                      // Password
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          label: Text(LocaleKeys.Password,
                              style: theme.textTheme.bodyMedium),
                          hintText: LocaleKeys.PasswordHint,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return LocaleKeys.PasswordRequired;
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: AppSizes.spaceBetweenSections_16),

                      // Remember me & Forget password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                onChanged: (val) {
                                  setState(() {
                                    _rememberMe = val ?? false;
                                  });
                                },
                              ),
                              Text(LocaleKeys.Remember_me),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigate to Forget Password
                              context.pushNamed(AppRoutes.forgetPasswordRoute);
                            },
                            child: Text(
                              LocaleKeys.Forget_password,
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

                const SizedBox(height: AppSizes.spaceBetweenSections_16),

                // Bloc Consumer for Login Action
                BlocConsumer<SigninViewModel, SignInState>(
                  bloc: _viewModel,
                  listener: (context, state) {
                    if (state.failure != null) {
                      DialogueUtils.showMessage(
                        context: context,
                        title: LocaleKeys.Error,
                        message: state.failure?.errorMessage ?? "error",
                        posActionName: LocaleKeys.OK,
                      );
                    }
                    if (state.response != null) {
                      // Navigate to Home Screen or Dashboard
                      context.pushNamedAndRemoveUntil(AppRoutes.mainLayoutRoute,
                          predicate: (route) => false);
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state.isLoading;

                    return CustomElevatedButton(
                      title: LocaleKeys.Login,
                      isLoading: isLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<SigninViewModel>().signin(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                        }
                      },
                    );
                  },
                ),

                const SizedBox(height: AppSizes.spaceBetweenSections_16),

                // Continue as guest button
                OutlinedButton(
                  onPressed: () {
                    context.pushNamedAndRemoveUntil(AppRoutes.mainLayoutRoute,
                        predicate: (route) => false); // Navigate as guest
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(double.infinity, AppSizes.buttonHigh_48),
                  ),
                  child: Text(LocaleKeys.guest),
                ),

                const SizedBox(height: AppSizes.spaceBetweenItems_8),

                // Sign up link
                Center(
                  child: GestureDetector(
                    onTap: () => context.pushNamed(AppRoutes.signUpRoute),
                    child: RichText(
                      text: TextSpan(
                        text: LocaleKeys.Do_not_have_an_account,
                        style: theme.textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: LocaleKeys.Sign_up,
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
