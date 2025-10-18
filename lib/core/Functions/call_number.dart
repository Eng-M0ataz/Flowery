import 'package:url_launcher/url_launcher.dart';

Future<void> callNumber(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  if (!await launchUrl(launchUri)) {
    throw 'Could not launch $phoneNumber';
  }
}