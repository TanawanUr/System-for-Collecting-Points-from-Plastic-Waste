import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:system_for_collecting_points_from_plastic_waste/services/api-service.dart';
import 'package:system_for_collecting_points_from_plastic_waste/widget/prof_list.dart';

class ProfessorList extends StatefulWidget {
  const ProfessorList({super.key});

  @override
  State<ProfessorList> createState() => _ProfessorListState();
}

class _ProfessorListState extends State<ProfessorList> {
  List<ProfessorListMap> affectiveList = [];
  bool isLoading = true;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    try {
      List<Map<String, dynamic>> data = await apiService.getProfessorList();
      setState(() {
        affectiveList = data.map((item) {
          return ProfessorListMap(
            fullname: item['fullname'],
            subject: item['reward_name'],
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
          'ตารางรายชื่อนักศึกษา',
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("รายชื่อ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.5)),
                              SizedBox(width: 30),
                              Text("รายวิชา",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.5)),
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
                        child:  isLoading
                            ? Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                itemCount: affectiveList.length,
                                itemBuilder: (context, index) {
                                  final item = affectiveList[index];
                                  return Column(
                          children: [
                            Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 20, left: 20, top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: AutoSizeText(
                                          item.fullname,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: -0.5,
                                          ),
                                          maxLines: 1,
                                          minFontSize: 12,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Flexible(
                                        child: AutoSizeText(
                                          item.subject,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: -0.5,
                                          ),
                                          maxLines: 1,
                                          minFontSize: 12,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            Divider(
                              color: Color(0xffEAEAEA),
                              thickness: 1,
                              height: 1.5,
                            ),
                          ],
                        );
                                },
                              ),
                      )

                      // Expanded(
                      //   child: isLoading
                      //       ? Center(child: CircularProgressIndicator())
                      //       : ListView.builder(
                      //           itemCount: affectiveReqList.length,
                      //           itemBuilder: (context, index) {
                      //             final item = affectiveReqList[index];
                      //             return Column(
                      //         children: [
                      //           Container(
                      //             color: Colors.white,
                      //             child: ListTile(
                      //               leading: FaIcon(FontAwesomeIcons.solidCircleUser,
                      //                   color: Colors.black, size: 50),
                      //               title: Text(item.fullname,
                      //                   style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontSize: 20,
                      //                       fontWeight: FontWeight.w700,
                      //                       letterSpacing: -0.5)),
                      //               subtitle: Container(
                      //                 padding: const EdgeInsets.only(top: 8),
                      //                 child: Text(formatDateTime(item.date),
                      //                     style: TextStyle(
                      //                         color: Color(0xff136BFF),
                      //                         fontSize: 13,
                      //                         fontWeight: FontWeight.w400,
                      //                         letterSpacing: -0.2)),
                      //               ),
                      //               trailing: Padding(
                      //                 padding: const EdgeInsets.only(top: 5),
                      //                 child: Column(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.end,
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.end,
                      //                   children: [
                      //                     Text('แสดงเพิ่มเติม',
                      //                         style: TextStyle(
                      //                             fontSize: 13,
                      //                             color: Color(0xff136BFF),
                      //                             fontWeight: FontWeight.w400,
                      //                             letterSpacing: -0.2)),
                      //                   ],
                      //                 ),
                      //               ),
                      //               onTap: () {
                      //                       Navigator.push(
                      //                         context,
                      //                         MaterialPageRoute(
                      //                           builder: (context) =>
                      //                               ProfAffectiveScoreDetailsScreen(item: item),
                      //                         ),
                      //                       ).then((_){
                      //                               PaintingBinding.instance.imageCache.clear();
                      //                               fetchHistory();
                      //                             });
                      //                     },
                      //             ),
                      //           ),
                      //           Divider(
                      //             color: Color(0xffEAEAEA),
                      //             thickness: 1,
                      //             height: 1.5,
                      //           ),
                      //         ],
                      //       );
                      //     },
                      //   ),
                      // ),

                    ]
                ),
              ),
              )
            ]
          ),
        ),
      ),
    );
  }

  // String formatDateTime(date) {
  //   String formattedDateTime = DateFormat('dd/MM/yyyy HH:mm').format(date);
  //   return formattedDateTime;
  // }
}
