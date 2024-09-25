import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppButtons extends StatelessWidget {
  final Color textColor;
  final Color iconColor;
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  final String icon;
  final VoidCallback onPressed;
  double textSize;
  double iconSize;
  double width;
  double height;
  double blurRadius;
  AppButtons(
      {super.key,
      required this.textColor,
      required this.iconColor,
      required this.backgroundColor,
      required this.borderColor,
      required this.text,
      required this.textSize,
      required this.iconSize,
      required this.width,
      required this.height,
      required this.blurRadius,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        child: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            SvgPicture.asset(icon,
                color: iconColor, width: iconSize, height: iconSize),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: textSize,
                  fontWeight: FontWeight.w800,
                  height: 1.0,
                  letterSpacing: -0.5,
                ),
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
                blurRadius: blurRadius,
                offset: const Offset(0, 6),
              )
            ]),
      ),
    );
  }
}
