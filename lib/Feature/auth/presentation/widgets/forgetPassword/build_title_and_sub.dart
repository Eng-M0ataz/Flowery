import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';

class BuildTitleAndSub extends StatelessWidget {
  final String title;
  final String subTitle;

  const BuildTitleAndSub(
      {super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: Theme.of(context).textTheme.displaySmall),
        SizedBox(height: AppSizes.spaceBetweenItems_16),
        Text(
          subTitle,
          style: Theme.of(context).textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
