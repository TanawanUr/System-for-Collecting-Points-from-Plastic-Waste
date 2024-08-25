import 'package:flutter/material.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/QrCode/CountingBottle.dart';
import 'package:system_for_collecting_points_from_plastic_waste/widget/app_buttons.dart';


class QrCode_Screen extends StatefulWidget {
  const QrCode_Screen({super.key});

  @override
  State<QrCode_Screen> createState() => _QrCode_ScreenState();
}

class _QrCode_ScreenState extends State<QrCode_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [

            SizedBox(
              height: 105,
            ),
            Text("QrCode"),
            SizedBox(
              height: 105,
            ),
            AppButtons(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CountingBottle()),
                );
              },
              textColor: Color(0xffFFFFFF),
              iconColor: Color(0xffFFFFFF),
              backgroundColor: Color(0xffF9CA10),
              borderColor: Color(0xffEEC004),
              text: 'นับขวด',
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
    );
  }
}