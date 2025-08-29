import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../core/localization/locale_keys.g.dart';

class ResendText extends StatelessWidget {
  final bool isResendAvailable;

  const ResendText({super.key, required this.isResendAvailable});

  @override
  Widget build(BuildContext context) {
    return Text(LocaleKeys.resend.tr(),
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              decoration: TextDecoration.underline,
              color: isResendAvailable?   Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.onSurface ,
              decorationColor: Theme.of(context).colorScheme.primary,
            ));
  }
}
