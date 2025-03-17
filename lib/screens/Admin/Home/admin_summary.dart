import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:system_for_collecting_points_from_plastic_waste/services/api-service.dart';
import 'package:system_for_collecting_points_from_plastic_waste/widget/SummaryWidget.dart';

class AdminSummaryPage extends StatefulWidget {
  const AdminSummaryPage({super.key});

  @override
  State<AdminSummaryPage> createState() => _AdminSummaryPageState();
}

String? selectedProgram;
String? selectedAcademicYear;

final List<String> programItem = ['วิศวกรรมศาสตร์', 'บริหารธุรกิจ'];
final List<String> academicYearItem = [
  'ปีการศึกษา 2567',
  'ปีการศึกษา 2568',
  'ปีการศึกษา 2569',
  'ปีการศึกษา 2570'
];

double approvedProgress = 0.0;
double pendingProgress = 0.0;
double rejectedProgress = 0.0;
int stationery = 0;
int affective_score = 0;
int certificate = 0;

class _AdminSummaryPageState extends State<AdminSummaryPage> {
  List<SummaryWidget> summary = [];
  bool isLoading = true;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchSummary();
  }

  Future<void> fetchSummary() async {
  try {
    // Fetch data from the API
    Map<String, dynamic> data = await apiService.getSummary();
    print("Fetched Data: $data"); // Debug log

    var approvalProgress = data['approvalProgress'] as List?;
    if (approvalProgress == null || approvalProgress.isEmpty) {
      print('No approval progress data');
      return;
    }

    // Assign the fetched data to the state variables
    setState(() {
      approvedProgress = approvalProgress[0] / 100;
      pendingProgress = approvalProgress.length > 1 ? approvalProgress[1] / 100 : 0.0;
      rejectedProgress = approvalProgress.length > 2 ? approvalProgress[2] / 100 : 0.0;

      stationery = int.parse(data['stationeryCount'].toString());
      affective_score = int.parse(data['affectiveScoreCount'].toString());
      certificate = int.parse(data['certificateCount'].toString());

      summary = [
        SummaryWidget(
          approvedProgress: approvedProgress,
          pendingProgress: pendingProgress,
          rejectedProgress: rejectedProgress,
          stationery: stationery,
          affective_score: affective_score,
          certificate: certificate,
        ),
      ];

      isLoading = false;  // Mark loading complete
    });
  } catch (e) {
    print('Error fetching summary: $e');
    setState(() {
      isLoading = false;  // Handle error by stopping loading indicator
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00154B),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppBar(
              toolbarHeight: 70,
              backgroundColor: Color(0xff00154B),
              leading: IconButton(
                icon: FaIcon(FontAwesomeIcons.angleLeft, color: Colors.white),
                // icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                'ข้อมูลสรุประบบทั้งหมด',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffEAEAEA),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(35),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 190,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Color(0xFFD9D9D9),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: DropdownButton<String>(
                                  value: selectedProgram,
                                  hint: Center(
                                    child: Text("เลือกหลักสูตร",
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                  isExpanded: true,
                                  icon: Padding(
                                    padding: const EdgeInsets.only(
                                        right:
                                            10.0), // Add padding to the arrow
                                    child: FaIcon(FontAwesomeIcons
                                        .chevronDown), // Using FontAwesome icon
                                  ),
                                  iconSize: 16,
                                  elevation: 16,
                                  style: TextStyle(color: Colors.black),
                                  underline: SizedBox.shrink(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedProgram = newValue;
                                    });
                                  },
                                  items: programItem
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Center(
                                        child: Text(
                                            value), // Center the dropdown text
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              Container(
                                width: 150,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Color(0xFFD9D9D9),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: DropdownButton<String>(
                                  value: selectedAcademicYear,
                                  hint: Center(
                                    child: Text("ปีการศึกษา",
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                  isExpanded: true,
                                  icon: Padding(
                                    padding: const EdgeInsets.only(
                                        right:
                                            10.0), // Add padding to the arrow
                                    child: FaIcon(FontAwesomeIcons
                                        .chevronDown), // Using FontAwesome icon
                                  ),
                                  iconSize: 16,
                                  elevation: 16,
                                  style: TextStyle(color: Colors.black),
                                  underline: SizedBox.shrink(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedAcademicYear = newValue;
                                    });
                                  },
                                  items: academicYearItem
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Center(
                                        child: Text(
                                            value), // Center the dropdown text
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9), // Background color
                              borderRadius:
                                  BorderRadius.circular(16), // Rounded corners
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // "อนุมัติ" (Approved)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('อนุมัติ (Approved)',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                      Text(
                                          '${(approvedProgress * 100).toStringAsFixed(0)}%',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black)),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  LinearProgressIndicator(
                                    value: approvedProgress,
                                    backgroundColor: Color(0xFFD9D9D9),
                                    color: Colors.green,
                                    minHeight: 10,
                                  ),
                                  SizedBox(height: 10),

                                  // "กำลังรอ" (Pending)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('กำลังรอ (Pending)',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                      Text(
                                          '${(pendingProgress * 100).toStringAsFixed(0)}%',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black)),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  LinearProgressIndicator(
                                    value: pendingProgress,
                                    backgroundColor: Color(0xFFD9D9D9),
                                    color: Colors.orange,
                                    minHeight: 10,
                                  ),
                                  SizedBox(height: 10),

                                  // "ปฏิเสธ" (Rejected)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('ปฏิเสธ (Rejected)',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                      Text(
                                          '${(rejectedProgress * 100).toStringAsFixed(0)}%',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black)),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  LinearProgressIndicator(
                                    value: rejectedProgress,
                                    backgroundColor: Color(0xFFD9D9D9),
                                    color: Colors.red,
                                    minHeight: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9), // Background color
                              borderRadius:
                                  BorderRadius.circular(16), // Rounded corners
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // "อนุมัติ" (Approved)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'อุปกรณ์การเรียน', // Title
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        '${stationery} ชิ้น', // Display the percentage
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: double.infinity,
                                    height: 1,
                                    color: Color(0xFFD9D9D9), // Line separator
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'คะแนนจิตพิสัย', // Title
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        '${affective_score} คน', // Display the percentage
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: double.infinity,
                                    height: 1,
                                    color: Color(0xFFD9D9D9), // Line separator
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'เกียรติบัตร', // Title
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        '${certificate} ใบ', // Display the percentage
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
