import 'package:flutter/material.dart';
import 'core/di/dependancy_injection.dart';
import 'core/helper/cash_helper.dart';
import 'core/routs/route.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  appInjection();
  Caching.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute:RoutGenerator.routeGenerate,
    );
  }
}
