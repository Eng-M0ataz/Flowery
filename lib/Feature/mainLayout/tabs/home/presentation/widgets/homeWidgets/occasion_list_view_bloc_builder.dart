import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/viewModel/home_state.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/viewModel/home_view_model.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/widgets/homeWidgets/list_views_shimmer_widget.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/widgets/homeWidgets/occasion_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OccasionListViewBlocBuilder extends StatelessWidget {
  const OccasionListViewBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeState>(
      builder: (context, state) {
        if (state.isOccasionLoading) {
          return const ListViewsShimmerWidget();
        }
        if (state.occasionFailure != null) {
          return Center(
            child: Text(
              state.occasionFailure!.errorMessage,
            ),
          );
        }
        return OccasionListView(
          occasionsList: state.occasionsList,
        );
      },
    );
  }
}
