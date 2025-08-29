import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/occasion/presentation/widgets/tabs_bloc_builder.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/utils/Constants/sizes.dart';
import '../viewModels/occasion_event.dart';
import '../viewModels/occasion_view_model.dart';
import '../widgets/product_bloc_builder.dart';

class OccasionScreen extends StatelessWidget {
  const OccasionScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider<OccasionViewModel>(
      create: (context) =>
          getIt<OccasionViewModel>()
            ..doIntent(GetAllOccasionsEvent(occasionId: '673b34c21159920171827ae0')),
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.occasion.tr()),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingMd_16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(left: AppSizes.paddingLg_24),
                    child: Text(
                      LocaleKeys.best_sellers.tr(),
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColorsLight.gray,
                          ),
                    )),
                const SizedBox(height: AppSizes.paddingMd_16),
                TabsBlocBuilder(),
                const SizedBox(height: AppSizes.paddingXl_32),
                Expanded(child: ProductBlocBuilder()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
