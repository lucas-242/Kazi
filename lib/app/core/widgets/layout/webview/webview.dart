import 'package:flutter/material.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatelessWidget {
  const WebView({super.key, required this.url, required this.title});

  final String url;
  final String title;

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.background)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) => const Loading(),
        ),
      )
      ..loadRequest(Uri.parse(url));

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            AppSizeConstants.mediumVerticalSpacer,
            BackAndPill(text: title),
            AppSizeConstants.mediumVerticalSpacer,
          ],
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        titleSpacing: AppSizeConstants.largeSpace,
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
