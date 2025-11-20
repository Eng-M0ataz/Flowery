import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/order_entity.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/order_items.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/presentation/viewModels/orders_event.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/presentation/viewModels/orders_view_model.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/presentation/widgets/show_orders.dart';
import 'package:flower_e_commerce_app/core/helpers/dialogue_utils.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Di/di.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt.get<OrdersViewModel>()..doIntent(GetAllOrdersEvent()),
      child: BlocConsumer<OrdersViewModel, OrdersState>(
        listenWhen: (pre, cur) =>
            pre.isSuccess != cur.isSuccess ||
            pre.orderFailure != cur.orderFailure,
        listener: (context, state) {
          if (state.orderFailure != null && state.isSuccess == false) {
            DialogueUtils.showMessage(
                context: context, message: state.orderFailure!.errorMessage);
          }
        },
        builder: (context, state) {
          final List<OrderItemWithOrderInfo> allActiveOrderItems = [];
          final List<OrderItemWithOrderInfo> allCompletedOrderItems = [];

          if (state.orders != null && state.orders!.orders!.isNotEmpty) {
            final orders = state.orders!.orders;
            for (final order in orders!) {
              if (order.orderItems != null) {
                for (final item in order.orderItems!) {
                  final orderItemWithInfo = OrderItemWithOrderInfo(
                    orderItem: item,
                    order: order,
                  );

                  if (order.isDelivered!) {
                    allCompletedOrderItems.add(orderItemWithInfo);
                  } else {
                    allActiveOrderItems.add(orderItemWithInfo);
                  }
                }
              }
            }
          }

          if (allActiveOrderItems.isNotEmpty ||
              allCompletedOrderItems.isNotEmpty ||
              state.isLoading == true) {
            return DefaultTabController(
              length: 2,
              child: ShowOrders(
                  allActiveOrderItems: allActiveOrderItems,
                  allCompletedOrderItems: allCompletedOrderItems,
                  isLoading: state.isLoading == true),
            );
          }

          return Scaffold(body: Center(child: Text(LocaleKeys.no_orders.tr())));
        },
      ),
    );
  }
}

class OrderItemWithOrderInfo {
  final OrderItemsEntity orderItem;
  final OrdersEntity order;

  OrderItemWithOrderInfo({
    required this.orderItem,
    required this.order,
  });
}
