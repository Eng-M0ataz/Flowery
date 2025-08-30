import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/widgets/homeWidgets/best_seller_item.dart';
import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../../bestSellerFeature/domain/entities/best_seller_entity.dart';

class BestSallerListView extends StatelessWidget {
  const BestSallerListView({
    super.key,
    required this.bestSallerList,
  });

  final List<BestSellerEntity> bestSallerList;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.homeBestSellerListViewHigh,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_16),
        separatorBuilder: (context, index) => const SizedBox(
          width: AppSizes.spaceBetweenItems_16,
        ),
        itemCount: bestSallerList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => context.pushNamed('routenameHere',
              arguments: bestSallerList[index]),
          child: BestSallerItem(
            bestSellerEntity: bestSallerList[index],
          ),
        ),
      ),
    );
  }
}
