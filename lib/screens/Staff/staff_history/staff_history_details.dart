import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:system_for_collecting_points_from_plastic_waste/widget/staff_history_widget.dart';

class StaffHistoryDetailsPage extends StatefulWidget {
  final StaffHistoryWidget item;
  StaffHistoryDetailsPage({required this.item});

  @override
  State<StaffHistoryDetailsPage> createState() =>
      _StaffHistoryDetailsPageState();
}

class _StaffHistoryDetailsPageState extends State<StaffHistoryDetailsPage> {
  late String e_passport;
  late String fullname;
  late String faculty;
  late String department;

  late int points;
  late String itemName;
  late int itemQuantity;
  late String itemImageUrl;

  late DateTime date;
  late String reason;
  late String status;

  @override
  void initState() {
    super.initState();
    e_passport = widget.item.e_passport;
    fullname = widget.item.fullname;
    faculty = widget.item.faculty;
    department = widget.item.department;

    points = widget.item.points;
    itemName = widget.item.itemName;
    itemQuantity = widget.item.itemQuantity;
    itemImageUrl = widget.item.itemImageUrl;

    date = widget.item.date;
    reason = widget.item.reason;
    status = widget.item.status;
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
          'รายละเอียดเพิ่มเติม',
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
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'ประวัติการทำรายการ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
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
                            _buildStudentDetailsWidget(),
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
                            _builditemDetailsWidget(),
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

  Widget _buildStudentDetailsWidget() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10),
          child: Row(
            children: [
              Text(
                'รายละเอียดผู้ขอ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Color(0xffCECECE),
          thickness: 1,
          height: 1.5,
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'รหัสนักศึกษา : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.2,
                          ),
                        ),
                        TextSpan(
                          text: e_passport,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'ชื่อ - สกุล : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.2,
                          ),
                        ),
                        TextSpan(
                          text: fullname,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'คณะ ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.2,
                          ),
                        ),
                        TextSpan(
                          text: faculty,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'สาขา ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.2,
                          ),
                        ),
                        TextSpan(
                          text: department,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _builditemDetailsWidget() {
    return Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff000000).withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  itemImageUrl,
                  // child: Image.asset(
                  //   'assets/images/pen.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 32),
                child: Text(
                  itemName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'x$itemQuantity',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '- ',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.2,
                        ),
                      ),
                      TextSpan(
                        text: '$points แต้ม',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("ยื่นคำขอเมื่อ",
                    style: TextStyle(
                        fontSize: 16,
                        letterSpacing: -0.2,
                        color: Color(0xff6C6C6C))),
                Text(formatDateTime(date),
                    style: TextStyle(fontSize: 16, letterSpacing: -0.2)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("เหตุผล",
                    style: TextStyle(
                        fontSize: 16,
                        letterSpacing: -0.2,
                        color: Color(0xff6C6C6C))),
                Text(reason,
                    style: TextStyle(fontSize: 16, letterSpacing: -0.2)),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("สถานะ",
                    style: TextStyle(
                        fontSize: 16,
                        letterSpacing: -0.2,
                        color: Color(0xff6C6C6C))),
                Text(status,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                        color: _getStatusColor(status))),
              ],
            ),
          ],
        ),
      ),
    ]);
  }

  String formatDateTime(date) {
    String formattedDateTime = DateFormat('dd/MM/yyyy HH:mm')
        .format(date); 
    return formattedDateTime;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'อนุมัติ':
        return Color(0xff4AAF50);
      case 'ปฏิเสธ':
        return Color(0xffDB3232);
      default:
        return Colors.black;
    }
  }
}
