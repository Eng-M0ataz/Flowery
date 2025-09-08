import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/widgets/homeWidgets/custom_cached_network_image.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../../bestSellerFeature/domain/entities/best_seller_entity.dart';

class BestSellerItem extends StatelessWidget {
  const BestSellerItem({
    super.key,
    required this.bestSellerEntity,
  });
  final BestSellerEntity bestSellerEntity;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomCachedNetworkImage(
          image: bestSellerEntity.imgCover!,
          imageHigh: AppSizes.homeBestSellerImageHigh,
          imageWidth: AppSizes.homeBestSellerImageWidth,
        ),
        const SizedBox(
          height: AppSizes.spaceBetweenItems_8,
        ),
        SizedBox(
          width: AppSizes.homeBestSellerTextWidthConstrain,
          child: Text(
            bestSellerEntity.title!,
            style: Theme.of(context).textTheme.labelMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(
          height: AppSizes.spaceBetweenItems_4,
        ),
        Text(
          '${bestSellerEntity.price.toString()} ${LocaleKeys.egp.tr()}',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}
