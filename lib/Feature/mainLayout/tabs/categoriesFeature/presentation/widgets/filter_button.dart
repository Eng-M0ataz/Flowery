import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/widgets/filter_bottom_sheet.dart';
import 'package:flower_e_commerce_app/core/Functions/filter.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final FilterType? currentFilter;
  final Function(FilterType?) onFilterChanged;

  const FilterButton({
    super.key,
    this.currentFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: AppSizes.buttonHigh_36,
      child: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppSizes.borderRadiusXl_20),
              ),
            ),
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => FilterBottomSheet(
              currentFilter: currentFilter,
              onFilterSelected: onFilterChanged,
            ),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 4,
        icon: Stack(
          children: [
            Icon(
              Icons.tune,
              color: Theme.of(context).colorScheme.onPrimary,
              size: AppSizes.mdIcon_24,
            ),
          ],
        ),
        label: Text(
          LocaleKeys.filter.tr(),
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }
}