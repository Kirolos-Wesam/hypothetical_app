import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hypothetical_app/app.dart';

import 'package:hypothetical_app/core/src/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await di.initAppModule();
  runApp(const MyApp());
}
