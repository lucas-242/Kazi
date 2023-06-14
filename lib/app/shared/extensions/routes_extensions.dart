import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kazi/app/app_cubit.dart';
import 'package:kazi/app/models/app_page.dart';
import 'package:kazi/app/models/route_params.dart';
import 'package:kazi/app/models/service.dart';

export 'package:kazi/app/models/app_page.dart';

extension RoutesExtensions on BuildContext {
  void navigateTo(
    AppPage page, {
    Service? service,
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
        RouteParams(lastPage: lastPage, service: service),
      );
    }
  }

  void _navigate(AppPage page, RouteParams params) =>
      go(AppPage.getRoute(page, id: params.service?.id ?? ''), extra: params);

  AppPage get currentPage => read<AppCubit>().state;

  void back({RouteParams? params}) {
    if (params?.lastPage != null) {
      return _backToLastPage(params!);
    }
    pop();
  }

  void _backToLastPage(RouteParams params) {
    _navigate(
      params.lastPage,
      RouteParams(lastPage: params.lastPage),
    );
  }
}
