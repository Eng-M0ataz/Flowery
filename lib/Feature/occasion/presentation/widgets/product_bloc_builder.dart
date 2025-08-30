import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/occasion/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/utils/Constants/sizes.dart';
import '../viewModels/occasion_event.dart';
import '../viewModels/occasion_state.dart';
import '../viewModels/occasion_view_model.dart';
import 'shimmer/occasion_products_shimmer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBlocBuilder extends StatelessWidget {
  const ProductBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OccasionViewModel, OccasionState>(
      builder: (context, state) {
        if (state.isProductLoading) {
          return const OccasionProductsShimmer(isEnabled: true,);
        }
        if (state.productFailure != null) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(state.productFailure?.errorMessage ?? ''),
                const SizedBox(height: AppSizes.paddingMd_16),
                TextButton(
                    onPressed: () {
                      context.read<OccasionViewModel>().doIntent(
                          LoadProductsByOccasionEvent(
                              occasionId:
                                  state.occasionResponse!.occasions.first.id));
                    },
                    child: Text(LocaleKeys.resend.tr())),
              ],
            ),
          );
        }

        if (state.productResponse == null || state.productResponse!.products.isEmpty) {
          return Center(child: Text(LocaleKeys.no_products.tr()),);
        }

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSizes.spaceBetweenItems_16,
            mainAxisSpacing: AppSizes.spaceBetweenItems_16,
            childAspectRatio: 0.65,
          ),
          itemCount: state.productResponse!.products.length,
          itemBuilder: (context, index) {
            final product = state.productResponse!.products[index];
            return ProductCard(
              title: product.title,
              imgCover: product.imgCover,
              price: product.price,
              priceAfterDiscount: product.priceAfterDiscount,
              discountPercent:
                  ((1 - (product.priceAfterDiscount / product.price)) * 100)
                      .round(),
              onAddToCart: () {},
            );
          },
        );
      },
    );
  }
}
