import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/category_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/widgets/shimmer/category_shimmer_widget.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';

class CategoryTabs extends StatelessWidget {
  final List<CategoryEntity> categories;
  final String? selectedCategoryId;
  final Function(String) onCategorySelected;
  final bool isLoading;

  const CategoryTabs({
    Key? key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategorySelected,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading && categories.isEmpty) {
      return CategoryShimmerWidget();
    }

    if (categories.isEmpty) {
      return Center(
        child: Text(LocaleKeys.no_categories.tr()),
      );
    }

    return Container(
      height: AppSizes.spaceBetweenItems_50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            final isSelected = selectedCategoryId == 'all';
            return _buildCategoryTab(
                categoryId: 'all',
                categoryName: LocaleKeys.all.tr(),
                isSelected: isSelected,
                context: context);
          }

          final category = categories[index - 1];
          final isSelected = selectedCategoryId == category.id;

          return _buildCategoryTab(
            categoryId: category.id,
            categoryName: category.name,
            isSelected: isSelected,
            context: context,
          );
        },
      ),
    );
  }

  Widget _buildCategoryTab({
    required String categoryId,
    required String categoryName,
    required bool isSelected,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () => onCategorySelected(categoryId),
      child: Container(
        margin: const EdgeInsets.only(right: AppSizes.paddingLg_24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(categoryName,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 16,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected
                          ? AppColorsLight.pink
                          : AppColorsLight.white[70],
                    )),
            const SizedBox(height: AppSizes.spaceBetweenItems_8),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                color:
                    isSelected ? AppColorsLight.pink : AppColorsLight.white[70],
              ),
              height: 3,
              width: (categoryName.length * 8).toDouble(),
            ),
          ],
        ),
      ),
    );
  }
}
