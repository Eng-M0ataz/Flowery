import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/app_assets.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/Config/Theme/app_colors.dart';
import '../../../../core/localization/locale_keys.g.dart';

class AddressItem extends StatelessWidget {
  final String addressTitle;
  final bool isSelected;
  final VoidCallback onSelect;

  const AddressItem(
      {super.key,
      required this.addressTitle,
      required this.isSelected,
      required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.paddingMd_16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg_12),
          border: Border.all(color: AppColorsLight.white[60]!, width: 2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: onSelect,
                      child: isSelected
                          ? SvgPicture.asset(Assets.selectedIcon)
                          : SvgPicture.asset(Assets.unselectedIcon)),
                  SizedBox(
                    width: AppSizes.spaceBetweenItems_8,
                  ),
                  Text(
                    LocaleKeys.home.tr(),
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
              SizedBox(
                height: AppSizes.spaceBetweenItems_16,
              ),
              Text(
                addressTitle,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: AppColorsLight.grey),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              //todo navigate to edit address screen
            },
            child: Icon(
              Icons.edit_outlined,
              color: AppColorsLight.grey,
              size: AppSizes.mdIcon_24,
            ),
          ),
        ],
      ),
    );
  }
}
