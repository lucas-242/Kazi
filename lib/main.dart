import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kazi/app/app_module.dart';

import 'app/app.dart';
import 'app/core/constants/ad_keys.dart';
import 'app/core/environment/environment.dart';
import 'app/services/log_service/log_service.dart';
import 'injector_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  final configuration =
      RequestConfiguration(testDeviceIds: AdKeys.testDeviceIds);
  MobileAds.instance.updateRequestConfiguration(configuration);
  await initInjectorContainer();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  serviceLocator
      .get<LogService>()
      .flow('Environment: ${Environment.environmentValue}');

  return runApp(ModularApp(module: AppModule(), child: const App()));
}
