import 'package:easy_localization/easy_localization.dart';
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
    return SizedBox(
      height: AppSizes.cardHeight_229,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd_8),
          side: BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
        elevation: AppSizes.cardElevation_0,
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingSm_8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: AppSizes.paddingMd_10.toInt(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd_8),
                  child: Image.network(
                    imgCover,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBetweenItems_8),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
                maxLines: AppSizes.maxLines_1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSizes.spaceBetweenItems_2),
              Row(children: [
                Text(
                  "${LocaleKeys.currency_egp.tr()} $priceAfterDiscount",
                  style: Theme.of(context).textTheme.displayLarge,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(width: AppSizes.spaceBetweenItems_2),
                Text("$price",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                    )),
                const SizedBox(width: AppSizes.spaceBetweenItems_2),
                Text("$discountPercent%",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.green,
                    )),
              ]),
              const Spacer(),
              SizedBox(
                  width: double.infinity,
                  height: AppSizes.sizedBoxHeight_30,
                  child: ElevatedButton(
                      onPressed: onAddToCart,
                      child: Row(
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
      ),
    );
  }
}