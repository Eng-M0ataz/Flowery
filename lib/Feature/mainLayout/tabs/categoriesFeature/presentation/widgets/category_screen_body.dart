import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/events/categories_event.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/states/categories_state.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/viewModel/categories_view_model.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/widgets/category_tabs.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/widgets/filter_button.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/widgets/filter_icon_button_of_app_bar.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/widgets/product_grid.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/widgets/search_bar_widget.dart';
import 'package:flower_e_commerce_app/core/helpers/dialogue_utils.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreenBody extends StatelessWidget {
  const CategoryScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocConsumer<CategoriesViewModel, CategoriesState>(
        listener: (context, state) {
          if (!state.isLoading && state.errorMessage != null) {
            DialogueUtils.showMessage(
              context: context,
              message: state.errorMessage!,
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSizes.paddingMd_16),
                child: SizedBox(
                  height: AppSizes.buttonHigh_48,
                  child: Row(
                    children: [
                      const Expanded(child: SearchBarWidget()),
                      const SizedBox(width: AppSizes.spaceBetweenItems_12),
                      FilterIconButtonOfAppBar(onTap: () {
                        //todo open filter bottom sheet
                      }),
                    ],
                  ),
                ),
              ),
              if (state.categoriesResponse != null)
                CategoryTabs(
                  categories: state.categoriesResponse!.categories ?? [],
                  selectedCategoryId: state.selectedCategoryId,
                  onCategorySelected: (categoryId) {
                    context.read<CategoriesViewModel>().doIntent(
                          GetCategoryProductsEvent(
                            categoryId: categoryId,
                          ),
                        );
                  },
                  isLoading: state.isLoading,
                ),
              Expanded(
                child: ProductGrid(
                  products: state.productsResponse?.products ?? [],
                  isLoading: state.isLoading,
                ),
              ),
            ],
          );
        },
      )),
      floatingActionButton: const FilterButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
