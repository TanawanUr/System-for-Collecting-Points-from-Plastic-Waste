import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Staff/staff_reward_request_list/staff_reward_request_list_details.dart';
import 'package:system_for_collecting_points_from_plastic_waste/widget/staff_reward_request_list_widget.dart';
import 'package:system_for_collecting_points_from_plastic_waste/services/api-service.dart';

class StaffRewardRequestListPage extends StatefulWidget {
  const StaffRewardRequestListPage({super.key});

  @override
  State<StaffRewardRequestListPage> createState() =>
      _StaffRewardRequestListPageState();
}

class _StaffRewardRequestListPageState extends State<StaffRewardRequestListPage> {
  List<StaffRewardRequestListWidget> rewardRequestList = [];
  bool isLoading = true;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    try {
      List<Map<String, dynamic>> data = await apiService.getStaffRewardRequestList();
      setState(() {
        rewardRequestList = data.map((item) {
          return StaffRewardRequestListWidget(
            requestId: item['request_id'],
            e_passport: item['e_passport'],
            fullname: "${item['firstname']} ${item['lastname']}",
            faculty: item['facname'],
            department: item['depname'],
            points: item['points_required'],
            itemName: item['reward_name'],
            itemQuantity: 1,
            itemImageUrl: "https://c7bd-171-6-139-219.ngrok-free.app/images/${item['reward_image']}",
            date: DateTime.parse(item['requested_at']),
            submitedDate: item['reviewed_at'] != null
                ? DateTime.parse(item['reviewed_at'])
                : DateTime.parse(item['requested_at']),
            status: item['status'],
            reason: item['reason'],
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
          'รายการขอแลก\nของรางวัล',
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
                        child: isLoading
                            ? Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                itemCount: rewardRequestList.length,
                                itemBuilder: (context, index) {
                                  final item = rewardRequestList[index];
                                  return Column(
                                    children: [
                                      Container(
                                        color: Colors.white,
                                        child: ListTile(
                                          leading: FaIcon(
                                            FontAwesomeIcons.solidCircleUser,
                                            color: Colors.black,
                                            size: 50,
                                          ),
                                          title: Text(item.fullname,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: -0.5)),
                                          subtitle: Padding(
                                            padding: const EdgeInsets.only(top: 8),
                                            child: Text(formatDateTime(item.submitedDate),
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
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    StaffRewardRequestListDetailsPage(item: item),
                                              ),
                                            ).then((_){
                                                    PaintingBinding.instance.imageCache.clear();
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
    String formattedDateTime = DateFormat('dd/MM/yyyy HH:mm')
        .format(date); // Format to dd/MM/yyyy HH:mm
    return formattedDateTime;
  }
}
