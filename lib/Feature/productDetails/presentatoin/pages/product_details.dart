import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/product_entity.dart';
import 'package:flower_e_commerce_app/Feature/productDetails/presentatoin/viewModel/events/products_event.dart';
import 'package:flower_e_commerce_app/Feature/productDetails/presentatoin/viewModel/states/product_state.dart';
import 'package:flower_e_commerce_app/Feature/productDetails/presentatoin/viewModel/viewModel/viewModel.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/locale_keys.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_elvated_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProductDetailsViewModel>()
        ..doIntent(LoadImagesEvent(product.images), context),
      child: Scaffold(
        body: BlocBuilder<ProductDetailsViewModel, ProductDetailsState>(
          builder: (context, state) {
            switch (state.status) {
              case ProductDetailsStatus.loading:
                return const Center(child: CircularProgressIndicator());

              case ProductDetailsStatus.error:
                return Center(child: Text(state.errorMessage ?? "Error"));

              case ProductDetailsStatus.success:
                return SafeArea(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: AppSizes.productImageHeight,
                            width: double.infinity,
                            child: PageView.builder(
                              itemCount: product.images?.length ?? 0,
                              onPageChanged: (index) {
                                context
                                    .read<ProductDetailsViewModel>()
                                    .doIntent(ChangeImageEvent(index), context);
                              },
                              itemBuilder: (context, index) {
                                return Image.network(
                                  product.images![index],
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                          Positioned(
                            top: AppSizes.spaceBetweenSections_16,
                            left: AppSizes.spaceBetweenSections_16,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back_ios),
                              onPressed: () => context.pop(),
                            ),
                          ),
                          Positioned(
                            bottom: AppSizes.spaceBetweenSections_16,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                product.images?.length ?? 0,
                                (index) => Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  width: AppSizes.indectatorWidth,
                                  height: AppSizes.indectatorHeight,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: state.currentIndex == index
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(AppSizes.paddingMd_16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onPrimary,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(
                                    AppSizes.borderRadiusXxl_24)),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "EGP ${product.price}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${LocaleKeys.Status.tr()}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface),
                                        ),
                                        Text(
                                          ": ${(product.quantity ?? 0) > 0 ? LocaleKeys.inStock.tr() : LocaleKeys.outStock.tr()}",
                                          style:  Theme.of(context)
                                              .textTheme
                                              .labelLarge
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppSizes.spaceBetweenItems_4),
                                Text(
                                  "${LocaleKeys.price_with_tax.tr()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                      color: Colors.grey
                                  ),
                                ),
                                const SizedBox(
                                    height: AppSizes.spaceBetweenSections_12),

                                Text(
                                  "${product.title}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                ),
                                const SizedBox(height: AppSizes.spaceBetweenItems_16),

                                // Description
                                Text(
                                  "${LocaleKeys.Description.tr()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!.copyWith(
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                                const SizedBox(
                                    height: AppSizes.spaceBetweenSections_12),
                                Text(
                                  "${product.description}",
                                  style:  Theme.of(context)
                                      .textTheme
                                      .labelLarge!.copyWith(
                                    fontWeight: FontWeight.normal

                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppSizes.paddingMd_16),
                        child: CustomElevatedButton(
                          onPressed: () {
                            // TODO: Add to cart logic
                          },
                          isLoading: false,
                          title: LocaleKeys.addToCart.tr(),
                        ),
                      )
                    ],
                  ),
                );
              case ProductDetailsStatus.initial:
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
