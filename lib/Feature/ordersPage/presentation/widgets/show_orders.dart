import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/presentation/pages/orders_screen.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/presentation/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../core/Config/Theme/app_colors.dart';
import '../../../../core/Widgets/custom_app_bar.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/utils/Constantts/sizes.dart';

class ShowOrders extends StatelessWidget {
  final List<OrderItemWithOrderInfo> allActiveOrderItems;
  final List<OrderItemWithOrderInfo> allCompletedOrderItems;
  final bool isLoading;

  const ShowOrders({
    super.key,
    required this.allActiveOrderItems,
    required this.allCompletedOrderItems,
    this.isLoading = false,
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
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppSizes.spaceBetweenItems_16),
            child: TabBar(
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 3, color: AppColorsLight.pink),
              ),
              labelColor: AppColorsLight.pink,
              unselectedLabelColor: AppColorsLight.grey,
              indicatorSize: TabBarIndicatorSize.tab,
              tabAlignment: TabAlignment.fill,
              tabs: [
                Tab(
                  text: LocaleKeys.active.tr(),
                ),
                Tab(
                  text: LocaleKeys.completed.tr(),
                ),
              ],
            ),
          ),
          Expanded(
              child: TabBarView(
            children: [
              // Active Orders Tab
              if (isLoading)
                ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.spaceBetweenItems_16),
                  itemBuilder: (context, index) => ShimmerItem(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemCount: 3,
                )
              else if (allActiveOrderItems.isEmpty)
                Center(child: Text(LocaleKeys.no_active_orders.tr()))
              else
                ListView.builder(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.spaceBetweenItems_16),
                  itemCount: allActiveOrderItems.length,
                  itemBuilder: (context, index) {
                    final orderItemWithInfo = allActiveOrderItems[index];
                    final item = orderItemWithInfo.orderItem;
                    final order = orderItemWithInfo.order;
                    final product = item.product;
                    final itemPrice = (item.price ?? 0) * (item.quantity ?? 1);
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: AppSizes.spaceBetweenItems_16),
                      child: OrderCard(
                        orderId: order.id ?? '',
                        imgCover: product?.imageCover ?? '',
                        isDelivered: order.isDelivered ?? false,
                        title: product?.title ?? 'Unknown Product',
                        price: itemPrice.toDouble(),
                        orderNumber: order.orderNumber,
                        date: order.updatedAt ??
                            order.createdAt ??
                            DateTime.now().toIso8601String(),
                      ),
                    );
                  },
                ),

              // Completed Orders Tab
              if (isLoading)
                ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.spaceBetweenItems_16),
                  itemBuilder: (context, index) => ShimmerItem(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemCount: 3,
                )
              else if (allCompletedOrderItems.isEmpty)
                Center(child: Text(LocaleKeys.no_completed_orders.tr()))
              else
                ListView.builder(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.spaceBetweenItems_16),
                  itemCount: allCompletedOrderItems.length,
                  itemBuilder: (context, index) {
                    final orderItemWithInfo = allCompletedOrderItems[index];
                    final item = orderItemWithInfo.orderItem;
                    final order = orderItemWithInfo.order;
                    final product = item.product;
                    final itemPrice = (item.price ?? 0) * (item.quantity ?? 1);
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: AppSizes.spaceBetweenItems_16),
                      child: OrderCard(
                        orderId: order.id ?? '',
                        imgCover: product?.imageCover ?? '',
                        isDelivered: order.isDelivered ?? false,
                        title: product?.title ?? "Unknown Product",
                        price: itemPrice.toDouble(),
                        orderNumber: order.orderNumber,
                        date: order.updatedAt ??
                            order.createdAt ??
                            DateTime.now().toIso8601String(),
                      ),
                    );
                  },
                ),
            ],
          ))
        ],
      ),
    );
  }
}

class ShimmerItem extends StatelessWidget {
  const ShimmerItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      enabled: true,
      color: AppColorsLight.shimmerColor,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: AppColorsLight.shimmerColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 14,
                    decoration: BoxDecoration(
                      color: AppColorsLight.shimmerColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 14,
                    width: 70,
                    decoration: BoxDecoration(
                      color: AppColorsLight.shimmerColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 14,
                    width: 150,
                    decoration: BoxDecoration(
                      color: AppColorsLight.shimmerColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: AlignmentGeometry.center,
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: AppColorsLight.shimmerColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
