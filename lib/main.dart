import 'package:flutter/material.dart';
import 'package:system_for_collecting_points_from_plastic_waste/pages/student/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'NotoSansThai'),
        home: const HomePage());
  }
}
