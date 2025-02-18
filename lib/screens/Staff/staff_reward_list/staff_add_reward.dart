import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StaffAddReward extends StatefulWidget {
  const StaffAddReward({super.key});

  @override
  State<StaffAddReward> createState() => _StaffAddRewardState();
}

class _StaffAddRewardState extends State<StaffAddReward> {
  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height ;

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
          'เพิ่มของรางวัล',
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
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: availableHeight),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xffEAEAEA),
                      borderRadius: BorderRadius.all(Radius.circular(35)),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xffffffff),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25),
                                bottom: Radius.circular(25),
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 30),
                                Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 214, 214, 214),
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25),
                                      bottom: Radius.circular(25),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "เพิ่มรูป",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 35, vertical: 6),
                                  child: TextField(
                                    style: TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 18,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'ชื่อของรางวัล',
                                      hintStyle: TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 35, vertical: 6),
                                  child: TextField(
                                    style: TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 18,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'จำนวนแต้ม',
                                      hintStyle: TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 18,
                                      ),
                                      suffixText:
                                          'แต้ม', // This text appears at the end
                                      suffixStyle: TextStyle(
                                        color: Color.fromARGB(255, 80, 80, 80),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 35, vertical: 6),
                                  child: TextField(
                                    scrollPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    style: TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 18,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'จำนวนของรางวัล',
                                      hintStyle: TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 18,
                                      ),
                                      suffixText:
                                          'ชิ้น', // This text appears at the end
                                      suffixStyle: TextStyle(
                                        color: Color.fromARGB(255, 80, 80, 80),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                InkWell(
                                  onTap: () {
                                    // showConfirmationDialog(
                                    //     context, item.rewardId);
                                  },
                                  child: Container(
                                    width: 90,
                                    height: 35,
                                    child: Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "ยืนยัน",
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: -0.2,
                                          ),
                                        ),
                                      ],
                                    )),
                                    decoration: BoxDecoration(
                                        color: Color(0xffF9CA10),
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(10),
                                            bottom: Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xffEEC004),
                                            spreadRadius: 1,
                                            blurRadius: 0,
                                            offset: const Offset(0, 2),
                                          )
                                        ]),
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
