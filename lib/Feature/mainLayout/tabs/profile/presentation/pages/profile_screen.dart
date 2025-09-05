import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/presentation/viewModels/profileViewModel/profile_event.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/presentation/viewModels/profileViewModel/profile_view_model.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/presentation/widgets/profile_header_bloc_builder.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flower_e_commerce_app/core/Services/secure_storage.dart';
import 'package:flower_e_commerce_app/core/Utils/constants/app_routes.dart';
import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/app_assets.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../core/localization/locale_keys.g.dart';
import '../widgets/language_bottom_sheet.dart';
import '../widgets/profile_menu_item.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final storage = SecureStorageImpl();
  final ProfileViewModel viewModel = getIt<ProfileViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocProvider<ProfileViewModel>(
        create: (context) => viewModel..doIntend(GetLoggedUserDataEvent()),
        child: Column(
          children: [
            ProfileHeaderBlocBuilder(),
            SizedBox(
              height: AppSizes.spaceBetweenItems_42,
            ),
            _buildOrdersAndAddress(),
            _buildNotification(),
            _buildGeneralSettings(context),
            _buildLogout(context),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
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
            const Icon(
              Icons.notifications_none_sharp,
              size: AppSizes.lgIcon_36,
              color: AppColorsLight.grey,
            ),
            CircleAvatar(
              radius: AppSizes.borderRadius_10,
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

  Widget _buildOrdersAndAddress() {
    return Column(
      children: [
        ProfileMenuItem(
          leadingIcon: Icon(Icons.event_note_outlined),
          title: LocaleKeys.my_orders.tr(),
        ),
        SizedBox(height: AppSizes.spaceBetweenItems_12),
        ProfileMenuItem(
          leadingIcon: Icon(Icons.location_on_outlined),
          title: LocaleKeys.saved_address.tr(),
        ),
        SizedBox(height: AppSizes.spaceBetweenItems_16),
        Divider(color: AppColorsLight.white_70),
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
        Divider(color: AppColorsLight.white_70),
        SizedBox(height: AppSizes.spaceBetweenItems_16),
      ],
    );
  }

  Widget _buildGeneralSettings(BuildContext context) {
    return Column(
      children: [
        ProfileMenuItem(
          leadingIcon: Icon(Icons.translate),
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
        Divider(color: AppColorsLight.white_70),
        SizedBox(height: AppSizes.spaceBetweenItems_16),
      ],
    );
  }

  Widget _buildLogout(BuildContext context) {
    return ProfileMenuItem(
      leadingIcon: Icon(Icons.logout, size: AppSizes.smIcon_16),
      title: LocaleKeys.logout.tr(),
      trailing: Icon(Icons.logout),
      onTap: () {
        storage.delete(key: 'token');
        context.pushReplacementNamed(AppRoutes.signInRoute);
      },
    );
  }
}
