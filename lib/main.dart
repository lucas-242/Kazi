import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app/app.dart';
import 'app/services/log_service/log_service.dart';
import 'app/shared/constants/ad_keys.dart';
import 'app/shared/environment/environment.dart';
import 'firebase_options.dart';
import 'injector_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  MobileAds.instance.initialize();
  RequestConfiguration configuration =
      RequestConfiguration(testDeviceIds: AdKeys.testDeviceIds);
  MobileAds.instance.updateRequestConfiguration(configuration);
  initInjectorContainer();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  injector
      .get<LogService>()
      .flow('Environment: ${Environment.environmentValue}');
  runApp(const App());
}
