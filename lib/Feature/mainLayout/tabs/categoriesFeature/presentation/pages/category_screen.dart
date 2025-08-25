import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/events/categories_event.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/states/categories_state.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/viewModel/categories_view_model.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flower_e_commerce_app/core/helpers/dialogue_utils.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt.get<CategoriesViewModel>()..doIntent(GetAllCategoriesEvent()),
      child: BlocConsumer<CategoriesViewModel, CategoriesState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            DialogueUtils.showMessage(
                context: context, message: state.errorMessage!);
          }
        },
        builder: (context, state) {
          final viewModel = context.read<CategoriesViewModel>();

          return Scaffold(
            appBar: AppBar(
              leadingWidth: AppSizes.appBarLeadingWidth,
              title: const Text("Categories"),
            ),
            body: Builder(
              builder: (context) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.response != null) {
                  return ListView.builder(
                    itemCount: state.response!.categories.length,
                    itemBuilder: (context, index) {
                      final category = state.response!.categories[index];
                      return ListTile(
                        title: Text(category.name),
                        subtitle: Text("Products: ${category.productsCount}"),
                        leading: Image.network(category.image,
                            width: 40, height: 40),
                      );
                    },
                  );
                }
                return const Center(child: Text("No categories found"));
              },
            ),
          );
        },
      ),
    );
  }
}
