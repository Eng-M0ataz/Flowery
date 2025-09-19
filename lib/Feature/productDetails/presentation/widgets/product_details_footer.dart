import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/Widgets/custom_elevated_button.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/models/product_details_model.dart';
import '../../../../core/utils/Constantts/sizes.dart';

class ProductDetailsFooter extends StatelessWidget {
  final ProductDetailsModel product;

  const ProductDetailsFooter({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "EGP ${product.price}",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              product.quantity! <= 0
                  ? Text(
                      "${LocaleKeys.out_stock.tr()} ",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface),
                    )
                  : Text(
                      "${LocaleKeys.in_stock.tr()} ",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface),
                    )
            ],
          ),
          const SizedBox(height: AppSizes.spaceBetweenItems_4),
          Text(
            LocaleKeys.all_prices_include_tax.tr(),
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: Colors.grey),
          ),

          SizedBox(height: AppSizes.spaceBetweenItems_12),

          Text("${product.title}",
              style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: AppSizes.spaceBetweenItems_16),

          // Description
          Text(LocaleKeys.description.tr(),
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: AppSizes.spaceBetweenItems_12),
          Text(
            "${product.description}",
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(fontWeight: FontWeight.normal),
          ),
          const SizedBox(height: AppSizes.spaceBetweenItems_12),
          CustomElevatedButton(
            widget: Text(LocaleKeys.add_to_cart.tr()),
            onPressed: () {
              //todo: implement add to cart use case
            },
            isLoading: false,
          ),
          const SizedBox(height: AppSizes.spaceBetweenItems_32),
        ],
      ),
    );
  }
}
