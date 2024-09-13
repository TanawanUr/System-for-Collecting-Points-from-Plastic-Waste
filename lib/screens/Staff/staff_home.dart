import 'package:flutter/material.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Staff/Profile/staff_profile.dart';
import 'package:system_for_collecting_points_from_plastic_waste/widget/app_buttons.dart';

class StaffHomePage extends StatelessWidget {
  const StaffHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00154B),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppBar(
              backgroundColor: Color(0xff00154B),
              title: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text('เจ้าหน้าที่',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    )),
              ),
              centerTitle: false,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: IconButton(
                    icon: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/profile.png'),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StaffProfilePage()));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffEAEAEA),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(45),
                      topLeft: Radius.circular(45),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppButtons(
                              textColor: Colors.white,
                              iconColor: Colors.white,
                              backgroundColor: Color(0xffF9CA10),
                              borderColor: Color(0xffEEC004),
                              text: 'ระบบของรางวัล',
                              textSize: 18,
                              iconSize: 60,
                              width: 165,
                              height: 160,
                              blurRadius: 0,
                              icon: 'assets/svg/present.svg',
                              onPressed: () {
                                // Navigator.push(
                                // context,
                                // MaterialPageRoute(
                                // builder: (context) => const PrizeListPage()),
                                // );
                              },
                            ),
                            AppButtons(
                              textColor: Colors.white,
                              iconColor: Colors.white,
                              backgroundColor: Color(0xffF9CA10),
                              borderColor: Color(0xffEEC004),
                              text: 'รายการขอแลก\nของรางวัล',
                              textSize: 18,
                              iconSize: 60,
                              width: 165,
                              height: 160,
                              blurRadius: 0,
                              icon: 'assets/svg/summary_icon.svg',
                              onPressed: () {
                                // Navigator.push(
                                // context,
                                // MaterialPageRoute(
                                // builder: (context) => const PrizeListPage()),
                                // );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppButtons(
                              textColor: Colors.white,
                              iconColor: Colors.white,
                              backgroundColor: Color(0xffF9CA10),
                              borderColor: Color(0xffEEC004),
                              text: 'กำหนดวันหมดอายุของแต้ม',
                              textSize: 18,
                              iconSize: 55,
                              width: 165,
                              height: 160,
                              blurRadius: 0,
                              icon: 'assets/svg/list_check_icon.svg',
                              onPressed: () {
                                // Navigator.push(
                                // context,
                                // MaterialPageRoute(
                                // builder: (context) => const PrizeListPage()),
                                // );
                              },
                            ),
                            AppButtons(
                              textColor: Colors.white,
                              iconColor: Colors.white,
                              backgroundColor: Color(0xffF9CA10),
                              borderColor: Color(0xffEEC004),
                              text: 'ประวัติการทำรายการ',
                              textSize: 18,
                              iconSize: 60,
                              width: 165,
                              height: 160,
                              blurRadius: 0,
                              icon: 'assets/svg/history_icon.svg',
                              onPressed: () {
                                // Navigator.push(
                                // context,
                                // MaterialPageRoute(
                                // builder: (context) => const PrizeListPage()),
                                // );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
