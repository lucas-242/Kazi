import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kazi_core/kazi_core.dart';

import 'app.dart';
import 'core/constants/ad_keys.dart';
import 'core/environment/environment.dart';
import 'service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  final configuration =
      RequestConfiguration(testDeviceIds: AdKeys.testDeviceIds);
  MobileAds.instance.updateRequestConfiguration(configuration);
  await ServiceLocator.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  Log.flow('Environment: ${Environment.environmentValue}');

  return runApp(const App());
}
