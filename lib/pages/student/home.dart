import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
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
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 25),
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
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
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
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 23, 0, 7),
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
      ),
    );
  }
}
