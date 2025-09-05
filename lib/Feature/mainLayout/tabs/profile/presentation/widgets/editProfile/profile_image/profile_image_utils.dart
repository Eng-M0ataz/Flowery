import 'dart:io';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/helpers/dialogue_utils.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

Widget buildPlaceholder(double size) {
  return Container(
    color: AppColorsLight.white[70],
    child: Icon(
      Icons.person,
      size: size * 0.5,
      color: AppColorsLight.white[90],
    ),
  );
}

Widget buildProfileImage(widget, File? selectedImage) {
  if (selectedImage != null) {
    return Image.file(
      selectedImage,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => buildPlaceholder(widget.size),
    );
  } else if (widget.initialImageUrl != null &&
      widget.initialImageUrl!.isNotEmpty) {
    return Image.network(
      widget.initialImageUrl!,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => buildPlaceholder(widget.size),
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: progress.expectedTotalBytes != null
                ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes!
                : null,
            strokeWidth: AppSizes.borderWidth_2,
          ),
        );
      },
    );
  }
  return buildPlaceholder(widget.size);
}

Widget buildCameraIcon() {
  return Container(
    width: AppSizes.lgIcon_36,
    height: AppSizes.lgIcon_36,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: AppColorsLight.white,
      border: Border.all(
          color: AppColorsLight.white[50]!, width: AppSizes.borderWidth_2),
      boxShadow: [
        BoxShadow(
          color: AppColorsLight.black.withOpacity(0.1),
          blurRadius: AppSizes.borderRadiusSm_4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: const Icon(
      Icons.camera_alt,
      size: AppSizes.smIcon_18,
      color: AppColorsLight.gray,
    ),
  );
}

Widget buildPickerOption({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
  Color? color,
  required BuildContext context,
}) {
  return GestureDetector(
    onTap: () {
      onTap();
      Navigator.pop;
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: AppSizes.lgIcon_60,
          height: AppSizes.lgIcon_60,
          decoration: BoxDecoration(
            color: (color ?? AppColorsLight.pink).withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon,
              size: AppSizes.mdIcon_30, color: color ?? AppColorsLight.pink),
        ),
        const SizedBox(height: AppSizes.spaceBetweenItems_8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: color ?? AppColorsLight.black[90],
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    ),
  );
}

Widget buildHandleBar() {
  return Container(
    width: AppSizes.imageHandlerBarWidth,
    height: AppSizes.imageHandlerBarHeight,
    decoration: BoxDecoration(
      color: AppColorsLight.white[40],
      borderRadius: BorderRadius.circular(AppSizes.borderRadiusXs_2),
    ),
  );
}

void showErrorDialog(BuildContext context, String message) {
  DialogueUtils.showMessage(
      context: context,
      message: message,
      posActionName: LocaleKeys.ok.tr(),
      posAction: () {
        Navigator.of(context).pop();
      },
      title: LocaleKeys.error.tr());
}
