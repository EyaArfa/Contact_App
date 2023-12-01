import 'package:callapp/services/sqlite_serice.dart';
import 'package:callapp/start/splashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        theme: ThemeData(fontFamily: 'YoungSerif'), home: const SplashScreen());
  }
}
