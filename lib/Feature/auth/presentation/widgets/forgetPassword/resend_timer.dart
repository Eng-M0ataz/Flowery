import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

import '../../../../../core/utils/Constants/app_constants.dart';

class ResendTimer extends StatelessWidget {
  final void Function()? onEnd;
  const ResendTimer({super.key, required this.onEnd});

  @override
  Widget build(BuildContext context) {
    return TimerCountdown(
      format: CountDownTimerFormat.minutesSeconds,
      endTime: DateTime.now().add(
        const Duration(minutes: AppConstants.resendDuration),
      ),
      timeTextStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
      colonsTextStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
      enableDescriptions: false,
      spacerWidth: 0,
      onEnd: onEnd,
    );
  }
}
