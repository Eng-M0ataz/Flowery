import 'package:flower_e_commerce_app/Feature/notifications/presentation/widgets/notification_screen_body.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackButton(title: 'Notifications'),
      body: NotificationScreenBody(),
    );
  }
}
