import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:system_for_collecting_points_from_plastic_waste/widget/app_buttons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            // GestureDetector(
            //   onTap: () {
            //     Navigator.pushNamed(context, '/map');
            //   },
            //   child: AppButtons(
            //     textColor: Color(0xffFFFFFF),
            //     backgroundColor: Color(0xffF9CA10),
            //     borderColor: Color(0xffEEC004),
            //     text: 'สแกน QR Code',
            //     width: 160,
            //     height: 140,
            //     icon: "assets/svg/qr-code.svg",
            //   ),
            // ),

            AppButtons(
              textColor: Color(0xffFFFFFF),
              backgroundColor: Color(0xffF9CA10),
              borderColor: Color(0xffEEC004),
              text: 'แลกของรางวัล',
              width: 160,
              height: 140,
              icon: "assets/svg/present.svg",
            ),
          ],
        ),
      ),



      
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/qrscan');
        },
        child: Icon(Icons.qr_code_scanner, color: Colors.white, size: 40),
        backgroundColor: Color(0xff00154B),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            color: Color(0xffD9D9D9),
        ),
        // bottomNavigationBar: BottomAppBar(
        // height: 50,
        // padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        // shape: BoxShape.rectangle,
        // borderRadius: BorderRadius.vertical(
        //   bottom: Radius.circular(35),
        // ),

        // color: Color(0xffD9D9D9),
        child: SafeArea(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  icon: FaIcon(FontAwesomeIcons.home),
                  color: Color(0xff6C6C6C),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/map');
                  },
                  icon: FaIcon(FontAwesomeIcons.mapMarkedAlt),
                  color: Color(0xff6C6C6C),
                ),
                SizedBox(
                  width: 40,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/history');
                  },
                  icon: FaIcon(FontAwesomeIcons.solidListAlt),
                  color: Color(0xff6C6C6C),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                  icon: FaIcon(FontAwesomeIcons.solidUser),
                  color: Color(0xff6C6C6C),
                ),
              ],
            ),
          ),
        ),
      ),
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
