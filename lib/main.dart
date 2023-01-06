import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_services/app/services/log_service/log_service.dart';
import 'package:my_services/app/shared/environment/environment.dart';

import 'app/app.dart';
import 'firebase_options.dart';
import 'injector_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
