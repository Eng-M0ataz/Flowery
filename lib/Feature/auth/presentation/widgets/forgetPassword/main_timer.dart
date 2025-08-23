import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import '../../../../../core/helpers/dialogue_utils.dart';
import '../../../../../core/localization/locale_keys.g.dart';
import '../../../../../core/utils/Constants/app_constants.dart';

class MainTimer extends StatelessWidget {
  const MainTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return TimerCountdown(
      format: CountDownTimerFormat.minutesSeconds,
      endTime: DateTime.now().add(const Duration(minutes: AppConstants.mainDuration)),
      timeTextStyle: Theme.of(context).textTheme.headlineLarge,
      colonsTextStyle:
      Theme.of(context).textTheme.headlineLarge,
      enableDescriptions: false,
      spacerWidth: AppSizes.spacerWidth_0,
      onEnd: () {
        DialogueUtils.showMessage(
          context: context,
          message: LocaleKeys.resetCodeInvalidOrExpired.tr(),
          posActionName: LocaleKeys.ok.tr(),
          title: LocaleKeys.error.tr(),
        );
      },
    );
  }
}
