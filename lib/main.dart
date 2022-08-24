import 'package:flutter/material.dart';
import 'package:flutter_hw_info_app/screens/main_screen.dart';

void main() {
  runApp(const FlutterHWInfoApp());
}

class FlutterHWInfoApp extends StatelessWidget {
  const FlutterHWInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HW Info',
      theme: ThemeData(brightness: Brightness.dark),
      home: const MainScreen(),
    );
  }
}
