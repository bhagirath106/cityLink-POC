import 'package:cgc_project/cgc.dart';
import 'package:cgc_project/routing/routing.dart';
import 'package:flutter/material.dart';
import 'di/di.dart';

void main() async {
  const String env = 'dev';
  init(env);
  WidgetsFlutterBinding.ensureInitialized();
  final initialRoute = await AppRouter.getInitialRoute();
  runApp(CgcApp(flavor: env, initialRoute: initialRoute));
}
