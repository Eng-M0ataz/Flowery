import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/category_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/widgets/homeWidgets/categorie_item.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../categoriesFeature/domain/entities/category_entity.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({
    super.key,
    required this.categoriesList,
  });

  final List<CategoryEntity> categoriesList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.homeCategoriesListViewHigh,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_16),
        separatorBuilder: (context, index) => const SizedBox(
          width: AppSizes.spaceBetweenItems_16,
        ),
        itemCount: categoriesList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => CategorieItem(
          categoryEntity: categoriesList[index],
        ),
      ),
    );
  }
}
