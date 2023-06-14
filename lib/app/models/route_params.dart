import 'package:kazi/app/models/app_page.dart';
import 'package:kazi/app/models/service.dart';

class RouteParams {
  AppPage lastPage;
  Service? service;

  RouteParams({
    required this.lastPage,
    this.service,
  });
}
