import 'package:flower_e_commerce_app/Feature/searchFeature/domain/entities/search_peoduct_entity.dart';
import 'package:flower_e_commerce_app/core/Functions/calculate_product_discount_percent.dart';
import 'package:flower_e_commerce_app/core/Widgets/product_card.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';

class SearchProductsGridView extends StatelessWidget {
  const SearchProductsGridView({
    super.key,
    required this.products,
  });
  final List<SearchProductEntity> products;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSizes.paddingMd_16,
        mainAxisSpacing: AppSizes.paddingMd_16,
        childAspectRatio: 163 / 229,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(
          description: products[index].description!,
          images: products[index].images!,
          quantity: products[index].quantity!,
          id: products[index].id!,
          imgCover: products[index].imgCover!,
          title: products[index].title!,
          price: products[index].price!,
          priceAfterDiscount: products[index].priceAfterDiscount!.toDouble(),
          onAddToCart: () {
            // toDo : add to cart Function
          },
          discountPercent: calculateDiscountPercent(
              price: products[index].price!,
              priceAfterDiscount: products[index].priceAfterDiscount!),
        );
      },
    );
  }
}
