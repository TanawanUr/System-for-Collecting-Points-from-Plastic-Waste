import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:system_for_collecting_points_from_plastic_waste/widget/CertificateWidget.dart';

class Certificate_Screen extends StatefulWidget {
  const Certificate_Screen({super.key});

  @override
  State<Certificate_Screen> createState() => _Certificate_ScreenState();
}

class _Certificate_ScreenState extends State<Certificate_Screen> {
  @override
  Widget build(BuildContext context) {


    List<CertificateWidget> CertificateItem = [
      CertificateWidget(
        points: 250,
        itemName: 'เกียรติบัตร',
        itemQuantity: 63,
        itemImageUrl: 'https://i.ibb.co/j3mTb5P/certificate.png',
      ),
      CertificateWidget(
        points: 300,
        itemName: 'เกียรติบัตร',
        itemQuantity: 26,
        itemImageUrl: 'https://i.ibb.co/j3mTb5P/certificate.png',
      ),
    ];



      return Scaffold(
     backgroundColor: Color(0xff00154B),
      appBar: AppBar(
        backgroundColor: Color(0xff00154B),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.angleLeft, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'เกียรติบัตร',
          style: TextStyle(
            color: Colors.white,
            fontSize: 34,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            height: 1,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xffEAEAEA),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(35),
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 1.35,
                          ),
                          itemCount: CertificateItem.length,
                          itemBuilder: (context, index) {
                            final item = CertificateItem[index];
                            return Container(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 50, right: 50, top: 20),
                                child: Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      width: 450,
                                      height: 270,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(0,
                                                2), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Image.network(
                                            item.itemImageUrl,
                                            height: 140,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  item.itemName,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: -0.2,
                                                    height: 1,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  '${item.points} แต้ม',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: -0.2,
                                                    height: 1,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '${item.itemQuantity}/100',
                                                  style: TextStyle(
                                                    color: Color(0xff136BFF),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    letterSpacing: -0.2,
                                                    height: 1,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              showConfirmationDialog(context);
                                            },
                                            child: Container(
                                              width: 55,
                                              height: 27,
                                              child: Center(
                                                  child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "แลก",
                                                    style: TextStyle(
                                                      color: Color(0xffffffff),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      letterSpacing: -0.2,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                              decoration: BoxDecoration(
                                                  color: Color(0xffFCCA00),
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                          top: Radius.circular(
                                                              10),
                                                          bottom:
                                                              Radius.circular(
                                                                  10)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0xffEEC004),
                                                      spreadRadius: 1,
                                                      blurRadius: 0,
                                                      offset:
                                                          const Offset(0, 2),
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
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("คุณแน่ใจที่จะแลก\nของชิ้นนี้ไหม?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
              )),
          actions: <Widget>[
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: Color(0xffEF4644),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        )
                      ],
                    ),
                    child: Text(
                      "ยกเลิก",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop(); // Close the dialog
                    showGreenCheckAndNavigate(context);
                  },
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: Color(0xff4AAF50),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        )
                      ],
                    ),
                    child: Text(
                      "แลก",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void showGreenCheckAndNavigate(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing the dialog while waiting
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: InkWell(
            onTap: () {
              Navigator.of(context).pop(); // Close the green check dialog
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  color: Color(0xff4AAF50),
                  size: 160,
                ),
                SizedBox(height: 10),
                Text("แลกของสำเร็จ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5
                    )),
              ],
            ),
          ),
        );
      },
    );

    // Delay for 2 seconds then go to home screen
    // Timer(Duration(seconds: 2), () {
    //   if (Navigator.of(context).canPop()) {
    //     Navigator.of(context).pop(); // Close the green check dialog
    //   }
    //   // if (mounted) {
    //   //   Navigator.of(context).pushReplacementNamed('/home'); // Navigate to home screen
    //   // }
    // });
  }
}

