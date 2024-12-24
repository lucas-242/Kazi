import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kazi/app/shared/utils/log_utils.dart';

import 'app/app.dart';
import 'app/shared/environment/environment.dart';
import 'firebase_options.dart';
import 'injector_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  MobileAds.instance.initialize();
  await initInjectorContainer();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  Log.flow('Environment: ${Environment.environmentValue}');
  runApp(const App());
}
