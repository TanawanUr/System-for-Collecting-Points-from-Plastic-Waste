import 'package:flutter/material.dart';
import 'package:system_for_collecting_points_from_plastic_waste/widget/app_buttons.dart';

class History_Screen extends StatefulWidget {
  const History_Screen({super.key});

  @override
  State<History_Screen> createState() => _History_ScreenState();
}

class _History_ScreenState extends State<History_Screen> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: appBar(),
      body: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(35, 30, 0, 0),
                alignment: Alignment.centerLeft,
                child: Text(
                    'รายการล่าสุด', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      height: 1,
                    ),
                  ),
              )
            ],
          ),
      ),
      
    );
  }

  PreferredSize appBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(100),
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
                    'ประวัติการใช้งาน',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}