import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kazi/app/app_cubit.dart';
import 'package:kazi/app/core/constants/app_keys.dart';
import 'package:kazi/app/data/local_storage/local_storage.dart';
import 'package:kazi/app/models/route_params.dart';
import 'package:kazi/app/models/service.dart';
import 'package:kazi/service_locator.dart';

import 'app_pages.dart';

extension RoutesExtensions on BuildContext {
  AppPages get currentPage => read<AppCubit>().state;

  bool get showOnboarding =>
      ServiceLocator.get<LocalStorage>()
          .get<bool>(AppKeys.showOnboardingStorage) ??
      true;

  void navigateTo(
    AppPages page, {
    Service? service,
    String? token,
    WebViewParams? webViewParams,
    bool shouldPop = false,
  }) {
    final cubit = read<AppCubit>();
    final lastPage = cubit.state;
    cubit.changePage(page);

    if (shouldPop) {
      pop();
    } else {
      _navigate(
        page,
        RouteParams(
          lastPage: lastPage,
          service: service,
          token: token,
          webViewParams: webViewParams,
        ),
      );
    }
  }

  void _navigate(AppPages page, RouteParams params) =>
      go(AppPages.getRoute(page, id: params.service?.id), extra: params);

  void pushTo(AppPages page, {Service? service}) {
    final lastPage = read<AppCubit>().state;

    final params = RouteParams(
      lastPage: lastPage,
      service: service,
    );
    push(AppPages.getRoute(page, id: params.service?.id), extra: params);
  }

  void navigateBack({RouteParams? params}) {
    if (params?.lastPage != null) {
      return _navigate(params!.lastPage!, params);
    }
    pop();
  }

  void floatingActionNavigation(AppPages? lastPage) {
    final cubit = read<AppCubit>();
    if (cubit.state == AppPages.addServices) {
      //* Avoid navigate to a dynamic route. Maybe could change it in the future to load data everytime the user move to a dynamic route.
      if (lastPage != AppPages.home) {
        cubit.changePage(AppPages.services);
        navigateTo(AppPages.services);
      } else {
        cubit.changePage(AppPages.home);
        navigateTo(AppPages.home);
      }
    } else {
      navigateTo(AppPages.addServices);
    }
  }
}
