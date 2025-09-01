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
          return OccasionProductsShimmer(
            isEnabled: true,
          );
        }
        if (state.productFailure != null) {
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
            child: Text(LocaleKeys.no_products.tr()),
          );
        }
        final products = state.productResponse!.products!;

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSizes.spaceBetwwenItems_16,
            mainAxisSpacing: AppSizes.spaceBetwwenItems_16,
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
            return ProductCard(
              title: product.title ?? '',
              imgCover: product.imgCover ?? '',
              price: product.price ?? 0,
              priceAfterDiscount: product.priceAfterDiscount ?? 0,
              discountPercent: discountPercent,
              onAddToCart: () {},
            );
          },
        );
      },
    );
  }
}
