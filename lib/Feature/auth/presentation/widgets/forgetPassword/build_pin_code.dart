import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../../../../../core/Config/Theme/app_colors.dart';
import '../../../../../core/Functions/validators.dart';

class BuildPinCode extends StatelessWidget {
  final TextEditingController controller;

  final void Function(String)? onCompleted;

  const BuildPinCode(
      {super.key, required this.controller, required this.onCompleted});

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: AppSizes.pinCodeLength_6,
      controller: controller,
      keyboardType: TextInputType.number,
      defaultPinTheme: PinTheme(
        width: AppSizes.pinCodeWidth_68,
        height: AppSizes.pinCodeHeight_74,
        textStyle: Theme.of(context).textTheme.titleLarge,
        decoration: BoxDecoration(
          color: AppColorsLight.black[10],
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg_12),
        ),
      ),
      onCompleted: onCompleted,
      validator: Validations.pinCodeValidator,
      errorPinTheme: PinTheme(
        width: AppSizes.pinCodeWidth_68,
        height: AppSizes.pinCodeHeight_74,
        textStyle: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Theme.of(context).colorScheme.error),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg_12),
          border: Border.all(
              color: Theme.of(context).colorScheme.error,
              width: AppSizes.pinCodeBorderWidth_2),
        ),
      ),
    );
  }
}
