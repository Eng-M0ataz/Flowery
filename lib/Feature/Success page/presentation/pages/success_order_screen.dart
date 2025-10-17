import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/app_constants.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SuccessOrderScreen extends StatelessWidget {
  const SuccessOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSizes.paddingMd_16),
                child:SvgPicture.asset(
                  AppConstants.orderSuccessImage,
                  fit: BoxFit.contain,
                  width: AppSizes.imageOrderSuccessWidth_150,
                  height: AppSizes.imageOrderSuccessHeight_150,
                ) ,
              ),
              const SizedBox(height: AppSizes.spaceBetweenItems_24),
              Text(
                  LocaleKeys.successOrder.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: AppSizes.xxlFont_24
                  )
              ),
              const SizedBox(height: AppSizes.spaceBetweenItems_32),
              SizedBox(
                width: AppSizes.buttonWidth_343,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingMd_16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.borderRadiusXxxl_32),
                    ),
                  ),
                  onPressed: () {},
                  child:  Text(
                    LocaleKeys.trakerOrder.tr(),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}