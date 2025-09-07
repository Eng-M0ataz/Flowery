import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/events/categories_event.dart';

import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/viewModel/categories_view_model.dart';

import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/widgets/category_screen_body.dart';

import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/widgets/filter_button.dart';

import 'package:flower_e_commerce_app/core/Di/di.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String? CategoryIdFromHome =
        ModalRoute.of(context)?.settings.arguments as String?;

    return BlocProvider(
      create: (context) {
        final viewModel = getIt<CategoriesViewModel>();

        viewModel.doIntent(const GetAllCategoriesEvent());

        if (CategoryIdFromHome != null) {
          viewModel.doIntent(
              GetProductsByCategoryEvent(categoryId: CategoryIdFromHome));
        } else {
          viewModel.doIntent(const GetAllProductsEvent());
        }

        return viewModel;
      },
      child: Scaffold(
        body: SafeArea(
          child: CategoryScreenBody(
            initialCategoryId: CategoryIdFromHome,
          ),
        ),
        floatingActionButton: FilterButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
