import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/events/categories_event.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/states/categories_state.dart';

import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/viewModel/categories_view_model.dart';

import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/widgets/category_screen_body.dart';

import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/widgets/filter_button.dart';

import 'package:flower_e_commerce_app/core/Di/di.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({
    this.CategoryIdFromHome,
    super.key,
  });

  final String? CategoryIdFromHome;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late final CategoriesViewModel _viewModel;

  @override
  initState() {
    _viewModel = getIt<CategoriesViewModel>();
    _viewModel.doIntent(const GetAllCategoriesEvent());
    if (widget.CategoryIdFromHome != null) {
      _viewModel.doIntent(
          GetProductsByCategoryEvent(categoryId: widget.CategoryIdFromHome!));
    } else {
      _viewModel.doIntent(const GetAllProductsEvent());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _viewModel,
      child: Scaffold(
        body: SafeArea(
          child: CategoryScreenBody(
            initialCategoryId: widget.CategoryIdFromHome,
          ),
        ),
        floatingActionButton: BlocBuilder<CategoriesViewModel, CategoriesState>(
            builder: (context, state) {
          return FilterButton(
            currentFilter: state.currentFilter,
            onFilterChanged: (filterType) {
              context
                  .read<CategoriesViewModel>()
                  .doIntent(ApplyFilterEvent(filterType));
            },
          );
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
