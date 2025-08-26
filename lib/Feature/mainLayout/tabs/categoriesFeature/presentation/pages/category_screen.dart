//UI For Test Only ^_^
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
                if (state.categoriesResponse != null) {
                  return ListView.builder(
                    itemCount: state.categoriesResponse!.categories.length,
                    itemBuilder: (context, index) {
                      final category =
                          state.categoriesResponse!.categories[index];

                      return ExpansionTile(
                        leading: Image.network(category.image,
                            width: 40, height: 40),
                        title: Text(category.name),
                        subtitle: Text("Products: ${category.productsCount}"),
                        children: [
                          BlocProvider.value(
                            value: viewModel,
                            child: BlocBuilder<CategoriesViewModel,
                                CategoriesState>(
                              builder: (context, innerState) {
                                if (innerState.productsResponse != null &&
                                    innerState.selectedCategoryId ==
                                        category.id) {
                                  return SizedBox(
                                    height: 200,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: innerState.productsResponse!
                                              .products?.length ??
                                          0,
                                      itemBuilder: (context, productIndex) {
                                        final product = innerState
                                            .productsResponse!
                                            .products![productIndex];
                                        return Card(
                                          margin: const EdgeInsets.all(8),
                                          child: Column(
                                            children: [
                                              Image.network(
                                                  product.imgCover ?? "",
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.cover),
                                              Text(product.title ?? "",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text("${product.price ?? 0} EGP"),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }

                                return TextButton(
                                  onPressed: () {
                                    viewModel.doIntent(GetCategoryProductsEvent(
                                        categoryId: category.id,
                                        limit: 10,
                                        page: 1));
                                  },
                                  child: const Text("Show Products"),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          );
        },
      ),
    );
  }
}
