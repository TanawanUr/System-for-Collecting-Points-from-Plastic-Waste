import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Student/History/HistoryDetails.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Student/History/history_affective_details.dart';
import 'package:system_for_collecting_points_from_plastic_waste/widget/RewardPoints.dart';
import 'package:system_for_collecting_points_from_plastic_waste/widget/StudentHistory.dart';
import 'package:system_for_collecting_points_from_plastic_waste/services/api-service.dart';

class History_Screen extends StatefulWidget {
  const History_Screen({super.key});

  @override
  State<History_Screen> createState() => _History_ScreenState();
}

class _History_ScreenState extends State<History_Screen> {
  // List<StudentHistory> historyItems = [];
  List<Object> historyItems = [];
  List<RewardPoints> rewardPointsItems = [];
  bool isLoading = true;
  final ApiService apiService = ApiService();

  String fetchType = 'all'; // Default fetch type
  // String sortType = 'newest'; // Default sorting type

  @override
  void initState() {
    super.initState();
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    try {
      List<Map<String, dynamic>> data =
          await apiService.getRewardHistory(fetchType: fetchType);

      setState(() {
        historyItems = [];

        data.forEach((item) {
          // Filter based on fetchType
          if (fetchType == 'all' || fetchType == item['reward_type']) {
            if (item['reward_name'] != null) {
              historyItems.add(StudentHistory(
                type: item['reward_type'],
                itemName: item['reward_name'],
                date: DateTime.parse(item['requested_at']),
                submitedDate: item['reviewed_at'] != null
                    ? DateTime.parse(item['reviewed_at'])
                    : DateTime.parse(item['requested_at']),
                status: item['status'],
                points: item['points_required'],
                itemQuantity: 1,
                itemImageUrl:
                    "https://c7bd-171-6-139-219.ngrok-free.app/images/${item['reward_image']}",
                reason: item['reason'],
              ));
            } else if (item['reward_points_id'] != null) {
              // If it's a reward point, use the specific name
              historyItems.add(RewardPoints(
                type: item['reward_type'],
                itemName: item['reward_type'] == 'bottle'
                    ? 'แต้มจากขวด'
                    : 'อื่นๆ', // Add a condition for non-bottle types
                date: DateTime.parse(item['requested_at']),
                points: item['points'],
              ));
            }
          }
        });

        isLoading = false;
      });
      } catch (e) {
        print("Error fetching history: $e");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }

  void _showFilterDialog() {
    Map<String, String> displayNames = {
      "ทั้งหมด": "all",
      "ขวด": "bottle",
      "อุปกรณ์การเรียน": "stationery",
      "เกียรติบัตร": "certificate",
      "คะแนนจิตพิสัย": "affective_score",
    };

    String tempFetchType = fetchType;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateDialog) {
            return AlertDialog(
              title: Text(
                'เลือกประเภท',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: displayNames.keys.firstWhere(
                        (key) => displayNames[key] == tempFetchType,
                        orElse: () => "ทั้งหมด"),
                    onChanged: (String? newDisplayName) {
                      setStateDialog(() {
                        tempFetchType = displayNames[newDisplayName!]!;
                      });
                    },
                    items: displayNames.keys
                        .map<DropdownMenuItem<String>>((String displayName) {
                      return DropdownMenuItem<String>(
                        value: displayName,
                        child: Text(
                          displayName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Container(
                    width: 60,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color(0xffEF4644), // Red color
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
                    child: Center(
                      child: Text(
                        "ยกเลิก", // Cancel button text in Thai
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      fetchType = tempFetchType; 
                      fetchHistory();
                    });
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 60,
                    height: 30,
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
                    child: Center(
                      child: Text(
                        "ตกลง", // OK button text in Thai
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                              IconButton(
                                onPressed: _showFilterDialog,
                                icon: FaIcon(
                                  FontAwesomeIcons.arrowDownShortWide,
                                  size: 25,
                                  color: Colors.black,
                                ),
                              ),
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
                            if (item is StudentHistory) {
                              return Column(
                                children: [
                                  Container(
                                    color: Colors.white,
                                    child: ListTile(
                                      leading: SvgPicture.asset(
                                        item.type == 'bottle'
                                            ? 'assets/svg/bottle_icon.svg'
                                            : item.type == 'affective_score'
                                                ? 'assets/svg/book_icon.svg'
                                                : item.type == 'certificate'
                                                    ? 'assets/svg/certi_icon.svg'
                                                    : 'assets/svg/reward_icon.svg',
                                        width: 55,
                                        height: 55,
                                      ),
                                      title: Text(item.itemName,
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
                                            if (item.type == 'stationery')
                                              Text(item.status,
                                                  style: TextStyle(
                                                      color: _getStatusColor(
                                                          item.status),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: -0.2)),
                                            if (item.type == 'certificate')
                                              Text(item.status,
                                                  style: TextStyle(
                                                      color: _getStatusColor(
                                                          item.status),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: -0.2)),
                                            if (item.type == 'affective_score')
                                              Text(item.status,
                                                  style: TextStyle(
                                                      color: _getStatusColor(
                                                          item.status),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: -0.2)),
                                            if (item.type == 'bottle')
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
                                                      text:
                                                          '${item.points} แต้ม',
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
                                            builder: (context) =>
                                                item.type == 'affective_score'
                                                    ? HistoryAffectiveDetails(
                                                        item: item)
                                                    : HistoryDetailsPage(
                                                        item: item),
                                          ),
                                        ).then((_) {
                                          PaintingBinding.instance.imageCache
                                              .clear();
                                          fetchHistory();
                                        });
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
                            } else if (item is RewardPoints) {
                              return Column(
                                children: [
                                  Container(
                                    color: Colors.white,
                                    child: ListTile(
                                      leading: SvgPicture.asset(
                                        item.type == 'bottle'
                                            ? 'assets/svg/bottle_icon.svg'
                                            : item.type == 'affective_score'
                                                ? 'assets/svg/book_icon.svg'
                                                : item.type == 'certificate'
                                                    ? 'assets/svg/certi_icon.svg'
                                                    : 'assets/svg/reward_icon.svg',
                                        width: 55,
                                        height: 55,
                                      ),
                                      title: Text(item.itemName,
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
                                            if (item.type == 'bottle')
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
                                                      text:
                                                          '${item.points} แต้ม',
                                                      style: TextStyle(
                                                        color: Color(
                                                            0xff4AAF50), // Color based on status
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        letterSpacing: -0.2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Color(0xffEAEAEA),
                                    thickness: 1,
                                    height: 1.5,
                                  ),
                                ],
                              );
                            } else {
                              return SizedBox
                                  .shrink(); // In case there's any unexpected item
                            }
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
