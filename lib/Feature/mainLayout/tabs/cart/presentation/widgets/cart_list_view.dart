import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/domain/entity/cart_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/widgets/cart_item.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';

class CartListView extends StatelessWidget {
  const CartListView({
    super.key,
    required this.cartEntity,
    required this.loadingProducts,
  });
  final CartEntity cartEntity;
  final Map<String, bool>? loadingProducts;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: cartEntity.products.length,
      itemBuilder: (context, index) {
        final product = cartEntity.products[index];
        final isLoading = loadingProducts?[product.productId] ?? false;

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMd_16,
          ),
          child: CartItem(cartItemEntity: product, loadingProducts: isLoading),
        );
      },
      separatorBuilder: (context, index) =>
          SizedBox(height: AppSizes.spaceBetweenItems_24),
    );
  }
}
