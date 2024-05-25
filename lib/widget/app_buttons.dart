import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppButtons extends StatelessWidget {
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  final String icon;
  double width;
  double height;
  AppButtons(
    {super.key,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.text,
    required this.width,
    required this.height,
    required this.icon}
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Center(
          child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          SvgPicture.asset(icon ,color: textColor , width: 60, height: 60),
          SizedBox(
            height: 10,
          ),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      )),
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(35), bottom: Radius.circular(35)),
        boxShadow: [
          BoxShadow(
            color: borderColor,
            spreadRadius: 1,
            blurRadius: 0,
            offset: const Offset(0, 6),
          )
        ]
      ),
    );
  }
}
