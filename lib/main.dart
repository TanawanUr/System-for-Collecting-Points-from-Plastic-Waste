import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:system_for_collecting_points_from_plastic_waste/pages/student/home.dart';
import 'package:system_for_collecting_points_from_plastic_waste/pages/student/history.dart';
import 'package:system_for_collecting_points_from_plastic_waste/pages/student/map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        home: const _NavigatebarState());
  }
}

class _NavigatebarState extends StatefulWidget {
  const _NavigatebarState({super.key});

  @override
  State<_NavigatebarState> createState() => __NavigatebarStateState();
}

class __NavigatebarStateState extends State<_NavigatebarState> {
  int index = 0;

  final screens = [
    HomePage(),
    MapPage(),
    HistoryPage(),
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/qrscan');
        },
        child: Icon(Icons.qr_code_scanner, color: Colors.white, size: 40),
        backgroundColor: Color(0xff00154B),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          color: Color(0xffD9D9D9),
        ),
        child: SafeArea(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: NavigationBar(
              height: 60,
              backgroundColor: Color.fromRGBO(217, 217, 217, 1),
              selectedIndex: index,
              onDestinationSelected: (index) =>
                  setState(() => this.index = index),
              destinations: [
                NavigationDestination(
                    icon: FaIcon(FontAwesomeIcons.home), label: 'Home'),
                NavigationDestination(
                    icon: FaIcon(FontAwesomeIcons.mapMarkedAlt), label: 'Map'),
                NavigationDestination(
                    icon: FaIcon(FontAwesomeIcons.solidListAlt),
                    label: 'History'),
                NavigationDestination(
                    icon: FaIcon(FontAwesomeIcons.solidUser), label: 'Profile'),
              ],
            ),
            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     IconButton(
            //       onPressed: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) => HomePage()),
            //         );
            //       },
            //       icon: FaIcon(FontAwesomeIcons.home),
            //       color: Color(0xff6C6C6C),
            //     ),
            //     IconButton(
            //       onPressed: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) => MapPage()),
            //         );
            //       },
            //       icon: FaIcon(FontAwesomeIcons.mapMarkedAlt),
            //       color: Color(0xff6C6C6C),
            //     ),
            //     SizedBox(
            //       width: 40,
            //     ),
            //     IconButton(
            //       onPressed: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(builder: (context) => HistoryPage()),
            //         );
            //       },
            //       icon: FaIcon(FontAwesomeIcons.solidListAlt),
            //       color: Color(0xff6C6C6C),
            //     ),
            //     IconButton(
            //       onPressed: () {
            //         Navigator.pushNamed(context, '/profile');
            //       },
            //       icon: FaIcon(FontAwesomeIcons.solidUser),
            //       color: Color(0xff6C6C6C),
            //     ),
            //   ],
            // ),
          ),
        ),
      ),
    );
  }
}
