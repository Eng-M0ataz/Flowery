import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/presentation/viewModel/search_state.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/presentation/viewModel/search_view_model.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/presentation/widgets/search_products_grid_view.dart';
import 'package:flower_e_commerce_app/core/Widgets/products_shimmer.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchProductsGridViewBlocBuilder extends StatelessWidget {
  const SearchProductsGridViewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchViewModel, SearchState>(
      builder: (context, state) {
        if (state.isLoading) {
          return ProductsShimmer(isEnabled: true);
        }
        if (state.failure != null) {
          return Center(
            child: Text(state.failure!.errorMessage),
          );
        }
        if (state.searchResults == null) {
          return Center(
            child: Text(LocaleKeys.search_for_any_product_you_want.tr(),
                style: Theme.of(context).textTheme.titleSmall!),
          );
        }
        if (state.searchResults!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                  size: 100,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  height: AppSizes.spaceBetweenItems_16,
                ),
                Text(
                  LocaleKeys.no_products_found_for_your_search.tr(),
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(),
                ),
              ],
            ),
          );
        }

        return SearchProductsGridView(
          products: state.searchResults!,
        );
      },
    );
  }
}
