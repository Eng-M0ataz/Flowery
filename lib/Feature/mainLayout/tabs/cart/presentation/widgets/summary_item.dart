import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem({
    super.key,
    required this.text,
    required this.price,
    this.isTotal = false,
  });
  final String text;
  final String price;
  final bool isTotal;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: isTotal
                ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: AppSizes.mdFont_16,
                      fontWeight: FontWeight.w600,
                    )
                : Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: AppSizes.mdFont_16,
                      color: AppColorsLight.grey,
                    ),
          ),
          Text(
            price,
            style: isTotal
                ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: AppSizes.mdFont_16,
                      fontWeight: FontWeight.w600,
                    )
                : Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: AppSizes.mdFont_16,
                      color: AppColorsLight.grey,
                    ),
          ),
        ],
      ),
    );
  }
}
