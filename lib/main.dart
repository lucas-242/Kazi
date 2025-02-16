import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kazi/app/shared/utils/log_utils.dart';

import 'app/app.dart';
import 'app/shared/environment/environment.dart';
import 'injector_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InjectorContainer.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  Log.flow('Environment: ${Environment.environmentValue}');

  runApp(const App());
}
