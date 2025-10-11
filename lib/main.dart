import 'package:flutter/material.dart';
import 'core/di/dependancy_injection.dart';
import 'core/routs/route.dart';
void main() {
  appInjection();
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
