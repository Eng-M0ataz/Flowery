import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Functions/filter.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_elevated_button.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  final FILTERTYPE? currentFilter;
  final Function(FILTERTYPE?) onFilterSelected;

  const FilterBottomSheet({
    super.key,
    this.currentFilter,
    required this.onFilterSelected,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  FILTERTYPE? selectedFilter;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    selectedFilter = widget.currentFilter;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.borderRadiusXl_20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingMd_16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: AppSizes.sizedBoxWidth_40,
                height: AppSizes.sizedBoxHeight_4,
                margin: const EdgeInsets.only(bottom: AppSizes.paddingMd_16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              LocaleKeys.sort_by.tr(),
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: AppSizes.spaceBetweenItems_16),
            _buildRadioFilterTile(
              context: context,
              title: LocaleKeys.lowest_price.tr(),
              filterType: FILTERTYPE.lowestPrice,
              icon: Icons.arrow_downward,
            ),
            const SizedBox(height: AppSizes.spaceBetweenItems_8),
            _buildRadioFilterTile(
              context: context,
              title: LocaleKeys.highest_Price.tr(),
              filterType: FILTERTYPE.highestPrice,
              icon: Icons.arrow_upward,
            ),
            const SizedBox(height: AppSizes.spaceBetweenItems_8),
            _buildRadioFilterTile(
              context: context,
              title: LocaleKeys.new_product.tr(),
              filterType: FILTERTYPE.newest,
              icon: Icons.new_releases,
            ),
            const SizedBox(height: AppSizes.spaceBetweenItems_8),
            _buildRadioFilterTile(
              context: context,
              title: LocaleKeys.old_product.tr(),
              filterType: FILTERTYPE.oldest,
              icon: Icons.history,
            ),
            const SizedBox(height: AppSizes.spaceBetweenItems_8),
            _buildRadioFilterTile(
              context: context,
              title: LocaleKeys.discount.tr(),
              filterType: FILTERTYPE.discount,
              icon: Icons.local_offer,
            ),
            const SizedBox(height: AppSizes.spaceBetweenItems_16),
            CustomElevatedButton(
              onPressed: _applyFilter,
              isLoading: isLoading,
              widget: Text(
                LocaleKeys.filter.tr(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioFilterTile({
    required BuildContext context,
    required String title,
    required FILTERTYPE? filterType,
    required IconData icon,
  }) {
    final isSelected = selectedFilter == filterType;

    return InkWell(
      onTap: () => _selectFilter(filterType),
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg_12),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingMd_16,
          vertical: AppSizes.paddingSm_12,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg_12),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: AppSizes.sizedBoxWidth_20,
              height: AppSizes.sizedBoxHeight_20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey[400]!,
                  width: 2,
                ),
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: AppSizes.sizedBoxWidth_8,
                        height: AppSizes.sizedBoxHeight_8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: AppSizes.spaceBetweenItems_12),
            Icon(
              icon,
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey[600],
              size: AppSizes.smIcon_16,
            ),
            const SizedBox(width: AppSizes.spaceBetweenItems_12),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).textTheme.titleMedium?.color,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectFilter(FILTERTYPE? filter) {
    setState(() {
      if (selectedFilter == filter) {
        selectedFilter = null;
      } else {
        selectedFilter = filter;
      }
    });
  }

  void _applyFilter() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 300));

    widget.onFilterSelected(selectedFilter);

    setState(() {
      isLoading = false;
    });

    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}
