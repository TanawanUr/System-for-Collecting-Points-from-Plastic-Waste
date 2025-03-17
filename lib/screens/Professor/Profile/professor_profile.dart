import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/login.dart';
import 'package:system_for_collecting_points_from_plastic_waste/services/api-service.dart';

class ProfessorProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const ProfessorProfilePage({super.key, required this.userData});

  @override
  State<ProfessorProfilePage> createState() => _ProfessorProfilePageState();
}

class _ProfessorProfilePageState extends State<ProfessorProfilePage> {
  final ApiService apiService = ApiService();
  Map<String, dynamic>? userData;

   @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    try {
      Map<String, dynamic> details = await apiService.getUserDetails(widget.userData['ePassport']);
      setState(() {
        userData = details;
      });
    } catch (e) {
      print("Error fetching user details: $e");
    }
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(35),
                ),
                color: Color(0xff00154B)),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.angleLeft,
                              color: Colors.white, size: 25),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: SizedBox(
                            height: 150,
                            width: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image(
                                image: AssetImage(
                                    "assets/images/person/nattapon_noorit.png"),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:15, right: 15, bottom: 20),
                    child: Column(
                      children: [
                        Text(
                           '${widget.userData['firstname']} ${widget.userData['lastname']}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.w700,
                            height: 1.7,
                            letterSpacing: -0.5,
                          ),
                        ),
                        Text(
                          "อาจารย์",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  // InkWell(
                  //   onTap: () {
                  //     // Navigator.push(
                  //     //   context,
                  //     //   MaterialPageRoute(
                  //     //       builder: (context) => const BottomNavBar()),
                  //     // );
                  //   },
                  //   child: Container(
                  //     width: 360,
                  //     height: 50,
                  //     child: Center(
                  //         child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Text(
                  //           'ตั้งค่า',
                  //           style: TextStyle(
                  //             color: Colors.black,
                  //             fontSize: 22,
                  //             fontWeight: FontWeight.w800,
                  //             letterSpacing: -0.2,
                  //           ),
                  //         ),
                  //       ],
                  //     )),
                  //     decoration: BoxDecoration(
                  //         color: Color(0xffffffff),
                  //         shape: BoxShape.rectangle,
                  //         borderRadius: BorderRadius.vertical(
                  //             top: Radius.circular(10),
                  //             bottom: Radius.circular(10)),
                  //         boxShadow: [
                  //           BoxShadow(
                  //             color: Color.fromARGB(63, 0, 0, 0),
                  //             spreadRadius: 0,
                  //             blurRadius: 5,
                  //             offset: const Offset(0, 1),
                  //           )
                  //         ]),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  InkWell(
                    onTap: () => _logout(context),
                    child: Container(
                      width: 360,
                      height: 50,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'ออกจากระบบ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      )),
                      decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10),
                              bottom: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(63, 0, 0, 0),
                              spreadRadius: 0,
                              blurRadius: 5,
                              offset: const Offset(0, 1),
                            )
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xffEAEAEA),
    );
  }
}
