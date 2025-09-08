import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/category_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/widgets/homeWidgets/custom_cached_network_image.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.categoryEntity,
    required this.itemIndex
  });
  final CategoryEntity categoryEntity;
  final int itemIndex;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: AppSizes.homeCategoriesImageContainerWidth,
          height: AppSizes.homeCategoriesImageContainerHigh,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColorsLight.lightPink,
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusXl_20),
          ),
          child: CustomCachedNetworkImage(
            image: categoryEntity.image!,
            imageWidth: AppSizes.homeCategoriesImageWidth,
            imageHigh: AppSizes.homeCategoriesImageHigh,
          ),
        ),
        const SizedBox(
          height: AppSizes.spaceBetweenItems_8,
        ),
        SizedBox(
          width: AppSizes.homeCategoriesTextWidthConstrain,
          child: Text(
            categoryEntity.name!,
            style: Theme.of(context).textTheme.displayMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
