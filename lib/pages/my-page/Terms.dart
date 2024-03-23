import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_rtc_app/constants/Colors.dart';
import 'package:web_rtc_app/widgets/atoms/IconButton.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PageTerms extends StatelessWidget {
  late final WebViewController controller;
  String url = "https://quixotic-polo-572.notion.site";
  PageTerms({super.key}) {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (!request.url.startsWith(url)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('$url/Haze-046beba603434d54b0969d872d651e93'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(ColorContent.content1),
        appBar: AppBar(
          backgroundColor: const Color(ColorContent.content1),
          elevation: 0,
          bottomOpacity: 0,
          centerTitle: true,
          scrolledUnderElevation: 0,
          leading: Center(
              child: SizedBox(
                  height: 36,
                  width: 36,
                  child: AtomIconButton(
                      backgroundColor: const Color(ColorContent.content1),
                      child: const Image(
                          height: 24,
                          width: 24,
                          image: AssetImage('assets/images/close.png')),
                      onPressed: () async {
                        Get.back();
                      }))),
          title: const Image(
            image: AssetImage('assets/images/haze-header-logo.png'),
            width: 54,
            height: 15,
          ),
        ),
        body: SafeArea(child: WebViewWidget(controller: controller)));
  }
}
