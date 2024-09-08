import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Professor/professor_home.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Staff/staff_home.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Student/navbar.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Admin/admin_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;
  String? _role;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final role = prefs.getString('role');

    if (token != null) {
      // Token exists, user is logged in
      setState(() {
        _isLoggedIn = true;
        _role = role;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'NotoSansThai'),
      // routes: {
      //   '/login': (context) => LoginPage(),
      //   '/student': (context) => StudentHomePage(),
      //   '/professor': (context) => ProfessorHomePage(),
      //   '/staff': (context) => StaffHomePage(),
      //   '/admin': (context) => AdminHomePage(),
      // },
      home: _isLoggedIn
          ? _role == 'admin'
              ? AdminHomePage()
              : _role == 'staff'
                  ? StaffHomePage()
                  : _role == 'professor'
                      ? ProfessorHomePage()
                      : _role == 'student'
                          ? StudentHomePage()
                          : LoginPage()
          : LoginPage(),
    );
  }
}
