import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Functions/snack_bar.dart';
import 'package:flower_e_commerce_app/core/Widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Widgets/products_shimmer.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/utils/Constantts/sizes.dart';
import '../viewModels/occasion_event.dart';
import '../viewModels/occasion_state.dart';
import '../viewModels/occasion_view_model.dart';

class ProductBlocBuilder extends StatelessWidget {
  const ProductBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OccasionViewModel, OccasionState>(
      listenWhen: (pre, cur) =>
          pre.addToCartResponse != cur.addToCartResponse ||
          pre.addToCartFailure != cur.addToCartFailure,
      listener: (context, state) {
        if (state.addToCartResponse != null) {
          return showSnackBar(
            context: context,
            textStyle: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.onPrimary),
            message: 'product added successfully',
          );
        } else if (state.addToCartFailure != null &&
            state.addToCartResponse == null) {
          showSnackBar(
            context: context,
            message: state.addToCartFailure!.errorMessage,
            textStyle: Theme.of(context).textTheme.bodyMedium!,
          );
        }
      },
      builder: (context, state) {
        if (state.isProductLoading) {
          return ProductsShimmer(
            isEnabled: true,
          );
        }
        if (state.productFailure != null && state.productResponse == null) {
          final occasionId =
              state.occasionResponse?.occasions?.isNotEmpty == true
                  ? state.occasionResponse!.occasions!.first.id ?? ''
                  : '';
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(state.productFailure?.errorMessage ?? ''),
                const SizedBox(height: AppSizes.paddingMd_16),
                TextButton(
                    onPressed: () {
                      context.read<OccasionViewModel>().doIntent(
                          LoadProductsByOccasionEvent(occasionId: occasionId));
                    },
                    child: Text(LocaleKeys.retry.tr())),
              ],
            ),
          );
        }

        if (state.productResponse?.products?.isEmpty ?? true) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                  color: Theme.of(context).primaryColor,
                  size: 100,
                ),
                Text(LocaleKeys.no_products.tr()),
              ],
            ),
          );
        }
        final products = state.productResponse!.products!;

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSizes.spaceBetweenItems_16,
            mainAxisSpacing: AppSizes.spaceBetweenItems_16,
            childAspectRatio: 0.65,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            final discountPercent = (product.price != null &&
                    product.price! > 0)
                ? ((1 - ((product.priceAfterDiscount ?? 0) / product.price!)) *
                        100)
                    .round()
                : 0;
            final bool isThisCardLoading = state.productId == product.id;
            return ProductCard(
              images: products[index].images!,
              priceAfterDiscount: product.priceAfterDiscount!.toDouble(),
              description: product.description ?? '',
              quantity: product.quantity ?? 0,
              id: product.id ?? '',
              title: product.title ?? '',
              imgCover: product.imgCover ?? '',
              price: product.price ?? 0,
              discountPercent: discountPercent,
              isAddingToCart: isThisCardLoading,
              onAddToCart: product.quantity! <= 0?
                  null
                 : () {
                if (product.id != null) {
                  context
                      .read<OccasionViewModel>()
                      .doIntent(AddProductToCartEvent(productId: product.id!));
                }
              },
            );
          },
        );
      },
    );
  }
}
