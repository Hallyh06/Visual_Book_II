import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShopViewPage extends StatefulWidget {
  const ShopViewPage({super.key});

  @override
  State<ShopViewPage> createState() => _ShopViewPageState();
}

class _ShopViewPageState extends State<ShopViewPage> {
  late final PlatformWebViewControllerCreationParams params;
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (
            int progress,
          ) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse("https://thevisualbook.com/collections/all"));
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFFF),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xffDBD2C2),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
