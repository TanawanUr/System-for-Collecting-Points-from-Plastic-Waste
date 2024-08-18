import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Home/prize.dart';
import 'package:system_for_collecting_points_from_plastic_waste/widget/app_buttons.dart';


class Home_Screen extends StatelessWidget {
  const Home_Screen({super.key});

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
                  MaterialPageRoute(builder: (context) => const PrizeListPage()),
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
              icon: "assets/svg/present.svg",
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
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 0, 18, 63),
                Color.fromARGB(255, 0, 30, 105)
              ],
            ),
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
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Text(
                    '120',
                    style: TextStyle(
                      color: Color(0xffFCCA00),
                      fontSize: 44,
                      fontWeight: FontWeight.w800,
                      height: 1,
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
                    ),
                  ),
                ),
                Text(
                  '12 กันยายน 2567',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
