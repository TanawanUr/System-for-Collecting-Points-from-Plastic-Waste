import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/login.dart';

class AdminProfilePage extends StatelessWidget {
  const AdminProfilePage({super.key});

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    // Clear the stored token
    await prefs.remove('authToken');

    // Navigate back to the login page
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(35),
                ),
                color: Color(0xff00154B)),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.angleLeft,
                          color: Colors.white, 
                          size: 25
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: SizedBox(
                            height: 150,
                            width: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image(
                                image: AssetImage("assets/images/profile.png"),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        // IconButton(
                        //   icon: Icon(
                        //     Icons.logout,
                        //     color: Colors.white,
                        //   ),
                        //   onPressed: () => _logout(context),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Admin",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      height: 1.7,
                    ),
                  ),
                  Text(
                    "ผู้ดูแลระบบ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                  Text(
                    "สาขา วิศวกรรมคอมพิวเตอร์",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const BottomNavBar()),
                    // );
                  },
                  child: Container(
                    width: 400,
                    height: 50,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'ตั้งค่า',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    )),
                    decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10),
                            bottom: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(63, 0, 0, 0),
                            spreadRadius: 0,
                            blurRadius: 5,
                            offset: const Offset(0, 1),
                          )
                        ]),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () => _logout(context),
                  child: Container(
                    width: 360,
                    height: 50,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'ออกจากระบบ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    )),
                    decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10),
                            bottom: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(63, 0, 0, 0),
                            spreadRadius: 0,
                            blurRadius: 5,
                            offset: const Offset(0, 1),
                          )
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xffEAEAEA),
    );
  }
}
