import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/widgets/homeWidgets/best_seller_item.dart';
import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
import 'package:flower_e_commerce_app/core/models/product_details_model.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flower_e_commerce_app/core/utils/constants/app_routes.dart';
import 'package:flutter/material.dart';

import '../../../../../../bestSellerFeature/domain/entities/best_seller_entity.dart';

class BestSellerListView extends StatelessWidget {
  const BestSellerListView({
    super.key,
    required this.bestSellerList,
  });

  final List<BestSellerEntity> bestSellerList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.homeBestSellerListViewHigh,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_16),
        separatorBuilder: (context, index) => const SizedBox(
          width: AppSizes.spaceBetwwenItems_16,
        ),
        itemCount: bestSellerList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            final BestSellerEntity bestSeller = bestSellerList[index];
            context.pushNamed(
              AppRoutes.productDetailsRoute,
              arguments: ProductDetailsModel(
                quantity: bestSeller.quantity,
                id: bestSeller.Id,
                images: bestSeller.images,
                price: bestSeller.price,
                title: bestSeller.title,
                description: bestSeller.description,
              ),
            );
          },
          child: BestSellerItem(
            bestSellerEntity: bestSellerList[index],
          ),
        ),
      ),
    );
  }
}
