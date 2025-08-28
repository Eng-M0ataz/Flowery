import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';

import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
    required this.title,
  });
  final void Function()? onPressed;
  final bool isLoading;
  final String title;

  @override
  Widget build(BuildContext context) {
    final thmeData = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onPressed ?? context.pop,
          child: const Padding(
            padding: EdgeInsets.only(left: AppSizes.paddingMd_12),
            child: Icon(Icons.arrow_back_ios, size: 20),
          ),
        ),
        Text(
          title,
          style: thmeData.textTheme.bodySmall!.copyWith(
            color: thmeData.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
