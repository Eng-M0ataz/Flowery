import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, this.onTap, required this.title});
  final VoidCallback? onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    final thmeData = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap ?? context.pop,
          child: Icon(Icons.arrow_back_ios, size: 20),
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
