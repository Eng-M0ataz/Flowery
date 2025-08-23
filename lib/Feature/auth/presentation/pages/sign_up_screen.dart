import 'package:flower_e_commerce_app/Feature/auth/presentation/viewModel/viewModel/signup_view_model.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/widgets/signUp/form/sign_up_form.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<SignupViewModel>(),
      child: Scaffold(
        body: Center(
          child: SignUpForm(),
        ),
      ),

    );
  }
}
