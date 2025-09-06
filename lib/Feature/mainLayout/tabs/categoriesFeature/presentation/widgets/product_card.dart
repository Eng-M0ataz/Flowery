import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/product_entity.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/Functions/snack_bar.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/app_assets.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/app_constants.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppSizes.borderRadiusXl_16,
        ),
        border: Border.all(
          color: AppColorsLight.white[70]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(AppSizes.paddingSm_8),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd_8),
                color: AppColorsLight.white,
              ),
              child: _buildProductImage(),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.paddingMd_12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title ?? LocaleKeys.no_products.tr(),
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColorsLight.black[80],
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.spaceBetweenItems_4),
                  _buildPriceRow(context),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: AppSizes.buttonHigh_30,
                    child: ElevatedButton.icon(
                      onPressed: () => _handleAddToCart(context),
                      icon: const Icon(
                        Icons.shopping_cart,
                        size: AppSizes.smIcon_16,
                        color: AppColorsLight.white,
                      ),
                      label: Text(
                        LocaleKeys.add_to_cart.tr(),
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: AppColorsLight.white,
                                ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    final imageUrl = product.imgCover ?? Assets.noImage;

    if (imageUrl.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: AppColorsLight.white[50],
          child: const Center(
            child: CircularProgressIndicator(
              color: AppColorsLight.pink,
            ),
          ),
        ),
        errorWidget: (context, url, error) {
          return _buildPlaceholderImage();
        },
      );
    }

    return _buildPlaceholderImage();
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: AppColorsLight.white[70],
      child: const Icon(
        Icons.image,
        size: AppSizes.lgIcon_32,
        color: AppColorsLight.grey,
      ),
    );
  }

  Widget _buildPriceRow(BuildContext context) {
    final priceAfterDiscount =
        product.priceAfterDiscount ?? product.price ?? 0.0;
    final originalPrice = product.price ?? 0.0;

    int discountPercentage = 0;
    if (originalPrice > 0 &&
        priceAfterDiscount > 0 &&
        originalPrice > priceAfterDiscount) {
      discountPercentage =
          (((originalPrice - priceAfterDiscount) / originalPrice) * 100)
              .round();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            '${LocaleKeys.currency.tr()} ${priceAfterDiscount.toInt()}',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColorsLight.black[80],
                ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (discountPercentage > 0) ...[
          const SizedBox(width: AppSizes.spaceBetweenItems_8),
          Text(
            '${originalPrice.toInt()}',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 12,
                  color: AppColorsLight.grey,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: AppColorsLight.grey,
                  decorationThickness: 1.2,
                ),
          ),
          const SizedBox(width: AppSizes.spaceBetweenItems_8),
          Text(
            '$discountPercentage%',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 12,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ],
    );
  }

  void _handleAddToCart(BuildContext context) {
    final productName = product.title ?? AppConstants.noProduct;
    showSnackBar(
      message: '$productName ${LocaleKeys.add_to_cart.tr()}',
      context: context,
      textStyle: Theme.of(context)
          .textTheme
          .headlineSmall!
          .copyWith(color: AppColorsLight.white),
      duration: const Duration(seconds: 2),
      backgroundColor: AppColorsLight.green,
    );
  }
}
