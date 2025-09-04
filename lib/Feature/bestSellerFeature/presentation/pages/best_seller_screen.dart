import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/presentation/viewModel/best_seller_state.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flower_e_commerce_app/core/Functions/snack_bar.dart';
import 'package:flower_e_commerce_app/core/Widgets/list_views_shimmer_widget.dart';
import 'package:flower_e_commerce_app/core/helpers/dialogue_utils.dart';
import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../core/Widgets/custom_product_card.dart';
import '../viewModel/best_seller_event.dart';
import '../viewModel/best_seller_model_view.dart';

class BestSellerScreen extends StatefulWidget {
  const BestSellerScreen({super.key});

  @override
  State<BestSellerScreen> createState() => _BestSellerScreenState();
}

class _BestSellerScreenState extends State<BestSellerScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<BestSellerViewModel>()..doIntent(GetAllBestSellersEvent()),
      child: BlocConsumer<BestSellerViewModel, BestSellerState>(
          listener: (context, state){
            if(state.errorMessage != null){
              DialogueUtils.showMessage(
                  context: context,
                  message: state.errorMessage!
              );
            }
          },
          builder: (context, state){

            return Scaffold(
              appBar: AppBar(
                leading: GestureDetector(
                  onTap: context.pop,
                  child: const Icon(Icons.arrow_back_ios),
                ),
                title: Text(LocaleKeys.best_seller.tr()),
              ),
              body: Padding(
                padding: const EdgeInsets.all(AppSizes.paddingMd_12),
                child: state.isLoading
                    ? ListViewsShimmerWidget(isCategorie: false,)
                    : state.bestSellers == null
                    ? const Center(child: Text('No products found'))
                    : ResponsiveGridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: ResponsiveGridDelegate(
                        crossAxisExtent: 163,
                        maxCrossAxisExtent: 6,
                        minCrossAxisExtent: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.7117903930131004,

                      // childAspectRatio: 1, // Adjust for your card design
                    ),
                    itemCount: state.bestSellers!.bestSeller!.length,
                    itemBuilder: (context, index) {
                    final product = state.bestSellers!.bestSeller![index];

                    if(product.discount == null || product.discount == 0){
                      product.priceAfterDiscount = product.price;
                    } else {
                      product.priceAfterDiscount = (product.price! - (product.price! * product.discount! / 100)) as double?;
                    }

                    return ProductCard(
                      imgCover: product.imgCover!,
                      title: product.title ?? '[Title]',
                      price: product.price ?? 0,
                      priceAfterDiscount: product.priceAfterDiscount ?? 0,
                      discountPercent: product.discount ?? 0,
                      onAddToCart: () {
                        showSnackBar(
                            message: 'added to cart!',
                            context: context,
                            textStyle: Theme.of(context).textTheme.bodySmall!.copyWith()
                        );
                      },
                    );
                  },
                ),
              ),
            );
          },
      ),
    );
  }
}
