import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavBarItem extends StatelessWidget {
  const NavBarItem({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(image,
        height: AppSizes.mdIcon_24, width: AppSizes.mdIcon_24);
  }
}
