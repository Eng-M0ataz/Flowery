import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/viewModel/home_events.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/viewModel/home_view_model.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/widgets/homeWidgets/best_seller_list_view_bloc_builder.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/widgets/homeWidgets/categories_list_view_bloc_builder.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/widgets/homeWidgets/home_logo_and_search_field.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/widgets/homeWidgets/occasion_list_view_bloc_builder.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/widgets/homeWidgets/section_header.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/app_routes.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/models/occasion_input_model.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

late HomeViewModel _homeViewModel;

class _HomeScreenBodyState extends State<HomeScreenBody> {
  @override
  void initState() {
    _homeViewModel = getIt<HomeViewModel>();
    _homeViewModel.doIntent(GetAllHomeEvent());
    super.initState();
  }

  @override
  void dispose() {
    _homeViewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _homeViewModel,
      child: Column(
        children: [
          const SizedBox(
            height: AppSizes.spaceBetweenItems_16,
          ),
          const HomeLogoAndSearchField(),
          const SizedBox(
            height: AppSizes.spaceBetweenItems_24,
          ),
          SectionHeader(
            title: LocaleKeys.categories.tr(),
            onTap: () {
              context.pushNamed(AppRoutes.categoriesRoute);
            },
          ),
          const SizedBox(
            height: AppSizes.spaceBetweenItems_16,
          ),
          const CategoriesListViewBlocBuilder(),
          const SizedBox(
            height: AppSizes.spaceBetweenItems_24,
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                SectionHeader(
                  title: LocaleKeys.best_seller.tr(),
                  onTap: () {
                    context.pushNamed(AppRoutes.bestSellerRoute);
                  },
                ),
                const SizedBox(
                  height: AppSizes.spaceBetweenItems_16,
                ),
                const BestSellerListViewBlocBuilder(),
                const SizedBox(
                  height: AppSizes.spaceBetweenItems_24,
                ),
                SectionHeader(
                  title: LocaleKeys.occasions.tr(),
                  onTap: () {
                    context.pushNamed(
                      AppRoutes.occasionRoute,
                      arguments: OccasionInputModel(
                        occasionId: "673b34c21159920171827ae0",
                        index: 0,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: AppSizes.spaceBetweenItems_16,
                ),
                const OccasionListViewBlocBuilder(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
