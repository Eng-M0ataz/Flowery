import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flutter/material.dart';

import '../../../../../core/helpers/dialogue_utils.dart';
import '../../../../../core/utils/Constants/app_constants.dart';

void handleState<T>({
  required BuildContext context,
  required T status,
  required String successMessage,
  required String errorMessage,
  VoidCallback? onSuccess,
  VoidCallback? onError,
}) {
  if (status.toString().contains(AppConstants.error)) {
    DialogueUtils.showMessage(
      context: context,
      message: errorMessage,
      title: LocaleKeys.error.tr(),
      posActionName: LocaleKeys.ok.tr(),
      posAction:  onError
    );
  } else if (status.toString().contains(AppConstants.success)) {
    DialogueUtils.showMessage(
      context: context,
      message: successMessage,
      title: LocaleKeys.success.tr(),
      posActionName: LocaleKeys.ok.tr(),
      posAction:onSuccess
    );
  }
}
