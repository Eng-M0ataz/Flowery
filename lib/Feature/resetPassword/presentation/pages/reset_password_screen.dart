
import 'package:flutter/material.dart';
import '../../../../core/Widgets/custom_app_bar.dart';
import '../widgets/reset_password_screen_body.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackButton(title: 'Reset Password'),
      body: const ResetPasswordScreenBody(),
    );
  }
}
