import 'package:flutter/material.dart';
import 'package:farm_and_food/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEEF1F8),
        fontFamily: 'Intel',
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}