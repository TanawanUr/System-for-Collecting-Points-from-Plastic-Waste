import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Student/History/HistoryDetails.dart';
import 'package:system_for_collecting_points_from_plastic_waste/widget/StudentHistory.dart';

class History_Screen extends StatefulWidget {
  const History_Screen({super.key});

  @override
  State<History_Screen> createState() => _History_ScreenState();
}

class _History_ScreenState extends State<History_Screen> {
  @override
  Widget build(BuildContext context) {
    List<StudentHistory> historyItems = [
      StudentHistory(
        type: 'collect',
        description: 'ใส่ขวด',
        date: DateTime(2024, 09, 22, 10, 30),
        submitedDate: DateTime(2021, 10, 1),
        status: 'สำเร็จ',
        points: 50,
        itemName: 'ขวดพลาสติก',
        itemQuantity: 50,
        itemImageUrl: 'http://172.20.10.3:3000/images/plastic_bottle.png',
      ),
      StudentHistory(
        type: 'trade',
        description: 'แลกของรางวัล',
        date: DateTime(2024, 09, 01, 10, 30),
        submitedDate: DateTime(2024, 09, 30),
        status: 'กำลังรออนุมัติ',
        points: 20,
        itemName: 'ปากกา',
        itemQuantity: 4,
        itemImageUrl: 'http://172.20.10.3:3000/images/pen.png',
        // reason: '',
      ),
      StudentHistory(
        type: 'trade',
        description: 'แลกของรางวัล',
        date: DateTime(2024, 08, 30, 10, 30),
        submitedDate: DateTime(2024, 01, 18),
        status: 'อนุมัติ',
        points: 50,
        itemName: 'ยางลบ',
        itemQuantity: 5,
        itemImageUrl: 'http://172.20.10.3:3000/images/eraser.png',
        // reason: '',
      ),
      StudentHistory(
        type: 'collect',
        description: 'ใส่ขวด',
        date: DateTime(2024, 07, 14, 10, 30),
        submitedDate: DateTime(2024, 06, 14, 10, 30),
        status: 'สำเร็จ',
        points: 10,
        itemName: 'ขวดพลาสติก',
        itemQuantity: 10,
        itemImageUrl: 'http://172.20.10.3:3000/images/plastic_bottle.png',
        // reason: '',
      ),
      StudentHistory(
        type: 'trade',
        description: 'แลกของรางวัล',
        date: DateTime(2024, 05, 27, 10, 30),
        submitedDate: DateTime(2025, 01, 21),
        status: 'ยกเลิก',
        points: 30,
        itemName: 'ดินสอ',
        itemQuantity: 1,
        itemImageUrl: 'http://172.20.10.3:3000/images/pencil.png',
        reason: 'ของรางวัลหมด',
      ),
    ];

    return Scaffold(
      backgroundColor: Color(0xff00154B),
      appBar: AppBar(
        backgroundColor: Color(0xff00154B),
        surfaceTintColor: Colors.transparent,
        title: Text(
          'ประวัติการใช้งาน',
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
                      Expanded(
                        child: ListView.builder(
                          itemCount: historyItems.length,
                          itemBuilder: (context, index) {
                            final item = historyItems[index];
                            return Column(
                              children: [
                                Container(
                                  color: Colors.white,
                                  child: ListTile(
                                    leading: SvgPicture.asset(
                                      item.type == 'collect'
                                          ? 'assets/svg/bottle_icon.svg'
                                          : 'assets/svg/reward_icon.svg',
                                      width: 55,
                                      height: 55,
                                    ),
                                    title: Text(item.description,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: -0.5)),
                                    subtitle: Container(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(_formatTime(item.date),
                                          style: TextStyle(
                                              color: Color(0xff136BFF),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: -0.2)),
                                    ),
                                    trailing: Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          if (item.type == 'trade')
                                            Text(item.status,
                                                style: TextStyle(
                                                    color: _getStatusColor(
                                                        item.status),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: -0.2)),
                                          if (item.type == 'collect')
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: '+ ',
                                                    style: TextStyle(
                                                      color: Colors
                                                          .green, // Set the '+' to green
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: -0.2,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: '${item.points} แต้ม',
                                                    style: TextStyle(
                                                      color: _getStatusColor(item
                                                          .status), // Color based on status
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: -0.2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          Text('แสดงเพิ่มเติม',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xff136BFF),
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: -0.2)),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HistoryDetailsPage(
                                              item:
                                                  item), // Passing the item data to the next page
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Divider(
                                  color: Color(0xffEAEAEA),
                                  thickness: 1,
                                  height: 1.5,
                                ),
                              ],
                            );
                          },
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

  String _formatTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} วินาทีที่แล้ว';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} นาทีที่แล้ว';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ชั่วโมงที่แล้ว';
    } else {
      return '${difference.inDays} วันที่แล้ว';
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'อนุมัติ':
        return Color(0xff4AAF50);
      case 'กำลังรออนุมัติ':
        return Color(0xffFCCA00);
      case 'ยกเลิก':
        return Color(0xffDB3232);
      default:
        return Colors.black;
    }
  }
}
