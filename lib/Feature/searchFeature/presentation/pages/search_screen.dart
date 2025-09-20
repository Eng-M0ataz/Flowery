import 'package:flower_e_commerce_app/Feature/searchFeature/presentation/viewModel/search_view_model.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/presentation/widgets/search_screen_body.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => getIt.get<SearchViewModel>(),
          child: SearchScreenBody(),
        ),
      ),
    );
  }
}
