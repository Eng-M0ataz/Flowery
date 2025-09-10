import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_elevated_button.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import '../Config/Theme/app_colors.dart';

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
    return Container(
      padding: EdgeInsets.all(AppSizes.paddingSm_8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(
          AppSizes.borderRadiusMd_8,
        ),
        border: Border.all(color: AppColorsLight.white[70]!),
      ),
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: imgCover,
            height: AppSizes.clipHeight_155,
            width: AppSizes.clipWidth_163,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) =>
                Icon(Icons.error, color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: AppSizes.spaceBetweenItems_8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
              maxLines: AppSizes.maxLines_1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: AppSizes.spaceBetweenItems_4),
          SizedBox(
            width: 147,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(children: [
                Text(
                  "${LocaleKeys.currency_egp.tr()} $priceAfterDiscount",
                  style: Theme.of(context).textTheme.displayLarge,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(width: AppSizes.spaceBetweenItems_8),
                Text(
                  "$price",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(width: AppSizes.spaceBetweenItems_8),
                Text(
                  "$discountPercent%",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.green,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ]),
            ),
          ),
          const SizedBox(height: AppSizes.spaceBetweenItems_8),
          SizedBox(
            height: AppSizes.sizedBoxHeight_30,
            child: CustomElevatedButton(
              onPressed: onAddToCart,
              isLoading: false,
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  const SizedBox(width: AppSizes.spaceBetweenItems_2),
                  Text(
                    LocaleKeys.add_to_cart.tr(),
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: AppSizes.xxsFont_10),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
