import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/viewModel/home_events.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/viewModel/home_view_model.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/widgets/homeWidgets/home_screen_body.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) =>
              getIt.get<HomeViewModel>()..doIntent(GetAllHomeEvent()),
          child: HomeScreenBody(),
        ),
      ),
    );
  }
}
