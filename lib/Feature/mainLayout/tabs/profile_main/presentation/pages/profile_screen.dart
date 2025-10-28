import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/app_routes.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/localization/locale_keys.g.dart';
import '../../../../../../core/utils/Constantts/app_assets.dart';
import '../viewModels/profileViewModel/profile_main_event.dart';
import '../viewModels/profileViewModel/profile_main_view_model.dart';
import '../widgets/language_bottom_sheet.dart';
import '../widgets/profile_header_bloc_builder.dart';
import '../widgets/profile_menu_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileMainViewModel _viewModel;

  @override
  void initState() {
    _viewModel = getIt<ProfileMainViewModel>();
    _viewModel.doIntend(GetLoggedUserDataEvent());

    super.initState();
  }

  @override
  void dispose() {
    _viewModel;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocProvider<ProfileMainViewModel>.value(
        value: _viewModel,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              ProfileHeaderBlocBuilder(),
              SizedBox(
                height: AppSizes.spaceBetweenItems_42,
              ),
              _buildOrdersAndAddress(context),
              _buildNotification(),
              _buildGeneralSettings(context),
              _buildLogout(),
              SizedBox(
                height: AppSizes.spaceBetweenItems_42,
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      title: SvgPicture.asset(
        Assets.assetsImagesLogo,
        height: AppSizes.photoHeight_32,
        width: AppSizes.photoWidth_32,
        fit: BoxFit.contain,
      ),
      actionsPadding: const EdgeInsets.only(right: AppSizes.paddingMd_16),
      actions: [
        Stack(
          children: [
            SvgPicture.asset(
              Assets.assetsImagesNotification,
              height: AppSizes.photoHeight_32,
              width: AppSizes.photoWidth_32,
              fit: BoxFit.contain,
            ),
            CircleAvatar(
              radius: AppSizes.borderRadiusMd_10,
              backgroundColor: AppColorsLight.red,
              child: Text(
                '3',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            ),
          ],
        ),
      ],
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildOrdersAndAddress(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => context.pushNamed(AppRoutes.ordersRoute),
          child: ProfileMenuItem(
            leadingIcon: SvgPicture.asset(
              Assets.assetsImagesTransactionOrder,
              width: 20,
              height: 20,
            ),
            title: LocaleKeys.my_orders.tr(),
          ),
        ),
        SizedBox(height: AppSizes.spaceBetweenItems_12),
        GestureDetector(
          onTap: () => context.pushNamed(AppRoutes.savedAddressScreenRoute),
          child: ProfileMenuItem(
            leadingIcon: SvgPicture.asset(
              Assets.assetsImagesLocationIcon,
              width: 22,
              height: 22,
            ),
            title: LocaleKeys.saved_address.tr(),
          ),
        ),
        SizedBox(height: AppSizes.spaceBetweenItems_16),
        Divider(color: AppColorsLight.white[70]),
        SizedBox(height: AppSizes.spaceBetweenItems_16),
      ],
    );
  }

  Widget _buildNotification() {
    return Column(
      children: [
        ProfileMenuItem(
          leadingIcon: SizedBox(
            width: AppSizes.switchWidth_42,
            height: AppSizes.switchHigh_30,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Switch(
                value: true,
                onChanged: (val) {},
              ),
            ),
          ),
          title: LocaleKeys.notification.tr(),
        ),
        SizedBox(height: AppSizes.spaceBetweenItems_16),
        Divider(color: AppColorsLight.white[70]),
        SizedBox(height: AppSizes.spaceBetweenItems_16),
      ],
    );
  }

  Widget _buildGeneralSettings(BuildContext context) {
    return Column(
      children: [
        ProfileMenuItem(
          leadingIcon: Icon(
            Icons.translate,
            size: AppSizes.xxlFont_22,
          ),
          title: LocaleKeys.language.tr(),
          trailing: Text(
            LocaleKeys.english.tr(),
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          onTap: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppSizes.borderRadiusXl_20),
                ),
              ),
              builder: (_) => const LanguageBottomSheet(),
            );
          },
        ),
        SizedBox(height: AppSizes.spaceBetweenItems_16),
        ProfileMenuItem(title: LocaleKeys.about_us.tr()),
        SizedBox(height: AppSizes.spaceBetweenItems_16),
        ProfileMenuItem(title: LocaleKeys.terms_conditions.tr()),
        SizedBox(height: AppSizes.spaceBetweenItems_16),
        Divider(color: AppColorsLight.white[70]),
        SizedBox(height: AppSizes.spaceBetweenItems_16),
      ],
    );
  }

  Widget _buildLogout() {
    return ProfileMenuItem(
      leadingIcon: Icon(Icons.logout, size: AppSizes.smIcon_16),
      title: LocaleKeys.logout.tr(),
      trailing: Icon(Icons.logout),
    );
  }
}
