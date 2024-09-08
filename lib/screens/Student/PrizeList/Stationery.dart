import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:system_for_collecting_points_from_plastic_waste/widget/ItemsWidget.dart';

class Stationery_Screen extends StatelessWidget {
  const Stationery_Screen({super.key});

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
          'อุปกรณ์การเรียน',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            // ItemsWidget(),
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
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                        ItemsWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
