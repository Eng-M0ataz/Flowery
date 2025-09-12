import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/Widgets/custom_app_bar.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/utils/Constants/sizes.dart';

class AppBarSection extends StatefulWidget {
  const AppBarSection({super.key});

  @override
  State<AppBarSection> createState() => _AppBarSectionState();
}

class _AppBarSectionState extends State<AppBarSection> {
  DateTime? _scheduledDateTime;

  Future<void> _pickDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) return;

    // Step 2: Pick time
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    // Combine date & time
    final DateTime fullDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() {
      _scheduledDateTime = fullDateTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(color: theme.colorScheme.onPrimary),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingMd_16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSizes.spaceBetwwenItems_16),
            CustomBackButton(title: LocaleKeys.checkout.tr()),
            const SizedBox(height: AppSizes.spaceBetwwenItems_24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.delivery_time.tr(),
                  style: theme.textTheme.displaySmall,
                ),
                GestureDetector(
                  onTap: _pickDateTime,
                  child: Text(
                    LocaleKeys.schedule.tr(),
                    style: theme.textTheme.displaySmall!.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spaceBetweenItems_16),
            Row(
              children: [
                const Icon(
                  Icons.watch_later_outlined,
                  size: AppSizes.mdIcon_24,
                ),
                const SizedBox(width: AppSizes.spaceBetweenItems_8),
                Text(
                  _scheduledDateTime == null
                      ? LocaleKeys.instant.tr()
                      : LocaleKeys.schedule.tr(),
                  style: theme.textTheme.titleSmall,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    _scheduledDateTime == null
                        ? LocaleKeys.arrive_by.tr()
                        : "${_scheduledDateTime!.day}/${_scheduledDateTime!.month} "
                            "${_scheduledDateTime!.hour}:${_scheduledDateTime!.minute.toString().padLeft(2, '0')}",
                    style: theme.textTheme.titleSmall!.copyWith(
                      color: theme.colorScheme.secondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spaceBetwwenItems_24),
          ],
        ),
      ),
    );
  }
}
