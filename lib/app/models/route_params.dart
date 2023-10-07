import 'package:kazi/app/core/routes/routes.dart';
import 'package:kazi/app/models/service.dart';

class RouteParams {
  const RouteParams({
    this.lastPage,
    this.service,
    this.token,
    this.webViewParams,
  });

  final AppPages? lastPage;
  final Service? service;
  final String? token;
  final WebViewParams? webViewParams;
}

class WebViewParams {
  WebViewParams(this.title, this.url);

  final String title;
  final String url;
}
