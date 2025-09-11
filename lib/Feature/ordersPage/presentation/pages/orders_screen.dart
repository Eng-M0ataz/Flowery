import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/order_entity.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/order_items.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/presentation/viewModels/orders_event.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/presentation/viewModels/orders_view_model.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/presentation/widgets/order_card.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_app_bar.dart';
import 'package:flower_e_commerce_app/core/Widgets/products_shimmer.dart';
import 'package:flower_e_commerce_app/core/helpers/dialogue_utils.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
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
      create: (context) => getIt.get<OrdersViewModel>()..doIntent(GetAllOrdersEvent()),
      child: BlocConsumer<OrdersViewModel, OrdersState>(
        listener: (context, state) {
          if (state.orderFailure != null) {
            DialogueUtils.showMessage(
                context: context,
                message: state.orderFailure!.errorMessage
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading == true) {
            return ProductsShimmer(isEnabled: state.isLoading);
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
              child: Scaffold(
                appBar: CustomBackButton(
                  title: LocaleKeys.my_orders.tr(),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: AppSizes.spaceBetweenItems_16),
                        child: TabBar(
                          isScrollable: true,
                          indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(
                                width: 3, color: AppColorsLight.pink),
                          ),
                          labelColor: AppColorsLight.pink,
                          unselectedLabelColor: AppColorsLight.grey,
                          indicatorSize: TabBarIndicatorSize.tab,
                          tabs: [
                            Tab(
                              child: SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2 - 25,
                                child: Center(
                                    child: Text(LocaleKeys.active.tr())),
                              ),
                            ),
                            Tab(
                              child: SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2 - 25,
                                child: Center(
                                    child: Text(LocaleKeys.completed.tr())),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      child: TabBarView(
                        children: [
                          allActiveOrderItems.isEmpty
                              ? Center(child: Text(LocaleKeys.no_active_orders.tr()))
                              : ListView.builder(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppSizes.spaceBetweenItems_16),
                            itemCount: allActiveOrderItems.length,
                            itemBuilder: (context, index) {
                              final orderItemWithInfo = allActiveOrderItems[index];
                              final item = orderItemWithInfo.orderItem;
                              final order = orderItemWithInfo.order;
                              final product = item.product;
                              final itemPrice = (item.price! * item.quantity!);
                              return Padding(
                                padding: const EdgeInsets.only(bottom: AppSizes.spaceBetweenItems_16),
                                child: OrderCard(
                                  imgCover: product?.imageCover,
                                  isDelivered: order.isDelivered!,
                                  title: product?.title ?? 'Unknown Product',
                                  price: itemPrice.toDouble(),
                                  orderNumber: order.orderNumber,
                                  date: order.updatedAt ?? order.createdAt ?? DateTime.now().toIso8601String(),
                                ),
                              );
                            },
                          ),

                          allCompletedOrderItems.isEmpty
                              ? Center(child: Text(LocaleKeys.no_completed_orders.tr()))
                              : ListView.builder(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppSizes.spaceBetweenItems_16),
                            itemCount: allCompletedOrderItems.length,
                            itemBuilder: (context, index) {
                              final orderItemWithInfo = allCompletedOrderItems[index];
                              final item = orderItemWithInfo.orderItem;
                              final order = orderItemWithInfo.order;
                              final product = item.product;
                              final itemPrice = (item.price! * item.quantity!);
                              return Padding(
                                padding: const EdgeInsets.only(bottom: AppSizes.spaceBetweenItems_16),
                                child: OrderCard(
                                  imgCover: product?.imageCover,
                                  isDelivered: order.isDelivered!,
                                  title: product?.title ?? "Unknown Product",
                                  price: itemPrice.toDouble(),
                                  orderNumber: order.orderNumber,
                                  date: order.updatedAt ?? order.createdAt ?? DateTime.now().toIso8601String(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return Center(child: Text(LocaleKeys.no_orders.tr()));
        },
      ),
    );
  }
}

class OrderItemWithOrderInfo {
  final OrderItems orderItem;
  final OrdersEntity order;

  OrderItemWithOrderInfo({
    required this.orderItem,
    required this.order,
  });
}