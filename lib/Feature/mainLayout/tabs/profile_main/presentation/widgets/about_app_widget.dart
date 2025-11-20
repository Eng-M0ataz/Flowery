import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api/models/about_app_model.dart';
import '../viewModels/profileViewModel/profile_main_event.dart';
import '../viewModels/profileViewModel/profile_main_state.dart';
import '../viewModels/profileViewModel/profile_main_view_model.dart';

class AboutAppWidget extends StatefulWidget {
  const AboutAppWidget({super.key});

  @override
  State<AboutAppWidget> createState() => _AboutAppWidgetState();
}

class _AboutAppWidgetState extends State<AboutAppWidget> {
  late final ProfileMainViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<ProfileMainViewModel>();
    _viewModel.doIntend(GetAboutAppEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _viewModel,
      child: BlocBuilder<ProfileMainViewModel, ProfileMainState>(
        builder: (context, state) {
          final AboutAppModel? aboutApp = state.aboutApp;
          if (aboutApp == null || aboutApp.aboutApp.isEmpty) {
            return const Center(child: Text('No data available.'));
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('About Us'),
              scrolledUnderElevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: aboutApp.aboutApp.length,
                itemBuilder: (context, index) {
                  final section = aboutApp.aboutApp[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (section.title != null)
                          Text(
                            section.title!.en,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        const SizedBox(height: 4),
                        ...section.content.en.map(
                          (content) => Text(content),
                        ),
                        const Divider(),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
