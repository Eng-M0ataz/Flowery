import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'profile_image_utils.dart';
import 'package:easy_localization/easy_localization.dart';

void showProfileImageDialog({
  required BuildContext context,
  required Function(ImageSource source) onPickImage,
  required bool hasImage,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
          color: AppColorsLight.white,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppSizes.borderRadiusXl_20)),
        ),
        child: SafeArea(
          child: Wrap(
            children: [
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: AppSizes.paddingMd_20),
                child: Column(
                  children: [
                    buildHandleBar(),
                    const SizedBox(height: AppSizes.spacingBetweenItems_20),
                    Text(
                      LocaleKeys.select_profile_picture.tr(),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: AppSizes.spacingBetweenItems_20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildPickerOption(
                          context: context,
                          icon: Icons.camera_alt,
                          label: LocaleKeys.camera.tr(),
                          onTap: () => onPickImage(ImageSource.camera),
                        ),
                        buildPickerOption(
                          context: context,
                          icon: Icons.photo_library,
                          label: LocaleKeys.gallery.tr(),
                          onTap: () => onPickImage(ImageSource.gallery),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.spacingBetweenItems_20),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
