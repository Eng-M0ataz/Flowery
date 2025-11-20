import 'package:flower_e_commerce_app/core/Widgets/search_list_tile.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/app_assets.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeLogoAndSearchField extends StatelessWidget {
  const HomeLogoAndSearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            Assets.assetsImagesLogo,
          ),
          const SizedBox(
            width: AppSizes.spaceBetweenItems_16,
          ),
          Expanded(
            child: SearchListTile(),
          ),
        ],
      ),
    );
  }
}
