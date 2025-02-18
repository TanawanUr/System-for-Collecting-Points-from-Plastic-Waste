import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StaffPointExpireConfig extends StatefulWidget {
  const StaffPointExpireConfig({super.key});

  @override
  State<StaffPointExpireConfig> createState() => _StaffPointExpireConfigState();
}

class _StaffPointExpireConfigState extends State<StaffPointExpireConfig> {
    TextEditingController dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        dateController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00154B),
      appBar: AppBar(
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.angleLeft, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(0xff00154B),
        surfaceTintColor: Colors.transparent,
        title: Text(
          'กำหนดวันหมดอายุ\nของแต้ม',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            height: 1,
          ),
        ),
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
                        topLeft: Radius.circular(35)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(35),
                              topLeft: Radius.circular(35)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                            bottom: 15,
                            left: 20,
                            right: 20,
                          ),
                          child: Column(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'วันหมดอายุของแต้มปัจจุบัน',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("12 กันยายน 2567",
                                      // Text(data['expire_date'],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.5,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 15,
                                bottom: 20,
                                left: 20,
                                right: 20,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'อัปเดทวันหมดอายุของแต้ม',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 30,
                                    ),
                                    child: TextField(
                                      controller: dateController,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        labelText: "Select Date",
                                        suffixIcon: IconButton(
                                          icon: Icon(Icons.calendar_today),
                                          onPressed: () => _selectDate(context),
                                        ),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                    InkWell(
                                      onTap: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           const StaffAddReward()),
                                        // );
                                        // showConfirmationDialog(
                                        //     context, item.rewardId);
                                      },
                                      child: Container(
                                        width: 100,
                                        height: 35,
                                        child: Center(
                                            child: Column(mainAxisAlignment:MainAxisAlignment.center,
                                              crossAxisAlignment:CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "ยืนยัน",
                                              style: TextStyle(
                                                color:
                                                    Color(0xffffffff),
                                                fontSize: 24,
                                                fontWeight:
                                                    FontWeight.w700,
                                                letterSpacing: -0.2,
                                              ),
                                            ),
                                          ],
                                        )),
                                        decoration: BoxDecoration(
                                            color: Color(0xff4AAF50),
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.vertical(
                                                    top: Radius
                                                        .circular(10),
                                                    bottom: Radius
                                                        .circular(
                                                            10)),
                                            boxShadow: [
                                              BoxShadow(
                                                color:
                                                    Color.fromARGB(255, 66, 156, 72),
                                                spreadRadius: 1,
                                                blurRadius: 0,
                                                offset: const Offset(
                                                    0, 2),
                                              )
                                            ]),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: Column(
                          children: [
                            // _builditemDetailsWidget(),
                          ],
                        ),
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
