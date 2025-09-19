import 'package:flower_e_commerce_app/Feature/searchFeature/presentation/viewModel/search_view_model.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/presentation/widgets/search_custom_text_field.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/presentation/widgets/search_product_grid_view_builder.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreenBody extends StatefulWidget {
  const SearchScreenBody({super.key});

  @override
  State<SearchScreenBody> createState() => _SearchScreenBodyState();
}

class _SearchScreenBodyState extends State<SearchScreenBody> {
  late SearchViewModel viewModel;
  @override
  void initState() {
    viewModel = getIt.get<SearchViewModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: Padding(
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
      ),
    );
  }
}
