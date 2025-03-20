import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Staff/staff_reward_list/staff_add_reward.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Staff/staff_reward_list/staff_edit_reward.dart';
import 'package:system_for_collecting_points_from_plastic_waste/services/api-service.dart';
import 'package:system_for_collecting_points_from_plastic_waste/widget/RewardsWidget.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
            itemQuantityTotal: item['reward_quantity_total'],
            itemImageUrl:"https://c7bd-171-6-139-219.ngrok-free.app/images/${item['reward_image']}",
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

  Future<void> _confirmAndDelete(BuildContext context, int rewardId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Reward"),
          content: Text("Are you sure you want to delete this reward?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // cancel
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // confirm
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      try {
        await apiService.deleteReward(rewardId);
        // Show a success message (optional)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Reward deleted successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete reward')),
        );
      }
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
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(25),
                                            child: Image.network(
                                              item.itemImageUrl,
                                              key: UniqueKey(),
                                              width: 120,
                                              height: 120,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: AutoSizeText(
                                                    item.itemName,
                                                    style: TextStyle(
                                                      fontSize: 20, // Default size
                                                      fontWeight: FontWeight.w600,
                                                      letterSpacing: -0.2,
                                                      height: 1,
                                                    ),
                                                    maxLines: 1, // Limits to 2 lines before shrinking
                                                    minFontSize: 12, // Minimum size it can shrink to
                                                    overflow: TextOverflow.ellipsis, // Adds "..." if still too long
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  '${item.points} แต้ม',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: -0.2,
                                                    height: 1,
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
                                                  '${item.itemQuantity}/${item.itemQuantityTotal}',
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
                                                            StaffEditReward(
                                                              rewardId: item.rewardId,
                                                              rewardName: item.itemName,
                                                              rewardQuantity: item.itemQuantity,
                                                              pointsRequired: item.points,
                                                              rewardImageUrl: item.itemImageUrl,
                                                              rewardType: "stationery", // or another type if needed
                                                            )),
                                                  ).then((_){
                                                    PaintingBinding.instance.imageCache.clear();
                                                    fetchRewards();
                                                  });
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
                                                 _confirmAndDelete(context, item.rewardId).then((_){
                                                    PaintingBinding.instance.imageCache.clear();
                                                    fetchRewards();
                                                  });
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
           Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                  const StaffAddReward()),
          ).then((_){
                  PaintingBinding.instance.imageCache.clear();
                  fetchRewards();
                });
              },
        backgroundColor: Color(0xffFCCA00),
        shape: CircleBorder(),
        child: Icon(Icons.add, size: 30, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
