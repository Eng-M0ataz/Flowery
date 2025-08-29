import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/presentation/viewModel/main_layout_intent.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/presentation/viewModel/main_layout_states.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/presentation/viewModel/main_layout_view_model.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/app_assets.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/locale_keys.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';



class Nav_Widgets extends StatelessWidget {
  const Nav_Widgets({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationViewModel, NavigationState>(
      builder: (context, state) {
        final cubit = context.read<NavigationViewModel>();

        return NavigationBarTheme(
          data: NavigationBarThemeData(
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
                (state){
                  if(state.contains(WidgetState.selected)){
                    return TextStyle(color: Theme.of(context).colorScheme.primary);
                  }
                  return const TextStyle(color: Colors.grey);
                }
            )
          ),
          child: NavigationBar(
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            indicatorColor: Colors.transparent,
            height: AppSizes.imageHight_56,
            selectedIndex: state.selectedIndex,
            onDestinationSelected: (index) {
              cubit.doIntent(ChangeTabIntent(index));
            },
            destinations: [
              _buildNavDestination(
                context: context,
                iconPath: Assets.assetsImagesHomeUnselected,
                label: LocaleKeys.home.tr(),
                isSelected: state.selectedIndex == 0,
              ),
              _buildNavDestination(
                context: context,
                iconPath: Assets.assetsImagesCategoryUnselected,
                label: LocaleKeys.category.tr(),
                isSelected: state.selectedIndex == 1,
              ),
              _buildNavDestination(
                context: context,
                iconPath: Assets.assetsImagesShoppingCartUnselected,
                label: LocaleKeys.cart.tr(),
                isSelected: state.selectedIndex == 2,
              ),
              _buildNavDestination(
                context: context,
                iconPath:Assets.assetsImagesPersonUnselected,
                label: LocaleKeys.profile.tr(),
                isSelected: state.selectedIndex == 3,
              ),
            ],
          ),
        );
      },
    );
  }
}

NavigationDestination _buildNavDestination({
  required BuildContext context,
  required String iconPath,
  required String label,
  required bool isSelected,
}) {
  final color =
  isSelected ? Theme.of(context).colorScheme.primary : Colors.grey;

  return NavigationDestination(
    icon: SvgPicture.asset(
      iconPath,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      width: AppSizes.imageWidthNavBar_24,
      height: AppSizes.imageHeightNavBar_24,
    ),
    label: label,
  );
}
