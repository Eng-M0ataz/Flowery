import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/viewModel/forgetPassword/forget_password_states.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/widgets/forgetPassword/handle_state.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewModel/forgetPassword/forget_password_view_model.dart';
import '../widgets/forgetPassword/form/forget_password_form.dart';
import '../widgets/forgetPassword/form/reset_password_form.dart';
import '../widgets/forgetPassword/form/verification_code_form.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final ForgetPasswordViewModel viewModel = getIt<ForgetPasswordViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocConsumer<ForgetPasswordViewModel, ForgetPasswordState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          handleState(
              context: context,
              status: state.status,
              successMessage: viewModel.getSuccessMessage(state),
              errorMessage: state.errorMsg ?? LocaleKeys.unexpectedError.tr(),
              onSuccess: () => viewModel.handleSuccessNavigation(
                  context, state, viewModel.pageController));
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: PageView(
                controller: viewModel.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  ForgetPasswordForm(),
                  VerificationCodeForm(),
                  ResetPasswordForm(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
