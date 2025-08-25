import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/viewModel/viewModel/event/signin_event.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/viewModel/viewModel/sign_in_view_model.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flower_e_commerce_app/core/Utils/constants/app_routes.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_elvated_button.dart';
import 'package:flower_e_commerce_app/core/helpers/dialogue_utils.dart';
import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/locale_keys.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final SigninViewModel _viewModel = getIt<SigninViewModel>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => getIt.get<SigninViewModel>(),
      child: Scaffold(
        body: BlocConsumer<SigninViewModel, SignInState>(
          listener: (context, state) {
            if (state.isSuccess) {
              context.pushNamed(AppRoutes.mainLayoutRoute);
            } else if (state.errorMessage != null) {
              DialogueUtils.showMessage(
                context: context,
                message: state.errorMessage!,
              );
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Theme(
                  data: ThemeData(
                    elevatedButtonTheme: ElevatedButtonThemeData(
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Colors.black),
                        backgroundColor: Theme
                            .of(context)
                            .colorScheme
                            .onPrimary,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingSm_8,
                      vertical: AppSizes.paddingMd_16,
                    ),
                    child: CustomElevatedButton(
                      loadingColor: Theme
                          .of(context)
                          .colorScheme
                          .primary,
                      textColor: Theme
                          .of(context)
                          .colorScheme
                          .onSurface,
                      isLoading: state.isGuestLoading,
                      title: LocaleKeys.continueString.tr(),
                      onPressed: () {
                        if (!state.isGuestLoading) {
                          context.read<SigninViewModel>().doIntent(IsGuestEvent());
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}