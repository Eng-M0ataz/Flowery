import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_elevated_button.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/Constants/sizes.dart';

class OrderCard extends StatelessWidget {
  final bool isDelivered;
  final String? imgCover;
  final String title;
  final double price;
  final String? orderNumber;
  final String date;

  const OrderCard({
    super.key,
    this.imgCover,
    required this.isDelivered,
    required this.title,
    required this.price,
    this.orderNumber,
    required this.date
  });

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(date).toLocal();
    String formattedDate = DateFormat('dd MMM yyyy').format(dateTime).toUpperCase();
    return Container(
      width: AppSizes.cardWidth_319,
      constraints: BoxConstraints(minHeight: AppSizes.cardHeight_125),
      padding: EdgeInsets.symmetric(
          horizontal: AppSizes.spaceBetweenItems_16,
          vertical: AppSizes.spaceBetweenItems_12
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd_8),
        border: Border.all(color: AppColorsLight.white[70]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              child: Container(
                color: AppColorsLight.pink[10],
                height: AppSizes.clipHeight_131,
                width: AppSizes.clipWidth_127,
                child: CachedNetworkImage(
                    imageUrl: imgCover ?? '',
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) => Icon(Icons.error,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppSizes.spaceBetweenItems_4),
                Text(
                  "${LocaleKeys.currency_egp.tr()} $price",
                  style: Theme.of(context).textTheme.displaySmall,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppSizes.spaceBetweenItems_4),
                Text(
                  isDelivered ? "${LocaleKeys.delivered_on.tr()} $formattedDate" :
                  "${LocaleKeys.order_number.tr()} $orderNumber",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(height: AppSizes.spaceBetweenItems_32),
                SizedBox(
                  height: AppSizes.sizedBoxHeight_30,
                  child: CustomElevatedButton(
                      onPressed: () {},
                      isLoading: false,
                      widget: Text(
                        isDelivered ? LocaleKeys.reorder.tr() : LocaleKeys.track_order,
                      ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
