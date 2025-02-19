import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Student/Home/reward.dart';
import 'package:intl/intl.dart';
import 'package:system_for_collecting_points_from_plastic_waste/services/api-service.dart';
import 'package:system_for_collecting_points_from_plastic_waste/widget/app_buttons.dart';

class Home_Screen extends StatefulWidget {
  final Map<String, dynamic>? userDetails;

  const Home_Screen({super.key, this.userDetails});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home_Screen> {
  int totalPoints = 0;
  String pointExpireDate = '';
  final ApiService apiService = ApiService();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUpdatedPoints();
  }
  
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
  
  // Fetch updated user details (points & expiration date)
  Future<Map<String, dynamic>> getUserDetails(String ePassport) async {
    // Implement the logic to fetch user details using the ePassport
    // For example, you can call an API service here
    return await apiService.getUserDetails(ePassport);
  }

  Future<void> fetchUpdatedPoints() async {
    try {
      if (widget.userDetails?['e_passport'] != null) {
        var updatedData = await getUserDetails(widget.userDetails!['e_passport']);
        setState(() {
          totalPoints = updatedData['total_points'] ?? 0;
          pointExpireDate = updatedData['point_expire'] ?? '';
          isLoading = false;
        });
      }
    } catch (e) {
      print('❌ Error fetching updated points: $e');
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
                ).then((_){
                  PaintingBinding.instance.imageCache.clear();
                  fetchUpdatedPoints();
                });
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
                    '$totalPoints',
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
                  formatThaiDate(pointExpireDate),
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
