import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VisaPaymentWebView extends StatefulWidget {
  final String url;

  const VisaPaymentWebView({required this.url, super.key});

  @override
  State<VisaPaymentWebView> createState() => _VisaPaymentWebViewState();
}

class _VisaPaymentWebViewState extends State<VisaPaymentWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(

          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains('localhost') ||
                request.url.contains('allOrders')) {
              _handleSuccessNavigation();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },

        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  void _handleSuccessNavigation() {
    if (mounted) {

      context.pushNamedAndRemoveUntil(AppRoutes.paymentSuccessRoute,predicate: (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visa Payment'),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
        ],
      ),
    );
  }
}