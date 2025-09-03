import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../core/Config/Theme/app_colors.dart';
import '../../../../../../core/Config/app_config_cubit.dart';
import '../../../../../../core/localization/locale_keys.g.dart';
import '../../../../../../core/utils/Constants/app_assets.dart';
import '../../../../../../core/utils/Constants/app_constants.dart';
import '../../../../../../core/utils/Constants/sizes.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.paddingMd_16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.change_language.tr(),
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: AppSizes.spaceBetweenItems_16),
          _buildLanguageTile(
            context: context,
            title: LocaleKeys.arabic.tr(),
            locale: const Locale(AppConstants.ar),
          ),
          const SizedBox(height: AppSizes.spaceBetweenItems_16),
          _buildLanguageTile(
            context: context,
            title: LocaleKeys.english.tr(),
            locale: const Locale(AppConstants.en),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageTile({
    required BuildContext context,
    required String title,
    required Locale locale,
  }) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      tileColor: AppColorsLight.whiteColor,
      trailing: SvgPicture.asset(
        Assets.assetsImageSelectIcon,
        height: AppSizes.photoHeight_20,
        width: AppSizes.photoWidth_20,
        fit: BoxFit.contain,
      ),
      onTap: () {
        context.read<AppConfigCubit>().changeLanguage(locale);
        context.setLocale(locale);
        Navigator.pop(context);
      },
    );
  }
}
