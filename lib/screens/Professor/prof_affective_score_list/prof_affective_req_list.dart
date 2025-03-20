
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Professor/prof_affective_score_list/prof_affective_req_details.dart';
import 'package:system_for_collecting_points_from_plastic_waste/widget/prof_affective_score_widget.dart';
import 'package:system_for_collecting_points_from_plastic_waste/services/api-service.dart';

class ProfessorAffectiveReqListScreen extends StatefulWidget {
  const ProfessorAffectiveReqListScreen({super.key});

  @override
  State<ProfessorAffectiveReqListScreen> createState() => _ProfessorAffectiveReqListScreenState();
}

class _ProfessorAffectiveReqListScreenState extends State<ProfessorAffectiveReqListScreen> {
 List<ProfessorAffectiveReqListWidget> affectiveReqList = [];
  bool isLoading = true;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    try {
      List<Map<String, dynamic>> data = await apiService.getProffessorAffectiveReqList();
      setState(() {
        affectiveReqList = data.map((item) {
          return ProfessorAffectiveReqListWidget(
            requestId: item['request_id'],
            e_passport: item['e_passport'],
            fullname: "${item['firstname']} ${item['lastname']}",
            faculty: item['facname'],
            department: item['depname'],
            subject: item['reward_name'],
            points: item['points_required'],
            itemQuantity: 1,
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
                              IconButton(
                                onPressed: () {},
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
                        child: isLoading
                            ? Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                itemCount: affectiveReqList.length,
                                itemBuilder: (context, index) {
                                  final item = affectiveReqList[index];
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
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfAffectiveScoreDetailsScreen(item: item),
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
    String formattedDateTime = DateFormat('dd/MM/yyyy HH:mm').format(date);
    return formattedDateTime;
  }



}
