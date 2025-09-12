import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/Config/Theme/app_colors.dart';
import '../../../../core/utils/Constants/app_assets.dart';
import '../../../../core/utils/Constants/sizes.dart';

class PaymentMethodItem extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onSelect;
  final String title;

  const PaymentMethodItem(
      {super.key,
      required this.isSelected,
      required this.onSelect,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.paddingMd_16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg_12),
        border: Border.all(color: AppColorsLight.white[60]!, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          GestureDetector(
              onTap: onSelect,
              child: isSelected
                  ? SvgPicture.asset(Assets.selectedIcon)
                  : SvgPicture.asset(Assets.unselectedIcon)),
        ],
      ),
    );
  }
}
