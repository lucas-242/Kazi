import 'package:kazi/app/models/enums/app_page.dart';
import 'package:kazi/app/models/service.dart';

class RouteParams {
  const RouteParams({
    this.lastPage,
    this.service,
    this.token,
    this.webViewParams,
  });

  final AppPage? lastPage;
  final Service? service;
  final String? token;
  final WebViewParams? webViewParams;
}

class WebViewParams {
  WebViewParams(this.title, this.url);

  final String title;
  final String url;
}
