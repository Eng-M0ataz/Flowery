import 'package:flower_e_commerce_app/Feature/notifications/presentation/widgets/notification_listtile.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';

class NotificationListView extends StatelessWidget {
  const NotificationListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(top: AppSizes.paddingMd_16),
      itemCount: 3,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) => NotificationListTile(),
    );
  }
}
