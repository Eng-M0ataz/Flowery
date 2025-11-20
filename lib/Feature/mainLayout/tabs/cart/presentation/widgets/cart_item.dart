import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/domain/entity/cart_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/viewModel/cart_cubit.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/viewModel/cart_events.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.cartItemEntity,
    required this.loadingProducts,
  });
  final CartProductEntity cartItemEntity;
  final bool loadingProducts;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.all(AppSizes.paddingSm_8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd_8),
        border: Border.all(color: AppColorsLight.grey),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd_8),
            child: CachedNetworkImage(
              imageUrl: cartItemEntity.productImage!,
              width: AppSizes.cartImageWidth,
              height: AppSizes.cartImageHigh,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(width: AppSizes.spaceBetweenItems_8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        cartItemEntity.productName!,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<CartCubit>().doIntent(
                              ClearSpecificCartItemEvent(),
                              productId: cartItemEntity.productId!,
                            );
                      },
                      child: Icon(Icons.delete, color: AppColorsLight.red),
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.spaceBetweenItems_4),
                Text(
                  cartItemEntity.productName!,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall!.copyWith(color: AppColorsLight.grey),
                ),
                SizedBox(height: AppSizes.spaceBetweenItems_24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${LocaleKeys.currency.tr()} ${cartItemEntity.productPrice!.toString()}',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Row(
                      spacing: AppSizes.spaceBetweenItems_8,
                      children: [
                        GestureDetector(
                          onTap: loadingProducts
                              ? null
                              : () {
                                  context.read<CartCubit>().doIntent(
                                        UpdateCartProductQuantityEvent(),
                                        productId: cartItemEntity.productId!,
                                        quantity: cartItemEntity.quantity!,
                                        isIncrement: false,
                                      );
                                },
                          child: Icon(Icons.remove),
                        ),
                        loadingProducts
                            ? SizedBox(
                                height: AppSizes
                                    .cartAddAndRemoveCircleLoadingIndicatorHigh,
                                width: AppSizes
                                    .cartAddAndRemoveCircleLoadingIndicatorWidth,
                                child: CircularProgressIndicator(
                                  strokeWidth: AppSizes
                                      .cartAddAndRemoveCircleLoadingIndicatorStrokeWidth,
                                ),
                              )
                            : Text(
                                cartItemEntity.quantity.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                        GestureDetector(
                          onTap: loadingProducts
                              ? null
                              : () {
                                  context.read<CartCubit>().doIntent(
                                        UpdateCartProductQuantityEvent(),
                                        productId: cartItemEntity.productId!,
                                        quantity: cartItemEntity.quantity!,
                                        isIncrement: true,
                                      );
                                },
                          child: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
