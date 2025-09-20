import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/presentation/viewModel/search_events.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/presentation/viewModel/search_view_model.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/app_assets.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SearchCustomTextFormField extends StatelessWidget {
  const SearchCustomTextFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) => context
          .read<SearchViewModel>()
          .doIntent(SearchProductsEvent(), value),
      controller: context.read<SearchViewModel>().searchController,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            context.read<SearchViewModel>().searchController.clear();
          },
          icon: SvgPicture.asset(Assets.assetsImagesCloseCircle),
        ),
        hintStyle: Theme.of(context)
            .textTheme
            .displayMedium!
            .copyWith(color: AppColorsLight.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd_8),
          borderSide: const BorderSide(color: AppColorsLight.grey),
        ),
        contentPadding: const EdgeInsets.all(AppSizes.paddingXs_4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusXxl_24),
          borderSide: BorderSide.none,
        ),
        hintText: LocaleKeys.search.tr(),
        prefixIcon: SvgPicture.asset(
          Assets.assetsImagesSearch,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
