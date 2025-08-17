import 'package:flutter/material.dart';

void showSnackBar({
  required String message,
  required BuildContext context,
  required TextStyle textStyle,
}) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(message, style: textStyle)));
}
