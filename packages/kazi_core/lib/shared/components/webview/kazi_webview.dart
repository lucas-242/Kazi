import 'package:flutter/material.dart';
import 'package:kazi_core/shared/components/buttons/kazi_back_button.dart';
import 'package:kazi_core/shared/components/status/kazi_loading.dart';
import 'package:kazi_core/shared/themes/themes.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatelessWidget {
  const WebView({super.key, required this.url, required this.title});

  final String url;
  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(colors.background)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) => const KaziLoading(),
        ),
      )
      ..loadRequest(Uri.parse(url));

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            KaziSpacings.verticalMd,
            _BackButton(text: title),
            KaziSpacings.verticalMd,
          ],
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: colors.background,
        titleSpacing: KaziInsets.lg,
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({
    this.text,
  });
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const KaziBackButton(),
        KaziSpacings.horizontalSm,
        Visibility(
          visible: text != null,
          child: Text(
            text ?? '',
            style: KaziTextStyles.headlineMedium,
          ),
        ),
      ],
    );
  }
}
