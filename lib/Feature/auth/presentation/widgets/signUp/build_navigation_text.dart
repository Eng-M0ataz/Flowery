import 'package:flower_e_commerce_app/core/Config/Theme/app_theme.dart';
import 'package:flutter/material.dart';

class BuildNavigationText extends StatelessWidget {
  final String firstText;
  final String secondText;
  final String routeName;

  const BuildNavigationText(
      {super.key,
      required this.firstText,
      required this.secondText,
      required this.routeName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(firstText,
            style: AppThemeLight.lightTheme.textTheme.headlineLarge),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: const Size(0, 0),
          ),
          onPressed: () {
            Navigator.pushNamed(context, routeName);
          },
          child: Text(
            secondText,
            style: AppThemeLight.lightTheme.textTheme.headlineLarge!.copyWith(
              decoration: TextDecoration.underline,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
