import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/termAndConditions/presention/viewModel/terms_and_conditions_event.dart';
import 'package:flower_e_commerce_app/Feature/termAndConditions/presention/viewModel/terms_and_conditions_state.dart';
import 'package:flower_e_commerce_app/Feature/termAndConditions/presention/viewModel/terms_and_conditions_view_model.dart';
import 'package:flower_e_commerce_app/core/di/di.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;

    return BlocProvider(
      create: (_) =>
      getIt<TermsAndConditionsViewModel>()..doIntent(LoadLocalTermsAndConditionsEvent(locale)),
      child: BlocBuilder<TermsAndConditionsViewModel, TermsAndConditionsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state.error != null) {
            return Scaffold(
              body: Center(child: Text('Error: ${state.error}')),
            );
          }
          return Scaffold(
            appBar: AppBar(title: Text(LocaleKeys.termsAndConditions.tr())),
            body: ListView.builder(
              itemCount: state.sections.length,
              itemBuilder: (ctx, i) {
                final s = state.sections[i];
                return Container(
                  color: s.contentStyle.backgroundColor,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (s.title != null)
                        Text(
                          s.title!,
                          style: TextStyle(
                            fontSize: s.titleStyle.fontSize,
                            fontWeight: s.titleStyle.fontWeight,
                            color: s.titleStyle.color,
                          ),
                          textAlign: s.titleStyle.textAlign,
                        ),
                      ...s.content.map((c) => Text(
                        c.toString(),
                        style: TextStyle(
                          fontSize: s.contentStyle.fontSize,
                          fontWeight: s.contentStyle.fontWeight,
                          color: s.contentStyle.color,
                        ),
                        textAlign: s.contentStyle.textAlign,
                      )),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
