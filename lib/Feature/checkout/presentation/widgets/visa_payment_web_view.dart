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
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (_) {},
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
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
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
