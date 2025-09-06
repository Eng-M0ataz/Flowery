import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/widgets/homeWidgets/custom_drop_down_button.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/app_assets.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_16),
      child: Row(
        children: [
          SvgPicture.asset(Assets.assetsImagesLocationIcon),
          const SizedBox(
            width: AppSizes.spaceBetweenItems_8,
          ),
          const CustomDropDownButton(),
        ],
      ),
    );
  }
}
