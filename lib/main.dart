import 'package:flutter/material.dart';
import 'package:farm_and_food/screens/home.dart';
import 'package:farm_and_food/constants/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        fontFamily: 'Intel',
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}