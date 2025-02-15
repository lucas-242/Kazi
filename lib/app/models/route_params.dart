import 'package:kazi/app/models/app_page.dart';
import 'package:kazi/app/models/service.dart';

class RouteParams {

  RouteParams({
    required this.lastPage,
    this.service,
  });
  AppPage lastPage;
  Service? service;
}
