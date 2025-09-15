import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/presentation/pages/orders_screen.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/presentation/widgets/order_card.dart';
import 'package:flutter/material.dart';

import '../../../../core/Config/Theme/app_colors.dart';
import '../../../../core/Widgets/custom_app_bar.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/utils/Constants/sizes.dart';
class ShowOrders extends StatelessWidget {
  final List<OrderItemWithOrderInfo> allActiveOrderItems;
  final List<OrderItemWithOrderInfo> allCompletedOrderItems;

  ShowOrders({super.key,
    required this.allActiveOrderItems,
    required this.allCompletedOrderItems
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        imgCover: product?.imageCover ?? '',
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
    );
  }
}
