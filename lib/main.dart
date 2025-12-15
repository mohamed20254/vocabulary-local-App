import 'package:flutter/material.dart';
import 'package:vocabulary/config/initialized/init.dart' as di;
import 'package:vocabulary/config/theme/app_theme.dart';
import 'package:vocabulary/presentation/screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(final BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.appTheme,
      home: const HomeScreen(),
    );
  }
}
