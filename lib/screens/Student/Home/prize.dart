import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Student/PrizeList/Certificate.dart';
import 'package:system_for_collecting_points_from_plastic_waste/widget/app_buttons.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Student/PrizeList/Stationery.dart';

class PrizeListPage extends StatelessWidget {
  const PrizeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00154B),
      appBar: AppBar(
        backgroundColor: Color(0xff00154B),
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.angleLeft, color: Colors.white),
          // icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'รายการของรางวัล',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffEAEAEA),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(35),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppButtons(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Stationery_Screen()),
                                );
                              },
                              textColor: Color(0xff000000),
                              iconColor: Color(0xffEEC004),
                              backgroundColor: Color(0xffFFFFFF),
                              borderColor: Color.fromARGB(44, 0, 0, 0),
                              text: 'แลกอุปกรณ์การเรียน',
                              textSize: 20,
                              iconSize: 80,
                              width: 200,
                              height: 200,
                              blurRadius: 2,
                              icon: "assets/svg/tools.svg",
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppButtons(
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => const Stationery_Screen()),
                                // );
                              },
                              textColor: Color(0xff000000),
                              iconColor: Color(0xffEEC004),
                              backgroundColor: Color(0xffFFFFFF),
                              borderColor: Color.fromARGB(44, 0, 0, 0),
                              text: 'แลกคะแนนจิตพิสัย',
                              textSize: 20,
                              iconSize: 80,
                              width: 200,
                              height: 200,
                              blurRadius: 2,
                              icon: "assets/svg/star.svg",
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppButtons(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Certificate_Screen()),
                                );
                              },
                              textColor: Color(0xff000000),
                              iconColor: Color(0xffEEC004),
                              backgroundColor: Color(0xffFFFFFF),
                              borderColor: Color.fromARGB(44, 0, 0, 0),
                              text: 'แลกเกียรติบัตร',
                              textSize: 20,
                              iconSize: 80,
                              width: 200,
                              height: 200,
                              blurRadius: 2,
                              icon: "assets/svg/certi.svg",
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
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
