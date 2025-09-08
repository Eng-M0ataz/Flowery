import 'package:flutter/material.dart';

class BuildTabBar extends StatelessWidget {
  final int tabsLength;
  final List<Widget> taps;
  final void Function(int)? onTap;
  final int initialIndex;

  const BuildTabBar(
      {super.key,
      required this.tabsLength,
      required this.taps,
      required this.onTap,
      required this.initialIndex,
      });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: initialIndex,
      length: tabsLength,
      child: Column(
        children: [
          TabBar(
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            physics: BouncingScrollPhysics(),
            isScrollable: true,
            tabs: taps,
            onTap: onTap,

          ),
        ],
      ),
    );
  }
}
