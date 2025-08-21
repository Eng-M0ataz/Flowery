import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/utils/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class BuildElevatedButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  final bool isLoading;
  BuildElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
        onPressed:onPressed,
        isLoading: isLoading,
        title: text);
  }
}
