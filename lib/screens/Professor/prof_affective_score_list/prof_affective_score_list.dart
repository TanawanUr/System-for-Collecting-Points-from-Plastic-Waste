
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Professor/prof_affective_score_list/prof_affective_score_details.dart';
import 'package:system_for_collecting_points_from_plastic_waste/widget/prof_affective_score_widget.dart';

class ProfessorAffectiveScoreListScreen extends StatefulWidget {
  const ProfessorAffectiveScoreListScreen({super.key});

  @override
  State<ProfessorAffectiveScoreListScreen> createState() => _ProfessorAffectiveScoreListScreenState();
}

class _ProfessorAffectiveScoreListScreenState extends State<ProfessorAffectiveScoreListScreen> {
  @override
  Widget build(BuildContext context) {
    List<ProfessorAffectiveScore> historyItems = [
      ProfessorAffectiveScore(
        e_passport: '164404140076',
        fullname: 'ธนวันต์ อุรามา',
        faculty: 'วิศวกรรมศาสตร์',
        department: 'วิศวกรรมคอมพิวเตอร์',
        subject: 'การเขียนโปรแกรม',
        date: DateTime(2024, 09, 22, 10, 30),
      ),
      ProfessorAffectiveScore(
        e_passport: '164404140050',
        fullname: 'สุรัตน์ บุญเรือง',
        faculty: 'วิศวกรรมศาสตร์',
        department: 'วิศวกรรมคอมพิวเตอร์',
        subject: 'การเขียนโปรแกรม',
        date: DateTime(2024, 09, 22, 10, 30),
      ),
      ProfessorAffectiveScore(
        e_passport: '164404140057',
        fullname: 'ขจรจัด สุวันน้อย',
        faculty: 'วิศวกรรมศาสตร์',
        department: 'วิศวกรรมคอมพิวเตอร์',
        subject: 'คิดนอกกรอบ',
        date: DateTime(2024, 09, 22, 10, 30),
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
        centerTitle: true,
        title: Text(
          'รายการขอจิตพิสัย',
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
                                    leading: FaIcon(FontAwesomeIcons.solidCircleUser,
                                        color: Colors.black, size: 50),
                                    title: Text(item.fullname,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: -0.5)),
                                    subtitle: Container(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(formatDateTime(item.date),
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
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
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
                                        context,MaterialPageRoute(builder: (context) => ProfAffectiveScoreDetailsScreen(item:item), // Passing the item data to the next page
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

  String formatDateTime(date) {
    // DateTime parsedDate = DateTime.parse(date); // Parse the string to DateTime
    String formattedDateTime = DateFormat('dd/MM/yyyy HH:mm').format(date); // Format to dd/MM/yyyy HH:mm
    return formattedDateTime;
  }



}
