import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:system_for_collecting_points_from_plastic_waste/widget/prof_affective_score_widget.dart';
import 'package:system_for_collecting_points_from_plastic_waste/services/api-service.dart';


class ProfAffectiveScoreDetailsScreen extends StatefulWidget {
  final ProfessorAffectiveReqListWidget item;

  ProfAffectiveScoreDetailsScreen({required this.item});

  @override
  State<ProfAffectiveScoreDetailsScreen> createState() =>
      _ProfAffectiveScoreDetailsScreenState();
}

class _ProfAffectiveScoreDetailsScreenState extends State<ProfAffectiveScoreDetailsScreen> {

  final ApiService apiService = ApiService();
  
  late int requestId;
  late String e_passport;
  late String fullname;
  late String faculty;
  late String department;

  late String subject;
  late int points;
  late int itemQuantity;
  late DateTime date;

  @override
  void initState() {
    super.initState();
    requestId = widget.item.requestId;
    e_passport = widget.item.e_passport;
    fullname = widget.item.fullname;
    faculty = widget.item.faculty;
    department = widget.item.department;
    
    subject = widget.item.subject;
    points = widget.item.points;
    itemQuantity = widget.item.itemQuantity;

    date = widget.item.date;
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
                                    'ขอจิตพิสัย',
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
                            _buildSubjectDetailsWidget(),
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
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.2,
                          ),
                        ),
                        TextSpan(
                          text: e_passport.substring(1),
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
                          text: faculty.substring(3),
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

  Widget _buildSubjectDetailsWidget() {
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
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    showDeclinedDialog(context);
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
                      "ปฏิเสธ",
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
                    showConfirmationDialog(context);
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
                      "อนุมัติ",
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
        ),
      ),
    ]);
  }

  String formatDateTime(date) {
   String formattedDateTime = DateFormat('dd/MM/yyyy HH:mm')
        .format(date); 
    return formattedDateTime;
  }


  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("คุณจะอนุมัติ\nรายการนี้ไหม?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
              )),
          actions: <Widget>[
            SizedBox(
              height: 10,
            ),
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
                      color: Color(0xff898989),
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
                  onTap: () async {
                    Navigator.of(context).pop(); // Close the dialog
                    try {
                      int? userId = await apiService.getUserId(); // Get user ID from API
                      if (userId != null) {
                        bool success = await apiService.approveReward(requestId: requestId, approvedBy: userId);
                        if (success) {
                          showSuccessDialog(context, "ส่งคำขอแลกสำเร็จ");
                        } else {
                          showErrorDialog(context, "ไม่สามารถขอแลกได้");
                        }
                      } else {
                        showErrorDialog(context, "ไม่พบข้อมูลผู้ใช้");
                      }
                    } catch (e) {
                      print("Error: $e");
                      showErrorDialog(context, "เกิดข้อผิดพลาด กรุณาลองใหม่");
                    }
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
                      "อนุมัติ",
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

  void showDeclinedDialog(BuildContext context) {
    TextEditingController textController = TextEditingController(); //
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("คุณจะปฏิเสธ\nรายการนี้ไหม?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
              )),
          content: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10), // Optional padding
            child: TextFormField(
              controller: textController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "กรุณาใส่เหตุผล",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          actions: <Widget>[
            SizedBox(
              height: 10,
            ),
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
                      color: Color(0xff898989),
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
                  onTap: () async {
                    if (textController.text.trim().isEmpty) {
                      showErrorDialog(context, "กรุณาใส่เหตุผล");
                      return;
                    }
                    Navigator.of(context).pop(); // Close the dialog
                    try {
                      int? userId = await apiService.getUserId(); // Get user ID from API
                      if (userId != null) {
                        bool success = await apiService.rejectReward(
                          requestId : requestId,
                          approvedBy: userId,
                          reason: textController.text,
                        );
                        if (success) {
                          showSuccessDialog(context, "ส่งคำขอปฏิเสธสำเร็จ");
                        } else {
                          showErrorDialog(context, "ไม่สามารถปฏิเสธได้");
                        }
                      } else {
                        showErrorDialog(context, "ไม่พบข้อมูลผู้ใช้");
                      }
                    } catch (e) {
                      print("Error: $e");
                      showErrorDialog(context, "เกิดข้อผิดพลาด กรุณาลองใหม่");
                    }
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
                      "ปฏิเสธ",
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

  void showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        // Schedule closing of the dialog using the dialog's own context.
        Future.delayed(Duration(seconds: 2), () {
          // Check if the dialog is still mounted in the widget tree.
          if (Navigator.of(dialogContext).canPop()) {
            Navigator.of(dialogContext).pop();
            Navigator.of(dialogContext).pop();
          }
        });

        return AlertDialog(
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 160),
              SizedBox(height: 10),
              Text(
                message,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        // Schedule closing of the dialog using the dialog's own context.
        Future.delayed(Duration(seconds: 2), () {
          if (Navigator.of(dialogContext).canPop()) {
            Navigator.of(dialogContext).pop();
            Navigator.of(dialogContext).pop();
          }
        });

        return AlertDialog(
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error, color: Colors.red, size: 160),
              SizedBox(height: 10),
              Text(
                message,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
