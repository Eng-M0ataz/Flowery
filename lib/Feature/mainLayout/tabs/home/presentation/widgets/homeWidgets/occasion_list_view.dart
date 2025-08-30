import 'package:flower_e_commerce_app/Feature/mainLayout/domain/entities/occasion_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/widgets/homeWidgets/occasion_item.dart';
import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/app_routes.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';

class OccasionListView extends StatelessWidget {
  const OccasionListView({
    super.key,
    required this.occasionsList,
  });

  final List<OccasionEntity> occasionsList;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.homeOccasionListViewHigh,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingMd_16,
        ),
        separatorBuilder: (context, index) => const SizedBox(
          width: AppSizes.spaceBetwwenItems_16,
        ),
        itemCount: occasionsList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => context.pushNamed(AppRoutes.occasionRoute,
              arguments: occasionsList[index].id),
          child: OccasionItem(
            occasionEntity: occasionsList[index],
          ),
        ),
      ),
    );
  }
}
