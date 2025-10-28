import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/product_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/viewModel/categories_view_model.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/Widgets/product_card.dart';
import 'package:flower_e_commerce_app/core/Widgets/products_shimmer.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../viewModel/events/categories_event.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductEntity> products;
  final bool isLoading;
  final String productId;

  const ProductGrid({
    super.key,
    required this.products,
    required this.productId,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildShimmerGrid();
    }

    if (products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: AppSizes.lgIcon_64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: AppSizes.spaceBetweenSections_16),
            Text(
              LocaleKeys.no_products.tr(),
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: AppColorsLight.grey),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(AppSizes.paddingMd_16),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppSizes.spaceBetweenItems_16,
          mainAxisSpacing: AppSizes.spaceBetweenItems_16,
          childAspectRatio: 0.65,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          final bool isThisCardLoading = productId == product.id;

          return ProductCard(
            description: product.description ?? '',
            quantity: product.quantity ?? 0,
            id: product.id ?? '',
            isAddingToCart: isThisCardLoading,
            imgCover: product.imgCover ?? '',
            title: product.title ?? '',
            price: product.price?.toInt() ?? 0,
            images: product.images!,
            priceAfterDiscount: product.priceAfterDiscount?.toDouble() ?? 0,
            discountPercent: product.discountPercent,
            onAddToCart: product.quantity! <= 0
                ? null
                : () {
                    if (product.id != null) {
                      context.read<CategoriesViewModel>().doIntent(
                          AddProductToCartEvent(productId: product.id!));
                    }
                  },
          );
        },
      ),
    );
  }

  Widget _buildShimmerGrid() {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.paddingMd_16),
      child: const ProductsShimmer(
        isEnabled: true,
      ),
    );
  }
}
