import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/Constantts/app_assets.dart';
import 'nav_bar_item.dart';

class CustomButtonNavBar extends StatelessWidget {
  const CustomButtonNavBar({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });

  final void Function(int)? onTap;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColorsLight.white[60]!, width: 1),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            icon: NavBarItem(image: Assets.assetsImagesHomeUnselected),
            activeIcon: NavBarItem(image: Assets.assetsImagesHomeSelected),
            label: LocaleKeys.home.tr(),
          ),
          BottomNavigationBarItem(
            icon:
                const NavBarItem(image: Assets.assetsImagesCategoryUnselected),
            activeIcon: const NavBarItem(
              image: Assets.assetsImagesCategorySelected,
            ),
            label: LocaleKeys.category.tr(),
          ),
          BottomNavigationBarItem(
            icon: const NavBarItem(
                image: Assets.assetsImagesShoppingCartUnselected),
            activeIcon: const NavBarItem(
              image: Assets.assetsImagesShoppingCartSelected,
            ),
            label: LocaleKeys.cart.tr(),
          ),
          BottomNavigationBarItem(
            icon: const NavBarItem(image: Assets.assetsImagesPersonUnselected),
            activeIcon: const NavBarItem(
              image: Assets.assetsImagesPersonSelected,
            ),
            label: LocaleKeys.profile.tr(),
          ),
        ],
      ),
    );
  }
}
