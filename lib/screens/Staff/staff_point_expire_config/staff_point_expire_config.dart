import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:system_for_collecting_points_from_plastic_waste/services/api-service.dart';

class StaffPointExpireConfig extends StatefulWidget {
  const StaffPointExpireConfig({super.key});

  @override
  State<StaffPointExpireConfig> createState() => _StaffPointExpireConfigState();
}

class _StaffPointExpireConfigState extends State<StaffPointExpireConfig> {
  TextEditingController dateController = TextEditingController();
  final ApiService apiService = ApiService();
  String expireDate = '';

  @override
  void initState() {
    super.initState();
    _loadExpireDate();
  }

 Future<void> _loadExpireDate() async {
  String? fetchedDate = await apiService.fetchPointExpire();
  if (fetchedDate != null) {
    setState(() {
      expireDate = fetchedDate;
      dateController.text = fetchedDate; // Keep controller updated if needed elsewhere.
    });
  }
}

  // For updating:
  void _updateExpireDate() async {
    bool success = await apiService.updatePointExpire(dateController.text);
    if (success) {
      _loadExpireDate();
    }
}


  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        dateController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff00154B),
      appBar: AppBar(
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.angleLeft, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color(0xff00154B),
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'กำหนดวันหมดอายุ\nของแต้ม',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
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
              const SizedBox(height: 15),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffEAEAEA),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(35),
                        topLeft: Radius.circular(35)),
                  ),
                  child: Column(
                    children: [
                      // Display current point expiration date
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(35),
                              topLeft: Radius.circular(35)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'วันหมดอายุของแต้มปัจจุบัน',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(height: 20),
                                Text(
                                  expireDate.isNotEmpty ? expireDate : "กำลังโหลด...",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Section for updating the point expiration date
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          child: Column(
                            children: [
                              const Text(
                                'อัปเดทวันหมดอายุของแต้ม',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(height: 30),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: TextField(
                                  controller: dateController,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    labelText: "Select Date",
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.calendar_today),
                                      onPressed: () => _selectDate(context),
                                    ),
                                    border: const OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              InkWell(
                                onTap: () {
                                  _updateExpireDate();
                                },
                                child: Container(
                                  width: 100,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff4AAF50),
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(10),
                                        bottom: Radius.circular(10)),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromARGB(255, 66, 156, 72),
                                        spreadRadius: 1,
                                        blurRadius: 0,
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "ยืนยัน",
                                      style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.2,
                                      ),
                                    ),
                                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}
