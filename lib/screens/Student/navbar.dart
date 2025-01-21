import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Student/History/history.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Student/Home/home.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Student/Map/map.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Student/Profile/profile.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Student/QrCode/qrcode.dart';

class StudentHomePage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const StudentHomePage({super.key, required this.userData});

  // StudentHomePage({required this.userData});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  int currentIndex = 0;

  late List screens;

  @override
  void initState() {
    super.initState();
    screens = [
      Home_Screen(),
      // Home_Screen(userDetails: widget.userData),
      Map_Screen(),
      History_Screen(),
      Profile_Screen(userData: widget.userData),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: RawMaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QRScannerPage()),
          );
        },
        child: Image.asset(
          'assets/images/qrcode.png',
          height: 55,
          width: 55,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        fillColor: Color(0xff00154B),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Shadow color
              spreadRadius: 10,
              blurRadius: 10,
              offset: Offset(0, 1), // Shadow position
            ),
          ],
        ),
        child: BottomAppBar(
          elevation: 1,
          height: 60,
          color: Colors.white,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 0;
                  });
                },
                icon: FaIcon(
                  FontAwesomeIcons.home,
                  size: 25,
                  color:
                      currentIndex == 0 ? Color(0xff00154B) : Color(0xff6C6C6C),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 1;
                  });
                },
                icon: FaIcon(
                  FontAwesomeIcons.mapMarkedAlt,
                  size: 25,
                  color:
                      currentIndex == 1 ? Color(0xff00154B) : Color(0xff6C6C6C),
                ),
              ),
              SizedBox(
                width: 50,
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 2;
                  });
                },
                icon: FaIcon(
                  FontAwesomeIcons.solidListAlt,
                  size: 25,
                  color:
                      currentIndex == 2 ? Color(0xff00154B) : Color(0xff6C6C6C),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 3;
                  });
                },
                icon: FaIcon(
                  FontAwesomeIcons.solidUser,
                  size: 25,
                  color:
                      currentIndex == 3 ? Color(0xff00154B) : Color(0xff6C6C6C),
                ),
              ),
            ],
          ),
        ),
      ),
      body: screens[currentIndex],
    );
  }
}
