import 'package:flower_e_commerce_app/Feature/searchFeature/presentation/widgets/search_custom_text_field.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/presentation/widgets/search_product_grid_view_builder.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';

class SearchScreenBody extends StatelessWidget {
  const SearchScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(AppSizes.paddingMd_16),
      child: Column(
        children: [
          SearchCustomTextFormField(),
          SizedBox(height: AppSizes.spaceBetweenItems_12),
          Expanded(
            child: SearchProductsGridViewBlocBuilder(),
          )
        ],
      ),
    );
  }
}
