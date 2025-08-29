import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/widgets/homeWidgets/best_seller_list_view_bloc_builder.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/widgets/homeWidgets/categories_list_view_bloc_builder.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/widgets/homeWidgets/home_logo_and_search_field.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/widgets/homeWidgets/location_widget.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/widgets/homeWidgets/occasion_list_view_bloc_builder.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/widgets/homeWidgets/section_header.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: AppSizes.spaceBetwwenItems_16,
        ),
        const HomeLogoAndSearchField(),
        const LocationWidget(),
        SectionHeader(
          title: LocaleKeys.categories.tr(),
          onTap: () {},
        ),
        const SizedBox(
          height: AppSizes.spaceBetwwenItems_16,
        ),
        const CategoriesListViewBlocBuilder(),
        const SizedBox(
          height: AppSizes.spaceBetwwenItems_24,
        ),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SectionHeader(
                title: LocaleKeys.best_seller.tr(),
                onTap: () {},
              ),
              const SizedBox(
                height: AppSizes.spaceBetwwenItems_16,
              ),
              const BestSellerListViewBlocBuilder(),
              const SizedBox(
                height: AppSizes.spaceBetwwenItems_24,
              ),
              SectionHeader(
                title: LocaleKeys.occasions.tr(),
                onTap: () {},
              ),
              const SizedBox(
                height: AppSizes.spaceBetwwenItems_16,
              ),
              const OccasionListViewBlocBuilder(),
            ],
          ),
        ),
      ],
    );
  }
}
