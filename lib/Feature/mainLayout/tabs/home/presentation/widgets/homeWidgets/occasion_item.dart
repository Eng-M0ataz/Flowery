import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/widgets/homeWidgets/custom_cached_network_image.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/occasion_entity.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';

class OccasionItem extends StatelessWidget {
  const OccasionItem({
    super.key,
    required this.occasionEntity,
  });
  final OccasionEntity occasionEntity;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomCachedNetworkImage(
          image: occasionEntity.image,
          imageHigh: AppSizes.homeOccasionImageHigh,
          imageWidth: AppSizes.homeOccasionImageWidth,
        ),
        const SizedBox(
          height: AppSizes.spaceBetweenItems_8,
        ),
        SizedBox(
          width: AppSizes.homeOccasionTextWidthConstrain,
          child: Text(
            occasionEntity.name,
            style: Theme.of(context).textTheme.titleSmall,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
