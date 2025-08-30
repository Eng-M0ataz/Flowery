import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imgCover;
  final String title;
  final int price;
  final int priceAfterDiscount;
  final int discountPercent;
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.imgCover,
    required this.title,
    required this.price,
    required this.priceAfterDiscount,
    required this.onAddToCart,
    required this.discountPercent,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd_8),
        side: BorderSide(color:   AppColorsLight.grey),
      ),
      elevation: AppSizes.cardElevation_0,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingSm_8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(AppSizes.paddingSm_8),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColorsLight.white,
              ),
              child: CachedNetworkImage(
                errorWidget: (context, url, error) => Icon(
                    Icons.error,
                  color: Theme.of(context).colorScheme.primary,
                ),
                fit: BoxFit.cover,
                imageUrl: imgCover,
              ),
            ),
            const SizedBox(height: AppSizes.spaceBetweenItems_4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_12),
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
                maxLines: AppSizes.maxLines_1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: AppSizes.spaceBetweenItems_8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_12),
              child: Row(
                children: [
                Text(
                  "${LocaleKeys.currency.tr()} $priceAfterDiscount",
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(width: AppSizes.spaceBetweenItems_12),
                Text("$price",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                    )),
                const SizedBox(width: AppSizes.spaceBetweenItems_12),
                Text("$discountPercent%",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.green,
                    )),
              ]),
            ),
            SizedBox(height: AppSizes.spaceBetweenItems_8),
            SizedBox(
                width: double.infinity,
                height: AppSizes.sizedBoxHeight_30,
                child: ElevatedButton(
                    onPressed: onAddToCart,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        const SizedBox(width: AppSizes.spaceBetweenItems_2),
                        Text(
                          LocaleKeys.addToCart.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                              color:
                              Theme.of(context).colorScheme.onPrimary,
                              fontSize: AppSizes.xxsFont_10),
                        ),
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}