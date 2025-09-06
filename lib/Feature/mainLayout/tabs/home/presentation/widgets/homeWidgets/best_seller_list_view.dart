import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/widgets/homeWidgets/best_seller_item.dart';
import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';

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
          onTap: () => context.pushNamed('routenameHere',
              arguments: bestSellerList[index]),
          child: BestSallerItem(
            bestSellerEntity: bestSellerList[index],
          ),
        ),
      ),
    );
  }
}
