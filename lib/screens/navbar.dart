import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/History/history.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Home/home.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Map/map.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Profile/profile.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/QrCode/qrcode.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  List screens = [
    Home_Screen(),
    Map_Screen(),
    QrCode_Screen(),
    History_Screen(),
    Profile_Screen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            currentIndex = 2;
          });
        },
        child: FaIcon(
          FontAwesomeIcons.qrcode,
          size: 30,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        backgroundColor: Color(0xff00154B),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        height: 50,
        color: Color.fromARGB(255, 255, 255, 255),
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
                  currentIndex = 3;
                });
              },
              icon: FaIcon(
                FontAwesomeIcons.solidListAlt,
                size: 25,
                color:
                    currentIndex == 3 ? Color(0xff00154B) : Color(0xff6C6C6C),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 4;
                });
              },
              icon: FaIcon(
                FontAwesomeIcons.solidUser,
                size: 25,
                color:
                    currentIndex == 4 ? Color(0xff00154B) : Color(0xff6C6C6C),
              ),
            ),
          ],
        ),
      ),
      body: screens[currentIndex],
    );
  }
}
