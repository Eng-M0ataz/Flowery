import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/enum/order_status.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/presentation/viewModel/trackOrderViewModel/track_order_view_model.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/presentation/viewModel/trackOrderViewModel/track_order_state.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/domain/entities/order_status_history_entity.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/domain/entities/status_entity.dart';

class OrderTimeLine extends StatelessWidget {
  const OrderTimeLine({super.key});

  StatusEntity? _getStatusModel(
      OrderStatusHistoryEntity? history, OrderStatus status) {
    if (history == null) return null;
    switch (status) {
      case OrderStatus.accepted:
        return history.accepted;
      case OrderStatus.picked:
        return history.picked;
      case OrderStatus.outfordelivery:
        return history.outfordelivery;
      case OrderStatus.arrived:
        return history.arrived;

      case OrderStatus.delivered:
        return history.delivered;
    }
  }

  int _getCurrentStep(OrderStatusHistoryEntity? history) {
    if (history == null) return -1;

    final statusList = [
      history.accepted,
      history.picked,
      history.outfordelivery,
      history.arrived,
      history.delivered,
    ];

    return statusList.lastIndexWhere((status) => status != null);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final titles = [
      LocaleKeys.your_order_is_accepted.tr(),
      LocaleKeys.your_order_is_picked.tr(),
      LocaleKeys.your_order_is_in_the_way.tr(),
      LocaleKeys.your_order_is_arrived.tr(),
      LocaleKeys.your_order_is_delivered.tr(),
    ];
    return BlocBuilder<TrackOrderViewModel, TrackOrderState>(
      buildWhen: (prev, curr) => prev.entity != curr.entity,
      builder: (context, state) {
        final order = state.entity!;

        final statusHistory = order.statusHistory;

        final currentStep = _getCurrentStep(statusHistory);

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppSizes.paddingMd_16),
          itemCount: OrderStatus.values.length,
          itemBuilder: (context, index) {
            final isFirst = index == 0;
            final isLast = index == OrderStatus.values.length - 1;
            final isActive = index <= currentStep;

            final statusKeyForIndex = OrderStatus.values[index];
            final statusModelForIndex =
                _getStatusModel(statusHistory, statusKeyForIndex);

            final dateToShow = statusModelForIndex?.statusUpdateDate ?? '';

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    if (!isFirst)
                      Container(
                        width: AppSizes.containerWidth_1,
                        height: AppSizes.containerHeight_20,
                        color: isActive
                            ? theme.colorScheme.primary
                            : AppColorsLight.grey,
                      ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: AppSizes.borderRadiusMd_10,
                          backgroundColor: isActive
                              ? theme.colorScheme.primary
                              : AppColorsLight.grey,
                        ),
                        CircleAvatar(
                          radius: AppSizes.borderRadiusMd_8,
                          backgroundColor: theme.colorScheme.onPrimary,
                        ),
                        if (isActive)
                          CircleAvatar(
                            radius: AppSizes.borderRadiusSm_5,
                            backgroundColor: theme.colorScheme.primary,
                          ),
                      ],
                    ),
                    if (!isLast)
                      Container(
                        width: AppSizes.containerWidth_1,
                        height: AppSizes.containerHeight_62,
                        color: index < currentStep
                            ? theme.colorScheme.primary
                            : AppColorsLight.grey,
                      ),
                  ],
                ),
                const SizedBox(width: AppSizes.spaceBetweenItems_8),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: AppSizes.paddingMd_16 - 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titles[index],
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight:
                                isActive ? FontWeight.bold : FontWeight.normal,
                            color: isActive
                                ? theme.colorScheme.onBackground
                                : AppColorsLight.grey,
                          ),
                        ),
                        const SizedBox(height: AppSizes.spaceBetweenItems_4),
                        if (dateToShow.isNotEmpty)
                          Text(
                            dateToShow,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: AppColorsLight.grey,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
