import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/viewModel/forgetPassword/forget_password_states.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/widgets/forgetPassword/handle_state.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_app_bar.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewModel/forgetPassword/forget_password_view_model.dart';
import '../widgets/forgetPassword/form/forget_password_form.dart';
import '../widgets/forgetPassword/form/reset_password_form.dart';
import '../widgets/forgetPassword/form/verification_code_form.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late ForgetPasswordViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<ForgetPasswordViewModel>();
  }

  @override
  void dispose() {
    _viewModel;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _viewModel,
      child: BlocConsumer<ForgetPasswordViewModel, ForgetPasswordState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          handleState(
              context: context,
              status: state.status,
              successMessage: _viewModel.getSuccessMessage(state),
              errorMessage: state.failure?.errorMessage ?? '',
              onSuccess: () => _viewModel.handleSuccessNavigation(
                  context, state, _viewModel.pageController));
        },
        builder: (context, state) {
          return Scaffold(
            appBar: CustomBackButton(title: LocaleKeys.password.tr()),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_16),
                child: PageView(
                  controller: _viewModel.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    ForgetPasswordForm(),
                    VerificationCodeForm(),
                    ResetPasswordForm(),
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
