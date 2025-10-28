import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_elevated_button.dart';
import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/models/product_details_model.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/app_routes.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';

import '../Config/Theme/app_colors.dart';

class ProductCard extends StatelessWidget {
  final String imgCover;
  final String title;
  final int price;
  final double priceAfterDiscount;
  final int discountPercent;
  final VoidCallback? onAddToCart;
  final bool isAddingToCart;
  final String description;
  final List<String> images;
  final int quantity;
  final String id;

  const ProductCard({
    super.key,
    required this.imgCover,
    required this.title,
    required this.price,
    required this.priceAfterDiscount,
    required this.onAddToCart,
    required this.discountPercent,
    this.isAddingToCart = false,
    required this.description,
    required this.images,
    required this.quantity,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed(AppRoutes.productDetailsRoute,
          arguments: ProductDetailsModel(
            imageCover: imgCover,
            priceAfterDiscount: priceAfterDiscount,
            id: id,
            price: price,
            title: title,
            description: description,
            images: images,
            quantity: quantity,
          )),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd_8),
          border: Border.all(color: AppColorsLight.white[70]!),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  imageUrl: imgCover,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Icon(Icons.error,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSizes.paddingSm_8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.spaceBetweenItems_4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${LocaleKeys.currency_egp.tr()} $priceAfterDiscount",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.center,
                          child: Text(
                            "$price",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerRight,
                          child: Text(
                            "$discountPercent%",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  color: Colors.green,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spaceBetweenItems_8),
                  CustomElevatedButton(
                    containerHeight: AppSizes.buttonHigh_30,
                    onPressed: onAddToCart,
                    isLoading: isAddingToCart,
                    widget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: AppSizes.smIcon_16,
                        ),
                        const SizedBox(width: AppSizes.spaceBetweenItems_2),
                        Text(
                          LocaleKeys.add_to_cart.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: AppSizes.xxsFont_10,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
