import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Staff/staff_reward_list/staff_add_reward.dart';
import 'package:system_for_collecting_points_from_plastic_waste/services/api-service.dart';
import 'package:system_for_collecting_points_from_plastic_waste/widget/RewardsWidget.dart';

class StaffRewardListPage extends StatefulWidget {
  const StaffRewardListPage({super.key});

  @override
  State<StaffRewardListPage> createState() => _StaffRewardListPageState();
}

class _StaffRewardListPageState extends State<StaffRewardListPage> {
  final ApiService apiService = ApiService();
  List<RewardsWidget> StationeryItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRewards();
  }

  Future<void> fetchRewards() async {
    try {
      List<Map<String, dynamic>> data = await apiService.getRewards();

      setState(() {
        StationeryItems = data.map((item) {
          return RewardsWidget(
            rewardId: item['reward_id'],
            points: item['points_required'],
            itemName: item['reward_name'],
            itemQuantity: item['reward_quantity'],
            itemImageUrl:
                "http://192.168.196.81:3000/images/reward_${item['reward_id']}.png",
          );
        }).toList();
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching rewards: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
          'รายการของรางวัล',
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
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(27)),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xffEAEAEA),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(27),
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          padding: EdgeInsets.only(bottom: 110),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: StationeryItems.length,
                          itemBuilder: (context, index) {
                            final item = StationeryItems[index];
                            return Container(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 10),
                                child: Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      width: 200,
                                      height: 255,
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
                                            height: 15,
                                          ),
                                          Image.network(
                                            item.itemImageUrl,
                                            width: 120,
                                            height: 120,
                                          ),
                                          SizedBox(
                                            height: 15,
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
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const StaffAddReward()),
                                                  );
                                                  // showConfirmationDialog(
                                                  //     context, item.rewardId);
                                                },
                                                child: Container(
                                                  width: 50,
                                                  height: 24,
                                                  child: Center(
                                                      child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "แก้ไข",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xffffffff),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700,
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
                                                              top: Radius
                                                                  .circular(10),
                                                              bottom: Radius
                                                                  .circular(
                                                                      10)),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color:
                                                              Color(0xffEEC004),
                                                          spreadRadius: 1,
                                                          blurRadius: 0,
                                                          offset: const Offset(
                                                              0, 2),
                                                        )
                                                      ]),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  // showConfirmationDialog(
                                                  //     context, item.rewardId);
                                                },
                                                child: Container(
                                                  width: 50,
                                                  height: 24,
                                                  child: Center(
                                                      child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "ลบ",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xffffffff),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          letterSpacing: -0.2,
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                  decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 242, 82, 82),
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
                                                          color: Color.fromARGB(
                                                              255, 206, 70, 70),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Add Reward button pressed");
        },
        backgroundColor: Color(0xffFCCA00),
        shape: CircleBorder(),
        child: Icon(Icons.add, size: 30, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
