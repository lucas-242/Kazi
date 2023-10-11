import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kazi/app/app_cubit.dart';
import 'package:kazi/app/core/routes/routes.dart';
import 'package:kazi/app/models/route_params.dart';
import 'package:kazi/app/models/service.dart';

class RoutesService {
  static final GoRouter _router = RoutesConfig.router;

  static AppPages? _lastPage;
  static AppPages? _currentPage;
  static bool _isPushed = false;

  static AppPages? get lastRoute => _lastPage;
  static AppPages? get activeRoute => _currentPage;
  static bool get isPushed => _isPushed;

  static RouteParams? params;

  static void navigateTo(
    BuildContext context,
    AppPages page, {
    Service? service,
    String? token,
    WebViewParams? webViewParams,
  }) {
    _setRoutes(page);

    final params = RouteParams(
      service: service,
      token: token,
      webViewParams: webViewParams,
    );

    _changeCubitAppPage(context, page);
    _navigate(page, params);
  }

  static void _setRoutes(AppPages page, [bool isPushed = false]) {
    _lastPage = _currentPage;
    _currentPage = page;
    _isPushed = isPushed;
  }

  static void _changeCubitAppPage(BuildContext context, AppPages newPage) {
    final cubit = context.read<AppCubit>();
    cubit.changePage(newPage);
  }

  static void _navigate(AppPages page, [RouteParams? params]) => _router
      .go(AppPages.getRoute(page, id: params?.service?.id), extra: params);

  static void pushTo(
    BuildContext context,
    AppPages page, {
    Service? service,
    String? token,
    WebViewParams? webViewParams,
  }) {
    _setRoutes(page, true);

    final params = RouteParams(
      service: service,
      token: token,
      webViewParams: webViewParams,
    );

    _changeCubitAppPage(context, page);
    _router.push(
      AppPages.getRoute(page, id: params.service?.id),
      extra: params,
    );
  }

  static void navigateBack() {
    if (_lastPage == null) {
      return;
    }

    if (_isPushed) {
      _setRoutes(_lastPage!);
      return _router.pop();
    }

    _setRoutes(_lastPage!);
    _navigate(_lastPage!);
  }

  static void floatingActionNavigation(BuildContext context) {
    var newPage = AppPages.addServices;
    _isPushed = true;

    if (_currentPage == AppPages.addServices) {
      //* Avoid navigate to a dynamic route. Maybe could change it in the future to load data everytime the user move to a dynamic route.
      _isPushed = false;
      newPage = _getRouteToFloatingAction();
    }

    _lastPage = _currentPage;
    _currentPage = newPage;

    _changeCubitAppPage(context, newPage);
    navigateTo(context, newPage);
  }

  static AppPages _getRouteToFloatingAction() =>
      _currentPage == AppPages.home ? AppPages.home : AppPages.services;
}
