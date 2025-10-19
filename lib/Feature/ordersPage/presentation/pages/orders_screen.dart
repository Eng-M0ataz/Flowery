import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/order_entity.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/order_items.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/presentation/viewModels/orders_event.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/presentation/viewModels/orders_view_model.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/presentation/widgets/show_orders.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_app_bar.dart';
import 'package:flower_e_commerce_app/core/Widgets/products_shimmer.dart';
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
        listener: (context, state) {
          if (state.orderFailure != null) {
            DialogueUtils.showMessage(
                context: context, message: state.orderFailure!.errorMessage);
          }
        },
        builder: (context, state) {
          if (state.isLoading == true) {
            return Scaffold(
              appBar: CustomBackButton(title: LocaleKeys.my_orders.tr()),
              body: Column(
                children: [
                  ProductsShimmer(isEnabled: state.isLoading),
                ],
              ),
            );
          }
          if (state.orders != null && state.orders!.orders!.isNotEmpty) {
            final orders = state.orders!.orders;

            final List<OrderItemWithOrderInfo> allActiveOrderItems = [];
            final List<OrderItemWithOrderInfo> allCompletedOrderItems = [];

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

            return DefaultTabController(
              length: 2,
              child: ShowOrders(
                  allActiveOrderItems: allActiveOrderItems,
                  allCompletedOrderItems: allCompletedOrderItems),
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
