import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import 'package:kazi_core/kazi_core.dart';

/// Abstract base class for app navigation.
/// Each app should extend this and implement the abstract methods.
abstract class KaziNavigator {
  static GoRouter? _router;
  static KaziPage? Function(String route)? _pageResolver;

  static String _previousRoute = '/';
  static String _currentRoute = '/';

  static KaziPage? get previousPage => _pageResolver?.call(_previousRoute);
  static KaziPage? get currentPage => _pageResolver?.call(_currentRoute);

  static BuildContext? get context =>
      _router?.routerDelegate.navigatorKey.currentContext;

  static GoRouter get router {
    if (_router == null) {
      throw StateError(
        'KaziNavigator not initialized. Call KaziNavigator.init() first.',
      );
    }
    return _router!;
  }

  /// Initialize the navigator with the app's router configuration.
  ///
  /// [pageResolver] maps a route string to the app's [KaziPage] (usually the
  /// enum's `fromRoute`), enabling [currentPage]/[previousPage].
  static void init(
    GoRouter router, {
    KaziPage? Function(String route)? pageResolver,
  }) {
    _router = router;
    _pageResolver = pageResolver;
    _currentRoute = router.routerDelegate.currentConfiguration.uri.toString();
  }

  /// Navigate to a route without pushing to the stack
  static void navigate(KaziPage page, {Object? extra}) {
    final route = page.route;
    _setRoutes(route);
    Log.navigation('Navigating to $route');
    _router?.go(route, extra: extra);
  }

  /// Push a route onto the navigation stack
  static Future<T?> push<T>(KaziPage page, {Object? extra}) {
    final route = page.route;
    _setRoutes(route);
    Log.navigation('Pushing to $route');
    return _router!.push<T>(route, extra: extra);
  }

  /// Pop the current route
  static void pop<T>([T? result]) {
    if (!_router!.canPop()) {
      Log.navigation('Cannot pop - at root');
      return;
    }
    _setRoutes(_previousRoute);
    Log.navigation('Popping route');
    _router!.pop(result);
  }

  /// Show a dialog
  static Future<T?> showDialog<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
  }) {
    Log.navigation('Showing dialog');
    return material.showDialog<T>(
      context: context,
      builder: builder,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      useRootNavigator: useRootNavigator,
    );
  }

  /// Shows a modal bottom sheet — every sheet in the apps opens through here.
  ///
  /// Keeps the content clear of the system navigation bar, which Flutter's
  /// sheet is drawn behind and never pads. A null [backgroundColor] takes the
  /// theme's.
  static Future<T?> showBottomSheet<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    bool showDragHandle = true,
    Color? backgroundColor,
  }) {
    Log.navigation('Showing bottom sheet');
    return showModalBottomSheet<T>(
      context: context,
      builder: (sheetContext) =>
          SafeArea(top: false, child: builder(sheetContext)),
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      showDragHandle: showDragHandle,
      backgroundColor: backgroundColor,
    );
  }

  /// Show a snackbar
  static void showSnackbar(
    BuildContext context,
    String message, {
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 4),
    bool rootNavigator = false,
  }) {
    Log.navigation('Showing snackbar: $message');
    KaziSnackbar.show(
      context,
      message,
      duration: duration.inSeconds,
      rootNavigator: rootNavigator,
    );
  }

  static void _setRoutes(String route) {
    _previousRoute = _currentRoute;
    _currentRoute = route;
  }
}
