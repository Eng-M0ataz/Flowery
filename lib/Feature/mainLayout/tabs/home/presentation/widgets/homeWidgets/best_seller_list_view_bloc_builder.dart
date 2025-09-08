import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/viewModel/home_state.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/viewModel/home_view_model.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/widgets/homeWidgets/best_seller_list_view.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/widgets/homeWidgets/list_views_shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BestSellerListViewBlocBuilder extends StatelessWidget {
  const BestSellerListViewBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeState>(
      builder: (context, state) {
        if (state.isBestSellerLoading) {
          return const ListViewsShimmerWidget();
        }
        if (state.bestSellerFailure != null) {
          return Center(
            child: Text(state.bestSellerFailure!.errorMessage),
          );
        }
        return BestSellerListView(
          bestSellerList: state.bestSellerList,
        );
      },
    );
  }
}
