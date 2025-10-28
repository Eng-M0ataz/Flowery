import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/presentation/viewModel/best_seller_state.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flower_e_commerce_app/core/Functions/snack_bar.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_app_bar.dart';
import 'package:flower_e_commerce_app/core/Widgets/products_shimmer.dart';
import 'package:flower_e_commerce_app/core/helpers/dialogue_utils.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Widgets/product_card.dart';
import '../viewModel/best_seller_event.dart';
import '../viewModel/best_seller_model_view.dart';

class BestSellerScreen extends StatefulWidget {
  const BestSellerScreen({super.key});

  @override
  State<BestSellerScreen> createState() => _BestSellerScreenState();
}

class _BestSellerScreenState extends State<BestSellerScreen> {
  late final BestSellerViewModel _viewModel;

  @override
  void initState() {
    _viewModel = getIt.get<BestSellerViewModel>();
    _viewModel.doIntent(GetAllBestSellersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _viewModel,
      child: BlocConsumer<BestSellerViewModel, BestSellerState>(
        listenWhen: (pre, cur) =>
            pre.addToCartResponse != cur.addToCartResponse ||
            pre.addToCartFailure != cur.addToCartFailure,
        listener: (context, state) {
          if (state.bestSellerFailure != null) {
            DialogueUtils.showMessage(
              context: context,
              message: state.bestSellerFailure!.errorMessage,
            );
          }

          if (state.addToCartResponse != null) {
            showSnackBar(
              context: context,
              message: 'Product added successfully',
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onPrimary),
            );
          }

          if (state.addToCartFailure != null &&
              state.addToCartResponse == null) {
            showSnackBar(
              context: context,
              message: state.addToCartFailure!.errorMessage,
              textStyle: Theme.of(context).textTheme.bodyMedium!,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: CustomBackButton(title: LocaleKeys.best_seller.tr()),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 36),
                  child: Text(LocaleKeys.best_sellers.tr(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColorsLight.grey,
                            fontSize: AppSizes.mdFont_16,
                          )),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSizes.paddingMd_12),
                    child: state.isLoading
                        ? ProductsShimmer(
                            isEnabled: true,
                          )
                        : state.bestSellers == null
                            ? const Center(child: Text('No products found'))
                            : GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                cacheExtent: 500,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing:
                                      AppSizes.spaceBetweenItems_16,
                                  mainAxisSpacing:
                                      AppSizes.spaceBetweenItems_16,
                                  childAspectRatio: 0.68,
                                ),
                                itemCount:
                                    state.bestSellers!.bestSeller!.length,
                                itemBuilder: (context, index) {
                                  final product =
                                      state.bestSellers!.bestSeller![index];
                                  final bool isThisCardLoading =
                                      state.selectedBestSellerId == product.Id;

                                  return ProductCard(
                                    description: product.description ?? '',
                                    images: product.images!,
                                    quantity: product.quantity ?? 0,
                                    id: product.Id ?? '',
                                    priceAfterDiscount:
                                        product.priceAfterDiscount!.toDouble(),
                                    price: product.price ?? 0,
                                    imgCover: product.imgCover ?? '',
                                    title: product.title ?? '[Title]',
                                    discountPercent: product.discountPercent,
                                    isAddingToCart: isThisCardLoading,
                                    onAddToCart: product.quantity! <= 0?
                                    null
                                        : () {
                                      if (product.Id != null) {
                                        context
                                            .read<BestSellerViewModel>()
                                            .doIntent(
                                              AddProductToCartEvent(
                                                productId: product.Id!,
                                              ),
                                            );
                                      }
                                    },
                                  );
                                },
                              ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
