import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/locale_keys.g.dart';

class ScheduleRow extends StatefulWidget {
  const ScheduleRow({super.key});

  @override
  State<ScheduleRow> createState() => _ScheduleRowState();
}

class _ScheduleRowState extends State<ScheduleRow> {
  DateTime? _scheduledDateTime;

  Future<void> _pickDateTime(BuildContext context) async {
    // Pick Date
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date == null) return;

    // Pick Time
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return;

    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() {
      _scheduledDateTime = dateTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => _pickDateTime(context),
      child: Row(
        children: [
          Icon(
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
    );
  }
}
