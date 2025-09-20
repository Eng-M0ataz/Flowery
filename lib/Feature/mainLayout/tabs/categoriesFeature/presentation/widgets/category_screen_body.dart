import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/events/categories_event.dart';

import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/states/categories_state.dart';

import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/viewModel/categories_view_model.dart';

import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/widgets/category_tabs.dart';

import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/widgets/filter_icon_button_of_app_bar.dart';

import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/widgets/product_grid.dart';

import 'package:flower_e_commerce_app/core/Widgets/search_list_tile.dart';

import 'package:flower_e_commerce_app/core/helpers/dialogue_utils.dart';

import 'package:flower_e_commerce_app/core/utils/Constants/app_constants.dart';

import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreenBody extends StatelessWidget {
  final String? initialCategoryId;

  const CategoryScreenBody({super.key, this.initialCategoryId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesViewModel, CategoriesState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          DialogueUtils.showMessage(
            context: context,
            message: state.errorMessage!,
          );
        }
      },
      builder: (context, state) {
        if (initialCategoryId != null &&
            state.productsList == null &&
            !state.isLoading) {
          context.read<CategoriesViewModel>().doIntent(
                GetProductsByCategoryEvent(categoryId: initialCategoryId!),
              );
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSizes.paddingMd_16),
              child: SizedBox(
                height: AppSizes.buttonHigh_48,
                child: Row(
                  children: [
                    const Expanded(child: SearchListTile()),
                    const SizedBox(width: AppSizes.spacingBetweenItems_12),
                    FilterIconButtonOfAppBar(onTap: () {
                      //todo open filter bottom sheet
                    }),
                  ],
                ),
              ),
            ),
            if (state.categories != null)
              CategoryTabs(
                categories: state.categories ?? [],
                selectedCategoryId: state.selectedCategoryId,
                onCategorySelected: (categoryId) {
                  if (categoryId == AppConstants.allId) {
                    context.read<CategoriesViewModel>().doIntent(
                          const GetAllProductsEvent(),
                        );
                  } else {
                    context.read<CategoriesViewModel>().doIntent(
                          GetProductsByCategoryEvent(
                            categoryId: categoryId,
                          ),
                        );
                  }
                },
                isLoading: state.isLoading,
              ),
            Expanded(
              child: ProductGrid(
                products: state.productsList!,
                isLoading: state.isLoading,
              ),
            ),
          ],
        );
      },
    );
  }
}
