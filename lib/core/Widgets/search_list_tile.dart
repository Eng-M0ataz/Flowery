import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/app_routes.dart';
import 'package:flutter/material.dart';

class SearchListTile extends StatelessWidget {
  const SearchListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.pushNamed(AppRoutes.searchRoute);
      },
      minTileHeight: 36,
      horizontalTitleGap: AppSizes.spaceBetweenItems_4,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingSm_8,
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: AppColorsLight.white[70]!,
        ),
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd_8),
      ),
      iconColor: AppColorsLight.grey,
      leading: Icon(Icons.search, color: AppColorsLight.white[70]!),
      title: Text(
        'Search',
        style: Theme.of(context).textTheme.displayMedium!.copyWith(
              color: AppColorsLight.white[70]!,
            ),
      ),
    );
  }
}
