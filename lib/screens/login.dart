import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Admin/admin_home.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Professor/professor_home.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Staff/staff_home.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Student/navbar.dart';
import 'package:system_for_collecting_points_from_plastic_waste/services/api-service.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _e_passportController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String userRole = '';

  // final GodApitService _godApitService = GodApitService();
  final ApiService _apiService = ApiService();
  final ePassport _ePassport = ePassport();

  Future<void> _login() async {
    final username = _e_passportController.text;
    final password = _passwordController.text;

    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('กรุณากรอก e-Passport'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    } else if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('กรุณากรอก Password'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    try {
      // final response = await _apiService.login(e_passport, password);
      final response = await _ePassport.login(username, password);
      // final prefs = await SharedPreferences.getInstance();
      // final userId = response['id'].toString();
      // await prefs.setString('name', response['name']);
      // await prefs.setString('authToken', response['token']);

      if (response['status'] == 'ok') {
        print(response['username']);
        print(response['firstname']);
        print(response['lastname']);
        print(response['email']);
        print(response['token']);
        print(response['facname']);
        print(response['depname']);

        final ePassport = response['username'].toString();
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', ePassport);

        final userData = await _apiService.saveUser(
          response['username'],
          response['firstname'],
          response['lastname'],
          response['email'],
          response['token'],
          response['facname'],
          response['depname'],
        );

        final userDetails = await _apiService.getUserDetails(response['username']);

        if (userData["role"] == 'admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AdminHomePage()),
          );
        } else if (userData['role'] == 'staff') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => StaffHomePage(userData : userData)),
          );
        } else if (userData['role'] == 'professor') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfessorHomePage(userData : userData)),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => StudentHomePage(userDetails : userDetails)),
          );
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Login สำเร็จ'),
            behavior: SnackBarBehavior.floating,
          ));
        }
      } else {
        // _showErrorDialog();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('e-Passprot หรือ Password ไม่ถูกต้อง'),
          behavior: SnackBarBehavior.floating,
        ));
      }
    } catch (e) {
      print('Login failed: $e');
      // _showErrorDialog();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('e-Passprot หรือ Password ไม่ถูกต้อง'),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEAEAEA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(35),
                ),
                color: Color(0xff00154B),
              ),
              // child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top, bottom: 20),
                child: Center(
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/svg/bin_icon.svg'),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'ระบบสะสมแต้ม\nขยะพลาสติก',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5),
                      ),
                    ],
                  ),
                ),
              ),
              // ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Container(
                height: 300,
                width: 500,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(35), bottom: Radius.circular(35)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 151, 151, 151),
                        spreadRadius: 0.1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      )
                    ]),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 35, horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextField(
                        controller: _e_passportController,
                        decoration: InputDecoration(
                          labelText: 'e-Passport',
                          labelStyle: TextStyle(
                            // color: Colors.black,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        obscureText: true,
                      ),
                      InkWell(
                        onTap: (_login),
                        child: Container(
                          width: 200,
                          height: 50,
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          )),
                          decoration: BoxDecoration(
                              color: Color(0xff01164C),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15),
                                  bottom: Radius.circular(15)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(63, 0, 0, 0),
                                  spreadRadius: 0,
                                  blurRadius: 15,
                                  offset: const Offset(0, 3),
                                )
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
