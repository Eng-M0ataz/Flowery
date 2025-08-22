import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
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
            style: Theme.of(context).textTheme.headlineLarge),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: const Size(0, 0),
          ),
          onPressed: () {
            context.pushNamed(routeName);
          },
          child: Text(
            secondText,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              decoration: TextDecoration.underline,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
