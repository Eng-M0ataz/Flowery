import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      required this.onPressed,
      required this.isLoading,
      required this.title,
      this.loadingColor,
      this.textColor,
      this.containerColor});
  final void Function() onPressed;
  final bool isLoading;
  final String title;
  final Color? textColor;
  final Color? loadingColor;
  final Color? containerColor;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        height: AppSizes.buttonHigh_48,
        width: isLoading
            ? AppSizes.buttonWidthSm_80
            : MediaQuery.of(context).size.width,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        child: isLoading
            ? Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:
                      containerColor ?? Theme.of(context).colorScheme.primary,
                  borderRadius:
                      BorderRadius.circular(AppSizes.borderRadiusFull),
                ),
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: Theme(
                    data: ThemeData(
                      progressIndicatorTheme: ProgressIndicatorThemeData(
                        color: loadingColor ??
                            Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            : ElevatedButton(
                onPressed: onPressed,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color:
                          textColor ?? Theme.of(context).colorScheme.onPrimary),
                ),
              ),
      ),
    );
  }
}
