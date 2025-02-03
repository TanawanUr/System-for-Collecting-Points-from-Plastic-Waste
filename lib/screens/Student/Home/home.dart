import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Student/Home/reward.dart';
import 'package:intl/intl.dart';
import 'package:system_for_collecting_points_from_plastic_waste/widget/app_buttons.dart';

class Home_Screen extends StatelessWidget {
  final Map<String, dynamic>? userDetails;

  const Home_Screen({super.key, this.userDetails});
  
   // Function to format date to Thai Buddhist Era (BE)
   String formatThaiDate(String? isoDate) {
    if (isoDate == null || isoDate.isEmpty) return 'ไม่มีวันหมดอายุ';

    try {
      // ✅ Fix: Remove 'Z' if exists to prevent UTC issues
      isoDate = isoDate.replaceAll('Z', '');

      // ✅ Parse to DateTime
      DateTime date = DateTime.parse(isoDate).toLocal(); // Convert to local time

      // ✅ Define Thai Month Names
      List<String> thaiMonths = [
        'มกราคม', 'กุมภาพันธ์', 'มีนาคม', 'เมษายน', 'พฤษภาคม', 'มิถุนายน',
        'กรกฎาคม', 'สิงหาคม', 'กันยายน', 'ตุลาคม', 'พฤศจิกายน', 'ธันวาคม'
      ];

      // ✅ Convert to Thai Buddhist Era (BE)
      int yearBE = date.year + 543;
      String day = date.day.toString();
      String month = thaiMonths[date.month - 1];

      return '$day $month $yearBE';
    } catch (e) {
      print('❌ Error parsing date: $e');
      return 'รูปแบบวันที่ไม่ถูกต้อง';
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 35,
            ),
            AppButtons(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RewardListPage()),
                );
              },
              textColor: Color(0xffFFFFFF),
              iconColor: Color(0xffFFFFFF),
              backgroundColor: Color(0xffF9CA10),
              borderColor: Color(0xffEEC004),
              text: 'แลกของรางวัล',
              textSize: 20,
              iconSize: 60,
              width: 160,
              height: 140,
              blurRadius: 0,
              icon: "assets/svg/reward.svg",
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xffEAEAEA),
    );
  }

  PreferredSize appBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(270),
      child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(35),
            ),
            color: Color(0xff00154B),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 15, 0, 25),
                  child: Text(
                    'คะแนนสะสมปัจจุบัน',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      height: 1,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Text(
                    '${userDetails?['total_points']}',
                    style: TextStyle(
                      color: Color(0xffFCCA00),
                      fontSize: 44,
                      fontWeight: FontWeight.w800,
                      height: 1,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                Text(
                  'แต้ม',
                  style: TextStyle(
                    color: Color(0xffFCCA00),
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    height: 1,
                    letterSpacing: -0.5,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 23, 0, 7),
                  child: Text(
                    'วันหมดอายุคะแนน',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      height: 1,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                Text(
                  formatThaiDate(userDetails?['point_expire']),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    height: 1,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
