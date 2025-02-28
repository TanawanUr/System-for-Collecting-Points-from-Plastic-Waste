import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Professor/prof_history/prof_history_details.dart';
import 'package:system_for_collecting_points_from_plastic_waste/widget/prof_history_widget.dart';
import 'package:system_for_collecting_points_from_plastic_waste/services/api-service.dart';


class ProfessorHistoryScreen extends StatefulWidget {
  const ProfessorHistoryScreen({super.key});

  @override
  State<ProfessorHistoryScreen> createState() => _ProfessorHistoryScreenState();
}

class _ProfessorHistoryScreenState extends State<ProfessorHistoryScreen> {
  List<ProfessorHistory> fetchHistoryItem = [];
  bool isLoading = true;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    try {
      List<Map<String, dynamic>> data = await apiService.ProffessorHistory();
      setState(() {
        fetchHistoryItem = data.map((item) {
          return ProfessorHistory(
            e_passport: item['e_passport'],
            fullname: "${item['firstname']} ${item['lastname']}",
            faculty: item['facname'],
            department: item['depname'],
            points: item['points_required'],
            subject: item['reward_name'],
            itemQuantity: 1,
            date: DateTime.parse(item['reviewed_at']),
            status: item['status'],
            reason: item['reason']
          );
        }).toList();
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching history: $e");
      setState(() {
        isLoading = false;
      });
    }
  }
  @override

  Widget build(BuildContext context) {
    // List<ProfessorHistory> historyItems = [
    //   ProfessorHistory(
    //     e_passport: '164404140076',
    //     fullname: 'ธนวันต์ อุรามา',
    //     faculty: 'วิศวกรรมศาสตร์',
    //     department: 'วิศวกรรมคอมพิวเตอร์',
    //     subject: 'การเขียนโปรแกรม',
    //     date: DateTime(2024, 09, 22, 10, 30),
    //     // reason: '',
    //     status: 'อนุมัติ',
    //   ),
    //   ProfessorHistory(
    //     e_passport: '164404140050',
    //     fullname: 'สุรัตน์ บุญเรือง',
    //     faculty: 'วิศวกรรมศาสตร์',
    //     department: 'วิศวกรรมคอมพิวเตอร์',
    //     subject: 'การเขียนโปรแกรม',
    //     date: DateTime(2024, 09, 22, 10, 30),
    //     reason: 'ขาดเกินกำหนด',
    //     status: 'ปฏิเสธ',
    //   ),
    //   ProfessorHistory(
    //     e_passport: '164404140057',
    //     fullname: 'ขจรจัด สุวันน้อย',
    //     faculty: 'วิศวกรรมศาสตร์',
    //     department: 'วิศวกรรมคอมพิวเตอร์',
    //     subject: 'คิดนอกกรอบ',
    //     date: DateTime(2024, 09, 22, 10, 30),
    //     // reason: '',
    //     status: 'อนุมัติ',
    //   ),
    // ];

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
          'ประวัติการทำรายการ',
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
                          itemCount: fetchHistoryItem.length,
                          itemBuilder: (context, index) {
                            final item = fetchHistoryItem[index];
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
                                        context,MaterialPageRoute(builder: (context) => ProfessorHistoryDetailsScreen(item:item), // Passing the item data to the next page
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
