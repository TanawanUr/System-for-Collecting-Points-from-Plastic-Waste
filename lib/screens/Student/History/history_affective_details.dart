import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:system_for_collecting_points_from_plastic_waste/widget/StudentHistory.dart';

class HistoryAffectiveDetails extends StatefulWidget {
  // const HistoryAffectiveDetails({super.key});
  final StudentHistory item;

  HistoryAffectiveDetails({required this.item});


  @override
  State<HistoryAffectiveDetails> createState() => _HistoryAffectiveDetailsState();
}

class _HistoryAffectiveDetailsState extends State<HistoryAffectiveDetails> {
  late String currentState;
  late String date;
  late String submitedDate;
  late String points;
  late String itemType;
  late String itemName;
  late String itemQuantity;
  late String? reason;



  @override
  void initState() {
    super.initState();
    itemType = widget.item.type;
    date = widget.item.date.toString();
    submitedDate = widget.item.submitedDate.toString();
    points = widget.item.points.toString();
    itemName = widget.item.itemName;
    // description = widget.item.description;
    currentState = widget.item.status;
    itemQuantity = widget.item.itemQuantity.toString();
    reason = widget.item.reason;
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
                              _getStatusWidget(submitedDate),
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
                            _getTitleWidget(itemType),
                            Divider(
                              color: Color(0xffCECECE),
                              thickness: 1,
                              height: 1.5,
                            ),
                            _buildSubjectDetailsWidget(date, points, itemType, itemName,
                                itemQuantity,reason),
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

  Widget _getStatusWidget(submitedDate) {
    switch (currentState) {
      case 'อนุมัติ':
        return _buildStatusWidget(
          title: "คำขอได้รับการอนุมัติ",
          icon: Icons.check_circle,
          iconColor: Color(0xff4AAF50),
          message: formatDateTime(submitedDate),
        );
      case 'กำลังรออนุมัติ':
        return _buildStatusWidget(
          title: "รอดำเนินการอนุมัติ",
          icon: Icons.hourglass_empty,
          iconColor: Color(0xffFCCA00),
          message: formatDateTime(submitedDate),
        );
      case 'ยกเลิก':
        return _buildStatusWidget(
          title: "คำขอได้ถูกยกเลิก",
          icon: Icons.cancel,
          iconColor: Color(0xffDB3232),
          message: formatDateTime(submitedDate),
        );
      case 'สำเร็จ':
        return _buildStatusWidget(
          title: "การดำเนินการสำเร็จ",
          icon: Icons.check_circle,
          iconColor: Color(0xff4AAF50),
          message: formatDateTime(submitedDate),
        );
      default:
        return Text("Unknown State");
    }
  }

  Widget _buildStatusWidget(
      {required String title,
      IconData? icon,
      Color? iconColor,
      required String message}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5),
            ),
            SizedBox(height: 10),
            Text(
              'เมื่อ $message',
              style: TextStyle(
                  fontSize: 16, letterSpacing: -0.2, color: Color(0xff464646)),
            ),
          ],
        ),
        Icon(icon, color: iconColor, size: 60),
      ],
    );
  }
}

  Widget _buildSubjectDetailsWidget(date, points, itemType, subject, itemQuantity, reason) {
    return Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                Text.rich(TextSpan(
                  text: 'รายวิชา   ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                )),
                Text.rich(TextSpan(
                  text: subject,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.5,
                  ),
                )),
              ],
            ),
            // SizedBox(height: 10),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text("สถานะ",
            //         style: TextStyle(
            //             fontSize: 16,
            //             letterSpacing: -0.2,
            //             color: Color(0xff6C6C6C))),
            //     Text(status,
            //         style: TextStyle(
            //             fontSize: 18,
            //             fontWeight: FontWeight.w700,
            //             letterSpacing: -0.2,
            //             color: _getStatusColor(status))),
            //   ],
            // ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("ยื่นคำขอเมื่อ",
                    style: TextStyle(
                        fontSize: 16,
                        letterSpacing: -0.2,
                        color: Color(0xff6C6C6C))),
                Text(formatDateTime(date),
                    style: TextStyle(
                        fontSize: 15,
                        letterSpacing: -0.2,
                        color: Colors.black)),
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
                Text(reason ?? '-',
                    style: TextStyle(
                        fontSize: 16,
                        letterSpacing: -0.2,
                        color: Colors.black)),
              ],
            ),
          ],
        ),
      ),
    ]);
  }

String formatDateTime(date) {
  DateTime parsedDate = DateTime.parse(date); // Parse the string to DateTime
  String formattedDateTime = DateFormat('dd/MM/yyyy HH:mm').format(parsedDate); // Format to dd/MM/yyyy HH:mm
  return formattedDateTime;
}
String formatSubmitedDate(submitedDate) {
  DateTime parsedDate = DateTime.parse(submitedDate); // Parse the string to DateTime
  String formattedDateTime = DateFormat('dd/MM/yyyy HH:mm').format(parsedDate); // Format to dd/MM/yyyy HH:mm
  return formattedDateTime;
}

Widget _getTitleWidget(itemType) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    child: Row(
      children: <Widget>[
        SvgPicture.asset(
          itemType == 'collect'
                    ? 'assets/svg/bottle_icon_black.svg'
                    : itemType == 'affective_score'
                        ? 'assets/svg/book_icon_black.svg'
                        : itemType == 'certificate'
                            ? 'assets/svg/certi_icon_black.svg'
                            : 'assets/svg/reward_icon_black.svg',
          width: 55,
          height: 55,
        ),
        SizedBox(width: 16),
        Text(itemType == 'collect' 
        ? 'ใส่ขวด' 
        : itemType == 'affective_score'
            ? 'คะแนนจิตพิสัย'
            : itemType == 'certificate'
                ? 'เกียติบัตร'
                : 'ของรางวัล',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            )),
      ],
    ),
  );
}
