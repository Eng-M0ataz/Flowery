import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cartFeature/cart_screen.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/pages/category_screen.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/pages/home_screen.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profileFeature/profile_screen.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/app_assets.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/locale_keys.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class MainLayout extends StatelessWidget {
  MainLayout({super.key});

  final List<Widget> tabs = [
    HomeScreen(),
    const CategoryScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          final cubit = context.read<NavigationCubit>();
          return Scaffold(
            body: tabs[state.selectedIndex],
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                navigationBarTheme: NavigationBarThemeData(
                  labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
                    (states) {
                      if (states.contains(WidgetState.selected)) {
                        return TextStyle(
                            color: Theme.of(context).colorScheme.primary);
                      }
                      return const TextStyle(color: Colors.grey);
                    },
                  ),
                ),
              ),
              child: NavigationBar(
                backgroundColor: Colors.white,
                elevation: 3,
                indicatorColor: Colors.transparent,
                height: AppSizes.appBarHigh_24,
                labelBehavior:
                    NavigationDestinationLabelBehavior.onlyShowSelected,
                selectedIndex: state.selectedIndex,
                onDestinationSelected: cubit.changeTab,
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
                    iconPath: Assets.assetsImagesPersonUnselected,
                    label: LocaleKeys.profile.tr(),
                    isSelected: state.selectedIndex == 3,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
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
        width: AppSizes.imageWidthnNavBar_24,
        height: AppSizes.imageHighnNavBar_24,
      ),
      label: label,
    );
  }
}

class NavigationState {
  final int selectedIndex;
  const NavigationState(this.selectedIndex);
}

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(0));

  void changeTab(int index) {
    emit(NavigationState(index));
  }
}
