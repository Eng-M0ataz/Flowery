import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/utils/Constantts/sizes.dart';
import '../viewModels/occasion_event.dart';
import '../viewModels/occasion_state.dart';
import '../viewModels/occasion_view_model.dart';
import 'build_tab_bar.dart';
import 'shimmer/occasion_tabs_shimmer.dart';

class TabsBlocBuilder extends StatelessWidget {
  final int initialIndex;

  const TabsBlocBuilder({super.key, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OccasionViewModel, OccasionState>(
      builder: (context, state) {
        if (state.isOccasionLoading) {
          return Center(child: OccasionTabsShimmer());
        } else if (state.occasionFailure != null) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(state.occasionFailure?.errorMessage ?? ''),
                const SizedBox(height: AppSizes.spaceBetweenItems_16),
                TextButton(
                    onPressed: () {
                      context
                          .read<OccasionViewModel>()
                          .doIntent(GetAllOccasionsEvent(
                            occasionId: '673b34c21159920171827ae0',
                          ));
                    },
                    child: Text(LocaleKeys.retry.tr())),
              ],
            ),
          );
        }
        if (state.occasionResponse == null ||
            state.occasionResponse!.occasions!.isEmpty) {
          return SizedBox.shrink();
        }
        final occasions = state.occasionResponse!.occasions!;
        return BuildTabBar(
          initialIndex: initialIndex,
          tabsLength: occasions.length,
          taps: occasions.map((occasion) => Tab(text: occasion.name)).toList(),
          onTap: (index) {
            context.read<OccasionViewModel>().doIntent(
                  LoadProductsByOccasionEvent(occasionId: occasions[index].id!),
                );
          },
        );
      },
    );
  }
}
