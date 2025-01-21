import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StaffRewardListPage extends StatefulWidget {
  const StaffRewardListPage({super.key});

  @override
  State<StaffRewardListPage> createState() => _StaffRewardListPageState();
}

class _StaffRewardListPageState extends State<StaffRewardListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00154B),
      appBar: AppBar(
        backgroundColor: Color(0xff00154B),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.angleLeft, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          'รายการของรางวัล',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 34,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            height: 1,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffEAEAEA),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(35),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(35),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("รายการล่าสุด",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.5)),
                              // IconButton(
                              //   onPressed: () {},
                              //   icon: FaIcon(
                              //     FontAwesomeIcons.arrowDownShortWide,
                              //     size: 25,
                              //     color: Colors.black,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        color: Color(0xffEAEAEA),
                        thickness: 1,
                        height: 1.5,
                      ),

                    ],
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
