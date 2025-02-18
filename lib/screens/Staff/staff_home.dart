import 'package:flutter/material.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Staff/Profile/staff_profile.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Staff/staff_history/staff_history.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Staff/staff_point_expire_config/staff_point_expire_config.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Staff/staff_reward_list/staff_reward_list.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Staff/staff_reward_request_list/staff_reward_request_list.dart';
import 'package:system_for_collecting_points_from_plastic_waste/widget/app_buttons.dart';

class StaffHomePage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const StaffHomePage({super.key, required this.userData});


  @override
  State<StaffHomePage> createState() => _StaffHomePageState();
}

class _StaffHomePageState extends State<StaffHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00154B),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
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
                      backgroundImage: AssetImage('assets/images/person/profile1.png'),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              // builder: (context) => StaffProfilePage()));
                              builder: (context) => StaffProfilePage(userData: widget.userData)));
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
                              textSize: 20,
                              iconSize: 60,
                              width: 165,
                              height: 160,
                              blurRadius: 0,
                              icon: 'assets/svg/reward.svg',
                              onPressed: () {
                                Navigator.push(
                                context,
                                MaterialPageRoute(
                                builder: (context) => const StaffRewardListPage()),
                                );
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
                                Navigator.push(
                                context,
                                MaterialPageRoute(
                                builder: (context) => const StaffRewardRequestListPage()),
                                );
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
                                Navigator.push(
                                context,
                                MaterialPageRoute(
                                builder: (context) => const StaffPointExpireConfig()),
                                );
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
                                Navigator.push(
                                context,
                                MaterialPageRoute(
                                builder: (context) => const StaffHistoryPage()),
                                );
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
