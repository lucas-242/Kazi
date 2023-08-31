import 'package:kazi/app/core/errors/errors.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/services/log_service/log_service.dart';
import 'package:kazi/injector_container.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class UrlLauncherHelper {
  static Future<void> launch(String url) async {
    if (url.isEmpty) {}

    final uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
      serviceLocator<LogService>()
          .error(error: AppLocalizations.current.errorLaunchUrl(url));
      throw ExternalError(AppLocalizations.current.errorLaunchUrl(url));
    }
  }
}
