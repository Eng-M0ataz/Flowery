import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/occasion/presentation/widgets/tabs_bloc_builder.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/models/occasion_input_model.dart';
import '../../../../core/utils/Constants/sizes.dart';
import '../viewModels/occasion_event.dart';
import '../viewModels/occasion_view_model.dart';
import '../widgets/product_bloc_builder.dart';

class OccasionScreen extends StatelessWidget {
  OccasionScreen({super.key, required this.occasionInputModel});

  final OccasionInputModel occasionInputModel;
  final OccasionViewModel occasionViewModel = getIt<OccasionViewModel>();

  @override
  Widget build(BuildContext context) {

    return BlocProvider<OccasionViewModel>(
      create: (context) =>
      occasionViewModel
        ..doIntent(
            occasionId: occasionInputModel.occasionId, GetAllOccasionsEvent()),
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
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(
                        color: AppColorsLight.grey,
                      ),
                    )),
                const SizedBox(height: AppSizes.spaceBetweenItems_16),
                TabsBlocBuilder(initialIndex: occasionInputModel.index,),
                const SizedBox(height: AppSizes.spaceBetweenItems_32),
                Expanded(child: ProductBlocBuilder()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
